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

// ����������� ����� ������
#ifdef __MSDOS__
    typedef unsigned char   BYTE;
    typedef unsigned int    WORD;
    typedef unsigned long   DWORD;
#else
    typedef unsigned char   BYTE;
    typedef unsigned short  WORD;
    typedef unsigned int    DWORD;
#endif

// ��������� ����
typedef struct TTable
{
    int        ch;
    TTable    *left;
    TTable    *right;
} TTable;

// ��������� ��� �������� ������� �������
typedef struct TFreq
{
    int        ch;
    TTable    *table;
    DWORD      freq;
} TFreq;

// ��������� �������� �������
typedef struct TOpcode
{
    DWORD      opcode;
    DWORD      len;
} TOpcode;

// ������� � ����
TFreq       Freq[256];
TOpcode     Opcodes[256];

// ����� �����-������
FILE *in, *out, *assemb;

// ������� �����
int         OutBits;
// ��������� ������
BYTE        OutChar;

// ������� ������ ��������
int CountFrequency(void)
{
    int i;              // ���������� �����
    int count=0;        // ������ ���������� �����
    DWORD TotalCount=0; // ������ �����.

    // ������������� ��������
    for (i=0; i<256; i++)
    {
        Freq[i].freq=0;
        Freq[i].table=0;
        Freq[i].ch=i;
    }

    // ������� ������ �������� (�����������)
    while (!feof(in)) // ���� �� ��������� ����� �����
    {
        i=fgetc(in);
        if (i!=EOF)   // ���� �� ����� �����
        {
            Freq[i].freq++; // ������� ++
            TotalCount++;   // ������  ++
        }
    }

    // "��������" ������������ ������ �����
    fprintf(assemb, "coded_file_size:\n    dd  %8lxh\n\n", TotalCount);

    // ������� ��� �������������� ������� � �����
    i=0;
    count=256;
    while (i<count)    // ���� �� �������� �����
    {
        if (Freq[i].freq==0) // ���� ������� 0
            Freq[i]=Freq[--count]; // �� �������� ������ �� �����
        else
            i++; // �� �� - ��������� ������.
    }

    // �������� ������ ��� ����
    for (i=0; i<count; i++)
    {
        Freq[i].table=new TTable;     // ������ ����
        Freq[i].table->left=0;        // ��� ����������
        Freq[i].table->right=0;       // ��� ����������
        Freq[i].table->ch=Freq[i].ch; // �������� ������
        Freq[i].freq=Freq[i].freq;    // � �������
    }

    return count;
}

// ����� ���� � ���������� ������������.
int FindLeast(int count, int index)
{
    int i;
    DWORD min=(index==0) ? 1 : 0; // �������, ������� �������
                                  // �����������
    for (i=1; i<count; i++)       // ���� �� �������
    {
        if (i!=index)             // ���� ������� �� ��������
            if (Freq[i].freq<Freq[min].freq) // ����������
                min=i;            // ������ �������� - ����������
    }
    return min;                   // ���������� ������ ��������
}

// ������� ���������� ������
void PreInit(int count)
{
    int ind1, ind2; // ������� ���������
    TTable *table;  // ��������� �� "����� ����"

    while (count>1) // ����, ���� �� �������� ����� 
    {
        ind1=FindLeast(count,-1);       // ������ ����
        ind2=FindLeast(count,ind1);     // ������ ����

        table=new TTable;               // ������ ����� ����
        table->ch=-1;                   // �� ��������
        table->left=Freq[ind1].table;   // 0 - ���� 1
        table->right=Freq[ind2].table;  // 1 - ���� 2

        Freq[ind1].ch=-1;               // ������������ ������ �
        Freq[ind1].freq+=Freq[ind2].freq; // ������� ��� �������
        Freq[ind1].table=table;         // � ����� ����� ����

        if (ind2!=(--count))            // ���� ind2 �� ���������
            Freq[ind2]=Freq[count];     // �� �� ��� �����
                                        // �������� ��������� � �������
    }
}

// ������� ������������ ������ ������
void RecurseMake(TTable *tbl, DWORD opcode, int len)
{
    fprintf(assemb,"opcode%08lx_%04x:\n",opcode,len); // ����� � ����
    
    if (tbl->ch!=-1)            // ���� ��������
    {
        BYTE mod=32-len;        
        Opcodes[tbl->ch].opcode=(opcode>>mod); // ��������� ���
        Opcodes[tbl->ch].len=len;              // � ��� ����� (� �����)
        // � ������ ��������������� �����
        fprintf(assemb,"    db  %03xh,0ffh,0ffh,0ffh\n\n",tbl->ch);
    }
    else                        // ���� �� ��������
    {
        opcode>>=1;             // ����������� ����� ��� ����� ���
        len++;                  // ����������� ����� �������� �����
        // ������ ������ �� ����� ��������
        fprintf(assemb,"    dw  opcode%08lx_%04x\n",opcode,len);
        fprintf(assemb,"    dw  opcode%08lx_%04x\n\n",opcode|0x80000000,len);
        // ����������� �����
        RecurseMake(tbl->left,opcode,len);
        RecurseMake(tbl->right,opcode|0x80000000,len);
    }
    // ������� ���� (�� ��� �� �����)
    delete tbl;
}

// �������� ���
void PutCode(int ch)
{
    int len;
    int outcode;
    
    // �������� ����� �������� ����� � ���� ������� �����
    outcode=Opcodes[ch].opcode;   // ������� �����
    len=Opcodes[ch].len;          // ����� (� �����)
    
    while (len>0)                 // ������� �������
    {
        // ���� ���� ���������� OutBits ������ �� ���������
        while ((OutBits<8) && (len>0))
        {
            OutChar>>=1;               // ����������� �����
            OutChar|=((outcode&1)<<7); // � � ���� �������� ���
            outcode>>=1;               // ��������� ��� ����
            len--;                     // ��������� �����
            OutBits++;                 // ���������� ����� �������
        }
        // ���� ������������ ��� 8 ���, �� ��������� �� � ����
        if (OutBits==8)
        {
            fputc(OutChar,out);     // ��������� � ����
            OutBits=0;              // ��������
            OutChar=0;              // ���������
        }
    }
}

// "�������" ������ �����
void EndPut(void)
{
    // ���� � ������ ���� ����
    if (OutBits!=0)
    {
        OutChar>>=8-OutBits;        // ��������
        fputc(OutChar,out);         // � ��������� � �����
    }
}

// �������� ������� �����
void MakeFile(void)
{
    int count;
    int ch;
 
    // �������� ��� �������� � ������� � ��������� �����������
    count=CountFrequency();
    // ��������� ������
    PreInit(count);
    // �������� ������� ������� ��������
    RecurseMake(Freq[0].table,0,0);

    // ������������ �� ������� ������� �������� ������
    fseek(in,0,SEEK_SET);
    OutChar=0;
    OutBits=0;
    while ((ch=fgetc(in))!=EOF)
        PutCode(ch);
    EndPut();  // "�������� �����"
}

// ������! ������� �������!
void main(int argc, char *argv[])
{
    if (argc==4)
    {
        // ��������� ���������/��������� �����
        if ((in=fopen(argv[1],"rb+"))!=0)
        {
            if ((out=fopen(argv[2],"wb+"))!=0)
            {
                if ((assemb=fopen(argv[3],"wb+"))!=0)
                {
                    // ����� �� �������, ����� ����� ������ ���
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
