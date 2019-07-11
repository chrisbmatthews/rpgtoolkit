# RPG Toolkit Development System; Version 3

I've converted this from CVS -> GIT and moved it over to GitHub, largely for posterity.

The original Sourceforge project is located here: https://sourceforge.net/projects/rpgtoolkit/

I'm keeping this around for personal nostalic reasons.  After the rpgtoolkit was GPL'ed, some variants were forked by volunteers in the community.  The latest one I am aware of is here: https://github.com/rpgtoolkit (I am not involved with it in any way, just as my involvement with RPGToolkit 3 ended after version 3.0.4 or so)

## Final cbm commit
In fact, you can find my last commit in the history, as the old CVS history has been preserved.  I have also tagged it:

~~~~
git checkout cbm_lastcommit
~~~~

...and the commit history shows:

~~~~
commit 3276066eac68613a599a4db3276066eac68613a599a4dbb69542f93773091a6b69542f93773091a6
Author: cbm_rpgtoolkit <cbm_rpgtoolkit@8ad37bdc-5837-4682-a52a-fbb6d9f1e9f7>
Date:   Tue Sep 14 20:22:33 2004 +0000

    changed freeimage.lib
~~~~

## Finding Your Way Around
I'm going to explain this for the state of the code as I left it after my last commit.  Do a git `checkout cbm_lastcommit` to follow along.
A good place to start might be the main entry point of the engine.  Have a look at:

`vb/trans3/modules/transMain.bas`

The main entry point is the Main() subroutine.  It briefly calls into mainEventLoop() which is defined in the C++ runtime here:

`vc/actkrt3/GUISystem/platform/transHost.cpp`

It then calls quickly back into the VisualBasic code by calling `gameLogic()` in `transMain.bas` (essentially doing a callback into the VisualBasic code)

You can obviously see we were looking to progressively move more and more code into winmain.cpp and its peers over time.  At this stage, most of the logic still lived in VB, but the engine had a toe-hole in the C++ codebase.

Really, everything flows from the gameLogic() subroutine.  It represents one 'frame', or one 'step' of engine execution.  You should be able to follow everythign else it does from there.

...Later on, other contributors ported most of the trans3 logic from VisualBasic into VisualC++, so you can follow the same path if you get the HEAD revision and look through `vc/trans3/app/winmain.cpp`

All-in-all, I think it's pretty easy to read and follow.  Writing this was the first time I've looked at the code in more than a decade, and it all came flooding back tto me.  So I hope it's clear and clean code (for VisualBasic, anyway ;))

## Why Keep This Copy in Your Personal Repo?
The RPG Toolkit was my "masterpiece" sideproject when I was in my early 20s and going through university.  I was amazed by the amount of community support I got.  As is the case with most personal projects, I just wanted to "scratch an itch", and I was incredibly into videogames at the time.

Top-down 2D RPGs seemed relatively simple to code, and I set about doing the very best I could.  I think I'm pretty happy with how it turned out, considering the development tools I had available to me in the late 90s and early 2000s.

Honestly, if it wasn't for this project, I wouldn't be the software developer I have come to be today.  I developed so much of my early, formative, programming style on this project.

So I wanted this in my personal GitHub, because so much of it is really, personally, mine.

I really appreciate the volunteers who grabbed the torch after I stepped down.  I'm just happy anyone else ever found this useful :)

Chris Matthews (cbm); July, 2019
