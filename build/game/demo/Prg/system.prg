*****************************************
*System.prg                             *
*RPG Toolkit Development System, 2.0    *
*System Library.                        *
*Copyright 1999 By Christopher B.       *
*Matthews                               *
*****************************************
* This library gives access to extended *
*RPGCode commands.                      *
*****************************************


*****************************
* #Pause()                  *
*****************************
* Waits for a key press.    *
*Ignores arrow keys.        *
*****************************
#Method Pause()
{
    #pause_done!=0
    #While(pause_done!==0)
    {
        #Wait(pause_wait$)
        #If(pause_wait$~="UP")
        {
            #If(pause_wait$~="DOWN")
            {
                #If(pause_wait$~="LEFT")
                {
                    #If(pause_wait$~="RIGHT")
                    {
                        #pause_done!=1
                    }
                }
            }
        }
    }
    #Kill(pause_done!)
    #Kill(pause_wait$)
}


**********************************
* Causes a graphic to move from
* x1,y1 to x2,y2
* mgFilename$ is the filename of the graphic.
* mgspeed! is the speed (1 is fast, 0.5 is slower)
**********************************
#method moveGraphic(mgFilename$, mgx1!, mgy1!, mgx2!, mgy2!, mgspeed!)
{
	*calculate delta y and delta x...
	#mgDX! = mgx2! - mgx1!
	#mgDY! = mgy2! - mgy1!
	*calculate slope...
    #mgm! = mgDY! / mgDX!
	*calculate b...
	#mgb! = mgm! * mgx1!
	#mgb! = mgy1! - mgb!
    *#mwin("<mgx1!>,<mgy1!>  <mgx2!>,<mgy2!>")
	*
	*now we have y = mx + b
    #if(mgx1!<=mgx2!)
    {
        #for (mgc! = mgx1!; mgc! <= mgx2!; mgc! = mgc!+mgspeed!)
        {
            #mgxx! = mgc!
            #mgyy! = mgm! * mgxx! + mgb!
            #scan(mgxx!,mgyy!,0)
            #put(mgxx!, mgyy!, mgFilename$)
            *#delay(0.1)
            #mem(mgxx!, mgyy!, 0)
        }
    }
    #if(mgx1!>mgx2!)
    {
        #for (mgc! = mgx1!; mgc! > mgx2!; mgc! = mgc!-mgspeed!)
        {
            #mgxx! = mgc!
            #mgyy! = mgm! * mgxx! + mgb!
            #scan(mgxx!,mgyy!,0)
            #put(mgxx!, mgyy!, mgFilename$)
            *#delay(0.1)
            #mem(mgxx!, mgyy!, 0)
        }
    }
	#kill(mgDX!)
	#kill(mgDY!)
	#kill(mgm!)
	#kill(mgb!)
	#kill(mgc!)
	#kill(mgxx!)
	#kill(mgyy!)
	#kill(mgFilename$)
	#kill(mgx1!)
	#kill(mgy1!)
	#kill(mgx2!)
	#kill(mgy2!)
    #kill(mgspeed!)
}


*************************************************
* #NumSetElement(name$, elementnum!, value!)    *
*************************************************
* Sets a specific element in a numerical array. *
*************************************************
#Method NumSetElement(sE_Name$, sE_Element!, sE_Value!)
{
    #castLit(sE_Element!, sE_LitEle$)
    #castLit(sE_Value!, sE_LitVal$)
    #sE_Name$=se_Name$+"["+sE_LitEle$+"]!"
    #sE_com$= "#" +se_Name$+ "="+ se_LitVal$
    #RPGCode(se_com$)
    #Kill(sE_Name$)
    #Kill(sE_Element!)
    #Kill(sE_Value!)
    #Kill(sE_com$)
    #Kill(sE_LitEle$)
    #Kill(sE_LitVal$)
}

*************************************************
* #LitSetElement(name$, elementnum!, value$)    *
*************************************************
* Sets a specific element in a literal array.   *
*************************************************
#method LitSetElement(sE_Name$, sE_Element!, sE_Value$)
{
    #castLit(sE_Element!, sE_LitEle$)
    #sE_Name$=se_Name$+"["+sE_LitEle$+"]$"
    #sE_com$= "#" +se_Name$+ "="+ sE_Value$
    #RPGCode(sE_com$)
    #Kill(sE_Name$)
    #Kill(sE_Element!)
    #Kill(sE_Value$)
    #Kill(sE_com$)
    #Kill(sE_LitEle$)
}

*************************************************
* #NumGetElement(name$, elementnum!, dest!)     *
*************************************************
* Get a specific element in a numerical array.  *
*************************************************
#method NumGetElement(gE_Name$,gE_Element!,gE_dest!)
{
    #castLit(gE_Element!, gE_LitEle$)
    #gE_Name$=ge_Name$+"["+gE_LitEle$+"]!"
    #gE_com$= "#gE_dest!" + "="+ gE_Name$
    #RPGCode(gE_com$)
	#ReturnMethod(gE_dest!)
    #Kill(gE_Name$)
    #Kill(gE_Element!)
    #Kill(gE_dest!)
    #Kill(gE_com$)
    #Kill(gE_LitEle$)
}

*************************************************
* #LitGetElement(name$, elementnum!, dest$)     *
*************************************************
* Get a specific element in a literal   array.  *
*************************************************
#Method LitGetElement(gE_Name$, gE_Element!, gE_dest$)
{
    #castLit(gE_Element!, gE_LitEle$)
    #gE_Name$=ge_Name$+"["+gE_LitEle$+"]$"
    #gE_com$= "#gE_dest$" + "="+ gE_Name$
    #RPGCode(gE_com$)
    #ReturnMethod(gE_dest$)
    #Kill(gE_Name$)
    #Kill(gE_Element!)
    #Kill(gE_dest$)
    #Kill(gE_com$)
    #Kill(gE_LitEle$)
}


