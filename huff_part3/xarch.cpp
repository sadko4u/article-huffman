////////////////////////////////////////////////////////////////////
//
// File:
//    \utils\xarch\xarch.cpp
//
// Version:
//    0.4
//
// Description:
//    XSystem Archiver. Uses Huffman Compression.
//
// Author:
//    Sadovnikov Vladimir
//
// Copyright(s):
//    (C) SadKo (Sadovnikov And Company)
//    (C) XSystem Kernel Team
//
////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <conio.h>

// Определение типов данных
#ifdef __MSDOS__
    typedef unsigned char   BYTE;
    typedef unsigned int    WORD;
    typedef unsigned long   DWORD;
#else
    typedef unsigned char   BYTE;
    typedef unsigned short  WORD;
    typedef unsigned int    DWORD;
#endif

// Описатель узла
typedef struct TTable
{
    int        ch;
    TTable    *left;
    TTable    *right;
} TTable;

// Структура для подсчёта частоты символа
typedef struct TFreq
{
    int        ch;
    TTable    *table;
    DWORD      freq;
} TFreq;

// Описатель кодового символа
typedef struct TOpcode
{
    DWORD      opcode;
    DWORD      len;
} TOpcode;

// Частоты и коды
TFreq       Freq[256];
TOpcode     Opcodes[256];

// Файлы ввода-вывода
FILE *in, *out, *assemb;

// Счётчик битов
int         OutBits;
// Выводимый символ
BYTE        OutChar;

// Подсчёт частот символов
int CountFrequency(void)
{
    int i;              // переменная цикла
    int count=0;        // вторая переменная цикла
    DWORD TotalCount=0; // размер файла.

    // Инициализация структур
    for (i=0; i<256; i++)
    {
        Freq[i].freq=0;
        Freq[i].table=0;
        Freq[i].ch=i;
    }

    // Подсчёт частот символов (посимвольно)
    while (!feof(in)) // пока не достигнут конец файла
    {
        i=fgetc(in);
        if (i!=EOF)   // если не конец файла
        {
            Freq[i].freq++; // частота ++
            TotalCount++;   // размер  ++
        }
    }

    // "Сообщаем" распаковщику размер файла
    fprintf(assemb, "coded_file_size:\n    dd  %08lxh\n\n", TotalCount);

    // Смещаем все неиспользуемые символы в конец
    i=0;
    count=256;
    while (i<count)    // пока не достигли конца
    {
        if (Freq[i].freq==0) // если частота 0
            Freq[i]=Freq[--count]; // то копируем запись из конца
        else
            i++; // всё ОК - двигаемся дальше.
    }

    // Выделяем память под узлы
    for (i=0; i<count; i++)
    {
        Freq[i].table=new TTable;     // создаём узел
        Freq[i].table->left=0;        // без соединений
        Freq[i].table->right=0;       // без соединений
        Freq[i].table->ch=Freq[i].ch; // копируем символ
        Freq[i].freq=Freq[i].freq;    // и частоту
    }

    return count;
}

// поиск узла с наименьшей вероятностью.
int FindLeast(int count, int index)
{
    int i;
    DWORD min=(index==0) ? 1 : 0; // элемент, который считаем
                                  // минимальным
    for (i=1; i<count; i++)       // цикл по массиву
    {
        if (i!=index)             // если элемент не исключён
            if (Freq[i].freq<Freq[min].freq) // сравниваем
                min=i;            // меньше минимума - запоминаем
    }
    return min;                   // возвращаем индекс минимума
}

// Функция построения дерева
void PreInit(int count)
{
    int ind1, ind2; // индексы элементов
    TTable *table;  // указатель на "новый узел"

    while (count>1) // цикл, пока не достигли корня 
    {
        ind1=FindLeast(count,-1);       // первый узел
        ind2=FindLeast(count,ind1);     // второй узел

        table=new TTable;               // создаём новый узел
        table->ch=-1;                   // не конечный
        table->left=Freq[ind1].table;   // 0 - узел 1
        table->right=Freq[ind2].table;  // 1 - узел 2

        Freq[ind1].ch=-1;               // модифицируем запись о
        Freq[ind1].freq+=Freq[ind2].freq; // частоте для символа
        Freq[ind1].table=table;         // и пишем новый узел

        if (ind2!=(--count))            // если ind2 не последний
            Freq[ind2]=Freq[count];     // то на его место
                                        // помещаем последний в массиве
    }
}

// Функция рекурсивного обхода дерева
void RecurseMake(TTable *tbl, DWORD opcode, int len)
{
    fprintf(assemb,"opcode%08lx_%04x:\n",opcode,len); // метку в файл
    
    if (tbl->ch!=-1)            // узел конечный
    {
        BYTE mod=32-len;        
        Opcodes[tbl->ch].opcode=(opcode>>mod); // сохраняем код
        Opcodes[tbl->ch].len=len;              // и его длину (в битах)
        // и создаём соответствующую метку
        fprintf(assemb,"    db  %03xh,0ffh,0ffh,0ffh\n\n",tbl->ch);
    }
    else                        // узел не конечный
    {
        opcode>>=1;             // освобождаем место под новый бит
        len++;                  // увеличиваем длину кодового слова
        // делаем ссылки на метки символов
        fprintf(assemb,"    dw  opcode%08lx_%04x\n",opcode,len);
        fprintf(assemb,"    dw  opcode%08lx_%04x\n\n",opcode|0x80000000,len);
        // Рекурсивный вызов
        RecurseMake(tbl->left,opcode,len);
        RecurseMake(tbl->right,opcode|0x80000000,len);
    }
    // удаляем узел (он уже не нужен)
    delete tbl;
}

// Соханить код
void PutCode(int ch)
{
    int len;
    int outcode;
    
    // получаем длину кодового слова и само кодовое слово
    outcode=Opcodes[ch].opcode;   // кодовое слово
    len=Opcodes[ch].len;          // длина (в битах)
    
    while (len>0)                 // выводим побитно
    {
        // Цикл пока переменная OutBits занята не полностью
        while ((OutBits<8) && (len>0))
        {
            OutChar>>=1;               // освобождаем место
            OutChar|=((outcode&1)<<7); // и в него помещаем бит
            outcode>>=1;               // следующий бит кода
            len--;                     // уменьшаем длину
            OutBits++;                 // количество битов выросло
        }
        // если используются все 8 бит, то сохраняем их в файл
        if (OutBits==8)
        {
            fputc(OutChar,out);     // сохраняем в файл
            OutBits=0;              // обнуляем
            OutChar=0;              // параметры
        }
    }
}

// "Очистка" буфера битов
void EndPut(void)
{
    // Если в буфере есть биты
    if (OutBits!=0)
    {
        OutChar>>=8-OutBits;        // сдвигаем
        fputc(OutChar,out);         // и сохраняем в файле
    }
}

// Создание сжатого файла
void MakeFile(void)
{
    int count;
    int ch;
 
    // выписать все элементы в столбик и приписать вероятности
    count=CountFrequency();
    // построить дерево
    PreInit(count);
    // записать кодовую таблицу символов
    RecurseMake(Freq[0].table,0,0);

    // закодировать по кодовой таблице исходные данные
    fseek(in,0,SEEK_SET);
    OutChar=0;
    OutBits=0;
    while ((ch=fgetc(in))!=EOF)
        PutCode(ch);
    EndPut();  // "очистить буфер"
}

// Ахтунг! Главная функция!
void main(int argc, char *argv[])
{
    if (argc==4)
    {
        // поочереди открываем/закрываем файлы
        if ((in=fopen(argv[1],"rb+"))!=0)
        {
            if ((out=fopen(argv[2],"wb+"))!=0)
            {
                if ((assemb=fopen(argv[3],"wb+"))!=0)
                {
                    // дошли до момента, когда можно делать код
                    MakeFile();
                    fclose(assemb);
                    printf("Compressed successful\n");
                }
                else
                    printf("Can't open assembler table file %s\n",argv[3]);
                fclose(out);
            }
            else
                printf("Can't create file %s\n",argv[2]);
            fclose(in);
        }
        else
            printf("Can't open file %s\n",argv[1]);
    }
    else
        printf("Usage: XARCH source output asm-file");
}
