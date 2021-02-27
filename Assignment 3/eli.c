#include<stdio.h>
#include<string.h>

/* FUNCTIONS */
char getNT(char a[]);
int getProductionRHS(char a[],char prodRHS[100][100]);
int isLR(char nt,char prodRHS[100][100],int n);

//---------------------------------------------------------------------------------------------------------------------------

void main()
{
    char a[50][100];
    int n,flag=0;

    printf("Enter the number of productions in the grammar: ");
    scanf("%d",&n);

    for(int i = 0; i<n;i++)
    {
        printf("Enter Production-%d:  ",i+1);
        scanf("%s",a[i]);
    }

    for(int i = 0;i<n;i++)
    {
        char nt[5];
        char prodRHS[100][100];
        int k;
        nt[0] = getNT(a[i]);
        nt[1] = '\0';
        k = getProductionRHS(a[i],prodRHS);
        if(isLR(nt[0],prodRHS,k))
        {
            printf("%s is LR\n",a[i]);
            flag=1;
        }
        else
             printf("%s\n",a[i]);
    }

    if(flag == 1)
        printf("\n\t\t GRAMMAR IS LR\n");
    else
        printf("\n\t\t GRAMMAR IS GOOD TO GO\n");
}

//--------------------------------------------------------------------------------------------------------------------------------------

/* DEFINED FUNCTIONS */

char getNT(char a[])
{
  return a[0];
}


int getProductionRHS(char a[],char prodRHS[100][100])
{
  int i = 0;
  while(a[i]!='>') i++; //RHS
  int k = 0,t = 0,j = 0;
  char temp[100];
  while(a[i]!='\0'){
    i++;
    if(a[i]=='|'||a[i]=='\0'){
      temp[j] = '\0';
      strcpy(prodRHS[k++],temp);
      j =0;
      temp[j] = '\0';
    }
    else{
      temp[j++] = a[i];
    }
  }
  return k;
}

int isLR(char nt,char prodRHS[100][100],int n)
{
  for(int i = 0;i<n;i++)
  {
    if(prodRHS[i][0]==nt) 
        return 1;
  }
  return 0;
}