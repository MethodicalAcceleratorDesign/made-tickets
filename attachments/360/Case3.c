#include "mad_core.h"

int main()
{

  madx_start();
  // OK. exit; command stops Madx normally
  madx_input(1); 
  //madx_finish();

  madx_start();
  // No command is accepted.
  madx_input(1); 
  //madx_finish();
}
