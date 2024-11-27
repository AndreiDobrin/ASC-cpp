//de tratat cazul in care nu sunt adaugate bine variabilele
//add 5
//add 5 3
// *no bueno*

#include <iostream>
using namespace std;
#include <cstring>

void add(int &n, int v[]){
    int ok=0;
    int x, y;
    int pos1=0, pos2=0;
    int i=0;

        cin>>x;
        cin>>y;
        while(ok<y && i<10){
            if(v[i]==0){
                ok++;
                pos2=i+1;
            
            }
            if(v[i]!=0){
                ok=0;
                pos1=i+1;
                pos2=pos1;
            }
            i++;
        }
        if(ok==y){
            for(int i=pos1;i<pos2;i++)
                v[i]=x;
        }
        else
            cout<<"Nu mai exista spatiu ramas, incercati o defragmentare..."<<endl;
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


int main() {
    
    int v[10],n=10;
    for(int i=0;i<10;i++)
    v[i]=0;
    int x,y;
    char inst[10];
    int i;
    while(1){
        cin>>inst;
        if(strcmp(inst,"exit")==0){
            break;
        }
        else if((strcmp(inst,"add")==0))
            add(n,v);
        
        else if(strcmp(inst,"show")==0){
            for(int i=0;i<10;i++)
                cout<<v[i]<<" ";
            cout<<endl;
        }
        else if(strcmp(inst,"get")==0){
            get(n,v);
        }
        else if(strcmp(inst,"del")==0){
            del(n,v);
        }
        
    for(int i=0;i<10;i++)
        cout<<v[i]<<" ";
    cout<<endl;
    }
}