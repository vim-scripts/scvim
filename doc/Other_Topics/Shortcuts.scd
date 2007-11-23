
All SuperCollider shortcuts across three supported platforms - and two editors for Linux (emacs-scel and sced)
- adc, p.plessas, 3/2007 - nescivi, 5/2007-

Functions
           OSX
     Win
            sced
            emacs
  
Files:
Open text document 
  cmd-o
  ctl-o
    ctl-o
  C-x C-f
New text document
   cmd-n
  ctl-n
    ctl-n
  (open non-existent file w. new name) 
Close text document
 cmd-w
  ctl-w
 ctl-w
  C-x k
Save text document 
 cmd-s
  ctl-s
 ctl-s
        C-x C-s

Save text document as
cmd-sh-s
    ctl-sh-s
  ctl-sh-s
  C-x C-w

HTML doc window -> code win 
      
        Ctl-t 
    
        M-x sclang-minor-mode / M-x sclang-mode
-----------------
Text Editing:
Undo
             cmd-z
  ctl-z
  ctl-z
  C-x u
Redo 
    cmd-sh-Z
  ctl-y
  ctl-sh-z

Copy
    cmd-c
  ctl-c
  ctl-c  
  M-w

Paste
  cmd-v
  ctl-v
  ctl-v
  C-y

Cut
  cmd-x
  ctl-x
  ctl-x  
  C-w

select all
  cmd-a
  ctl-a
  ctl-a
  C-x a

select block
          
    
    ctl-b
    

goto line ...
         cmd-,
         
         ctl-i
         

Find ...
           cmd-f
           
           ctl-f
          C-s

Find next
           cmd-g
           
           ctl-g
          C-s

Find previous
           cmd-d
           
           ctl-sh-g
          

replace and find next
     cmd-l
     
     
          M-%
replace
     cmd-=

-

copy text style only
     cmd-alt-c
paste text style only
     cmd-alt-v

-----------------

Language-Specific Commands:

Interpret Selection
      enter
   ctl-enter
   ctl-e
    C-c C-x / C-c C-c

Interpret current line
    enter
   ctl-enter
   ctl-e
    C-c C-c

stop
             cmd-.
     alt-.
     escape
    C-c C-s

Run Main-run 
         cmd-r 
   alt-r
   
   C-c C-r

recompile library
       cmd-k
   alt-k
   
   C-c C-l (fails often (3/07))

clear post window
       cmd-sh-K
  alt-p
  
    C-c <
-
Open Help File 
        cmd-? 
   F1
    
   C-c C-h
Open Class Definition
     cmd-j 
   alt-j
   
    C-c :
(look up class file, either
Class name or Class:method)
e.g. Object, Object:dump
-
Implementations of
      cmd-y
   alt-y
   
    C-c ;


 (which objects have code         (broken in

 that defines methods,
          dec06 v)

 e.g. 'play')
-
References to (where in the  cmd-sh-Y  alt-sh-Y   C-c ;
 source files is e.g. the         (broken in
 method 'play' used?)           dec06 v)
-----------------
Formatting:

Syntax Colorise
        cmd-'
        
        auto
        auto

Balance (find next matched 
  cmd-sh-B
        
        
        



 parens/curly braces and


 select everything enclosed)
-
Comment (add // in front)
   cmd-/
   
   ctl-/
   

Uncomment (remove //s)
    cmd-sh-/
    
    ctl-sh-/
    

Indent / Shift left (move selected
   cmd-[
   
   ctl-t
   


 text by one tab)

Unindent / Shift right (by one tab)
   cmd-]
   
   ctl-sh-t
   

Insert (): enclose 
      cmd-(

 selected text with (txt)

Insert []: enclose 
      cmd-alt-[

 selected text with [txt]
Insert {}: enclose       cmd-{
 selected text with {txt}
Insert /* */: enclose
     cmd-*
 selected text with /*txt*/


