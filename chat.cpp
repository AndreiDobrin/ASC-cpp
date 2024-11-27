//de tratat cazul in care nu sunt adaugate bine variabilele
//add 5
//add 5 3
// *no bueno*
#include <iostream>
using namespace std;
#include <cstring>

void add(int &n, int v[]){
    int ok=0;
    int nr;
    int pos1=0, pos2=0;
    int k=0;
    int descr,dim;
    int i1=0,i2=0;
        cin>>nr;
        while(nr>0){
            cin>>descr;
            cin>>dim;

            for(k=0;k<dim/8+1;k++){
                v[i2++] = descr;
            }
            nr--;
            cout<<descr<<": ("<<i1<<','<<i2-1<<")\n";
            i1=i2;
        }

        
}

void get(int &n, int v[]){
    int x,i=0;
    int pos1,pos2;
    cin>>x;
    while(v[i]!=x && i<n)
        i++;
    if(i==n)
        cout<<"Nu exista acest fisier...\n";
    else {
        pos1 = i;
        while(v[i]==x)
            i++;
        pos2 = i-1;
    }
    cout<<'('<<pos1<<','<<pos2<<')'<<endl;
}

void del(int &n, int v[]){
    int x,i=0;
    cin>>x;
    while(v[i]!=x && i<n){
        i++;
    }
    if(i==n)
        cout<<"Nu exista acest fisier...\n";
    else{
        while(v[i]==x)
            v[i++]=0;
        
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
                while(j>0){
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
}


int main() {
    char s[30];
    int v[10],n=10;
    for(int i=0;i<10;i++)
    v[i]=0;
    int x,y;
    int inst;
    int i;
    int nr;
    cin>>nr;
    cin>>inst;
    while(nr>0){
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
}