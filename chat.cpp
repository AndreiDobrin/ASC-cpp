//de tratat cazul in care nu sunt adaugate bine variabilele
//add 5
//add 5 3
// *no bueno*
#include <iostream>
using namespace std;
#include <cstring>
#include <fstream>

ifstream fin("info.fin");

int v[1024];
void add(int &n, int v[]){
    int ok=0;
    int nr;
    int pos1=0, pos2=0;
    int k=0;
    int descr,dim;
    int i1=0,i2=0;
        //numarul de fisiere
        fin>>nr;
        while(nr>0){
            //descriptor
            fin>>descr;
            //dimensiunea
            fin>>dim;
            k=0;
            if(dim%8==0) //daca se imparte exact, se compenseaza pentru ca in for am pus +1 pentru aproximare cu adaos
                k=1;
            while(k<dim/8+1){
                v[i2++] = descr;
                k++;
            }
            nr--;
            cout<<descr<<": ("<<i1<<", "<<i2-1<<")\n";
            i1=i2;
        }

        
}

void get(int &n, int v[]){
    int x,i=0;
    int pos1=0,pos2=0;
    fin>>x;
    while(v[i]!=x && i<n)
        i++;

    if(v[i]==x){
    pos1 = i;
    while(v[i]==x)
        i++;
    pos2 = i-1;
    }
    cout<<'('<<pos1<<", "<<pos2<<')'<<endl;
}


void del(int &n, int v[]){
    int x,i=0;
    fin>>x;
    while(v[i]!=x && i<n){
        i++;
    }
    if(i!=n){
        while(v[i]==x)
            v[i++]=0;
    }
    int pos1=0;
    int pos2;
    i=0;
    while(i<n){
        //if(v[i]!=0){
            while(v[i]==v[i+1])
                i++;
            pos2=i;
        if(v[i]!=0)
            cout<<v[i]<<": ("<<pos1<<", "<<pos2<<")\n";
        i++;;
        pos2++;
        pos1=pos2;
    }
    }


void defrag(int &n, int v[]){
    int i = 0;
    int pos1,pos2;
    int aux,ok;
    int j = 0;
    while(i<n){
        ok = 0;

        if(v[i] == 0)
        {

            for(int k=i;k<n;k++)
                if(v[k]!=0){
                    ok = 1;
                    break;
                }
            
            if(ok==1){
                pos1 = i;
                while(v[i]==0)
                    i++;
                pos2 = i;
                j = pos2-pos1;
                while(j>=0){
                    aux=v[pos1];
                    v[pos1]=v[pos2];
                    v[pos2]=aux;
                    pos1++;
                    pos2++;
                    j--;
                }
            }
        }
        i++;
    }
    pos1=0;
    pos2;
    i=0;
    while(i<n){
        //if(v[i]!=0){
            while(v[i]==v[i+1])
                i++;
            pos2=i;
        if(v[i]!=0)
            cout<<v[i]<<": ("<<pos1<<", "<<pos2<<")\n";
        i++;
        pos2++;
        pos1=pos2;
    }
}


int main() {
    char s[30];
    int n=1024;

    for(int i=0;i<10;i++)
    v[i]=0;
    int x,y;
    int inst;
    int i;
    int nr;
    fin>>nr;
    while(nr>0){
        cout<<endl;
        fin>>inst;
        if(inst==1)
            add(n,v);
        
        else if(inst==5){
            for(int i=0;i<10;i++)
                cout<<v[i]<<" ";
            cout<<endl;
        }
        else if(inst==2){
            get(n,v);
        }
        else if(inst==3){
            del(n,v);
        }
        else if(inst==4){
            defrag(n,v);
        }
        nr--;
        
    //for(int i=0;i<10;i++)
     //   cout<<v[i]<<" ";
    //cout<<endl;
    }
    fin.close();
    return 0;
}