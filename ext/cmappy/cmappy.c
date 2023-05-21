#include "cmappy.h"

int mg_verbose_level(int v)
{
	if (v >= 0) mg_verbose = v;
	return mg_verbose;
}
