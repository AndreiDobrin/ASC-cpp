#include <iostream>
#include <fstream>

using namespace std;

int v[8][8];

ifstream fin("bidim.fin");

void add(int &n, int v[][8]){
    int i,j;
    int nr,descr,dim;
    fin>>nr;
    int ok,copie,pos1;
    
    while(nr>0){
        fin >> descr;
        fin >> dim;
        ok=0;
        pos1=0;
        i=j=0;


        if(dim % 8 != 0)
                    dim=dim/8+1;
                else
                    dim=dim/8;

        
            // trece la un loc liber
            while(v[i][j]!=0 && i<8){
                if(j > 7){
                    i++;
                    j=0;
                }
                j++;
            }
            //vede daca e destul loc liber pentru a insera caca
            while(i<8 && ok==0){
                pos1=j;
                if(dim<=8-j)
                    ok=1;
                else{
                    j=0;
                    i++;
                }
            }
            //daca e destul loc liber, insereaza
            if(ok==1){
                while(dim>0){
                    v[i][pos1++]=descr;
                    dim--;
                }
            }
            nr--;
        }

    }

void del(int &n, int v[][8]){
    int i,j,descr;
    fin >> descr;
    int ok=0;
    for(i=0;i<8;i++)
        for(j=0;j<8;j++)
            if(v[i][j]==descr){
                while(v[i][j]==descr){
                    v[i][j]=0;
                    break;
            }
        }
}


void defrag(int &n, int v[][8]){
    int i,j;
    int ok1,ok2;
    int spatiu_gol;
    int pos1,count0;
    for(i=0;i<8;i++){
        for(j=0;j<8;j++){
            count0=0;
            if(v[i][j]==0){
                pos1=j;
                while(v[i][j]==0 && j<8){
                    j++;
                }
                if(j<8){
                while(j<8){
                    v[i][pos1++]=v[i][j];
                    v[i][j++]=0;
                }
                }
            }
        }
    }
    //dupa ce trece prin tot si face defrag pe linii, zic ca mai trece o data
    //si verifica daca sunt spatii disponibile
    int ok=0; //daca au fost facute modificari, mai trece o data ca sa ma asigur ca nu raman spatii goale
    int spatiu;
    while(ok==0){

    for(i=0;i<8;i++)
        spatiu=0;
        for(j=0;j<8;j++){
            while(v[i][j]!=0)
                j++;
            spatiu=8-j;

        }
    }
}




void show(int &n, int v[][8]){
    int i,j;
    for(i=0;i<8;i++){
        for(j=0;j<8;j++)
            cout<<v[i][j]<<' ';
        cout<<endl;
}
}

int main(){
    int instr, nrinstr, i,n=8;
    fin >> nrinstr;

    while(nrinstr > 0){
        fin >> instr;

        if(instr == 1){
            add(n,v);
        }
        if(instr == 5)
            show(n,v);
        if(instr == 2)
            del(n,v);
        if(instr == 3)
            defrag(n,v);
            
        nrinstr--;
    }
}