#include <iostream>

// madx
extern "C" {
# include <madX/madx.h>
}

char input[] =
    "test: sequence, l=1, refer=entry; endsequence;"
    "beam, sequence=test, particle=proton;"
    "use, sequence=test;"
    "twiss, sequence=test, betx=1, bety=1, alfx=1, alfy=1;";

int main(int argc, char** argv, char** env)
{
    using namespace std;

    madx_start();
    pro_input(input);

    int pos = name_list_pos("twiss", table_register->names);
    table* twiss = table_register->tables[pos];

    name_list* columns = twiss->columns;
    for (int i = 0; i < columns->curr; ++i) {
        if (columns->inform[i] != 2 && columns->inform[i] != 3)
            cout << columns->names[i] << ": " << columns->inform[i] << endl;
    }

    madx_finish();
    return 0;
}
