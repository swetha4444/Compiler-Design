#include<stdio.h>
#include<string.h>
#include<stdlib.h>

/* STRUCTUERE */
typedef struct
{
    char ip[100];
    int n;
}input;

/* FUNCTIONS */
void E(input *in);
void T(input *in);
void Tprime(input *in);
void Eprime(input *in);
void F(input *in);

/* DEFINED FUNCTIONS */
void E(input *in)
{
  T(in);
  Eprime(in);
}

void Eprime(input *in)
{
  if(in->ip[in->n]=='+')
  {
    (in->n)++;
      T(in);
      Eprime(in);
  }
  else if(in->ip[in->n]=='-')
  {
    (in->n)++;
      T(in);
      Eprime(in);
  }
  else
    return;
}

void T(input *in)
{
  F(in);
  Tprime(in);
}

void Tprime(input *in)
{
  if(in->ip[in->n]=='*')
  {
    (in->n)++;
      F(in);
      Tprime(in);
  }
  else if(in->ip[in->n]=='/')
  {
    (in->n)++;
      F(in);
      Tprime(in);
  }
  else
    return;
}

void F(input *in)
{ 
    if(in->ip[in->n]=='(')
    {
        (in->n)++;
        E(in);
        if(in->ip[in->n]==')')
        {
            (in->n)++;
            if(in->n==strlen(in->ip))
            {
                printf("Parsing Complete string accepted\n");
                exit(0);
            }
        } 
    }
    else if(in->ip[in->n]=='i' && in->ip[in->n+1]=='d')
    {
        (in->n)+=2;
        if(in->n==strlen(in->ip))
        {
        printf("Parsing Complete string accepted\n");
        exit(0);
        }
    }
    else
    {
        printf("Parsing error: String not accepted\n");
        exit(0);
    }
}

/* MAIN FUNCTION */
int main()
{
  input *in = malloc(sizeof(input));
  printf("Enter the String to be parsed: ");
  scanf("%s",in->ip);
  in->n = 0;
  E(in);

  if(in->n!=strlen(in->ip))
    printf("Parser Error : String not accepted\n");
}