# Reproducibility Checklist

Start with good science. Remember, garbage in garbage out. A focused coherent question often simplifies many problems. Here are some do's and don'ts. 

**Don't do things by hand**. Editiong spreadsheets of data to "clean it up". "We're just going to do this once"... that's bullshit. Unless you write exactly what you did and how you did it, you shouln't be doing it. This is harder than it sounds, so it's better to keep everything in your code files. Basically you need a record of everything you do, and the best way is to code. 

**Don't point and click**. GUIs are convenient but can be difficult for others to reproduce. Some produce a log file. In general, be careful with analysis that is highly interactive. Text editors are fine. 

**Do teach a computer**. Automate, try to teach your computer to do it, even if you do it only once. If you can teach your computer to do it, you have solid concrete instructions for what to do. Teaching a computer to do it almost guarantees reproducibility. Teach it to do even the simplest things, like downloading a dataset. 

**Do use version control**. You're doing it now. Super.

**Do keep track of software environment**. Computer architechture, operating system, software toolchain, supporting software (libraries), dependencies and version numbers. 

**Don't save output**. Avoid saving data analysis output, except perhaps temporarily for efficiency purposes. If a stray output file cannot be easily connected with the means by which it was create, then it is not reproducible. Save the data+code that generated the output. Document intermediate files if it's necessary to make them. 

**Do set your seed**. Random number generators are pseudo-random number generators. Set the seed at the beginning for reproducibility. 

**Do think about the entire pipeline**. Data analysis is a lengthy process. How you got to the end is just as important as the end itself. The more of the pipeline you can make reproducible the better for everyone. 
