Unit Generator Plug-In Example

Unit generator plug-ins will be described in another document. But for an example of what one looks like, here is the complete source to a plug-in for a sample-and-hold unit generator called Latch. 


///////////////////////////////////////////////////////////////////////////

#include "SC_PlugIn.h"

static InterfaceTable *ft;

///////////////////////////////////////////////////////////////////////////

struct Latch : public Unit
{
 float mLevel, m_prevtrig;
};


extern "C"
{
 void start();
 void load(InterfaceTable *inTable);

 void Latch_Ctor(Latch *unit);
 void Latch_next_ak(Latch *unit, int inNumSamples);
 void Latch_next_aa(Latch *unit, int inNumSamples);
}

// Codewarrior's linker has a bug that demands this function be defined...
void start() {}

///////////////////////////////////////////////////////////////////////////

void Latch_Ctor(Latch *unit)
{
 if (INRATE(1) == calc_FullRate) {
 SETCALC(Latch_next_aa);
 } else {
 SETCALC(Latch_next_ak);
 }

 unit->m_prevtrig = 0.f;
 unit->mLevel = 0.f;
 
 ZOUT0(0) = 0.f;
}


void Latch_next_ak(Latch *unit, int inNumSamples)
{
 float *out = ZOUT(0);
 float level = unit->mLevel;
 
 float curtrig = ZIN0(1);
 if (unit->m_prevtrig <= 0.f && curtrig > 0.f) level = ZIN0(0);
 
 LOOP(inNumSamples, *++out = level; );

 unit->m_prevtrig = curtrig;
 unit->mLevel = level;
}


void Latch_next_aa(Latch *unit, int inNumSamples)
{
 float *out = ZOUT(0);
 float *in = ZIN(0);
 float *trig = ZIN(1);
 float prevtrig = unit->m_prevtrig;
 float level = unit->mLevel;
 
 LOOP(inNumSamples, 
 float curtrig = *++trig;
 if (prevtrig <= 0.f && curtrig > 0.f) level = *++in;
 else { ++in; }
 *++out = level;
 prevtrig = curtrig;
 );
 unit->m_prevtrig = prevtrig;
 unit->mLevel = level;
}

///////////////////////////////////////////////////////////////////////////

void load(InterfaceTable *inTable)
{
 ft = inTable;

 DefineSimpleUnit(Latch);
 
}

///////////////////////////////////////////////////////////////////////////

copyright ? 2002 James McCartney


Adding a Target to ProjectBuilder


Each group of plugins shares a target in ProjectBuilder. They create a combined file: eg. YourGroup.scx which is then copied into the plugins folder via a little shell script. The aggregate target builds all of the targets, each of which looks in the build directory to see if an up to date 'YourGroup.scx' is there. So you should not delete or move (rather than copy) the .scx file, or it will rebuild it each time.

Create a new target, select type 'Library'
Select the target and add your file 'YourGroup.cpp' to it by checking the box beside it in Files.
Go to expert view and set Library_Style to BUNDLE. 
 set OTHER_CFLAGS to -DSC_DARWIN
Set the product name to be YourGroup.scx.
Add a build phase (control or right click on build phases): a shell script build phase. 
copy the one line script from one of the other targets, changing the filename to match yours. 
Uncheck "run only when installing".
Open the "disclosure triangle" for the All Plugins target and drag your target into that list.

Your target will be built along with the others when the aggregate target is selected and built.




