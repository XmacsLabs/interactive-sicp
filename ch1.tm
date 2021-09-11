<TeXmacs|2.1>

<project|sicp.tm>

<style|<tuple|book|british|comment>>

<\body>
  \;

  <chapter|Building Abstractions with Procedures>

  We are about to study the idea of a <em|computational
  process><index|computational process>. Computational processes are abstract
  beings that inhabit computers. As they evolve, processes manipulate other
  abstract things called <em|data><index|data>. The evolution of a process is
  directed by a pattern of rules called a <em|program><index|program>. People
  create programs to direct processes. In effect, we conjure the spirits of
  the computer with our spells.

  A computational process is indeed much like a sorcerer's idea of a spirit.
  It cannot be seen or touched. It is not composed of matter at all. However,
  it is very real. It can perform intellectual work. It can answer questions.
  It can affect the world by disbursing money at a bank or by controlling a
  robot arm in a factory. The programs we use to conjure processes are like a
  sorcerer's spells. They are carefully composed from symbolic expressions in
  arcane and esoteric <em|programming languages><index|programming languages>
  that prescribe the tasks we want our processes to perform.

  A computational process, in a correctly working computer, executes programs
  precisely and accurately. Thus, like the sorcerer's apprentice, novice
  programmers must learn to understand and to anticipate the consequences of
  their conjuring. Even small errors (usually called <em|bugs><index|bugs> or
  <em|glitches><index|glitches>) in programs can have complex and
  unanticipated consequences.

  Fortunately, learning to program is considerably less dangerous than
  learning sorcery, because the spirits we deal with are conveniently
  contained in a secure way. Real-world programming, however, requires care,
  expertise, and wisdom. A small bug in a computer-aided design program, for
  example, can lead to the catastrophic collapse of an airplane or a dam or
  the self-destruction of an industrial robot.

  Master software engineers have the ability to organize programs so that
  they can be reasonably sure that the resulting processes will perform the
  tasks intended. They can visualize the behavior of their systems in
  advance. They know how to structure programs so that unanticipated problems
  do not lead to catastrophic consequences, and when problems do arise, they
  can <em|debug><index|debug> their programs. Well-designed computational
  systems, like well-designed automobiles or nuclear reactors, are designed
  in a modular manner, so that the parts can be constructed, replaced, and
  debugged separately.

  <paragraph|Programming in Lisp>

  We need an appropriate language for describing processes, and we will use
  for this purpose the programming language Lisp. Just as our everyday
  thoughts are usually expressed in our natural language (such as English,
  French, or Japanese), and descriptions of quantitative phenomena are
  expressed with mathematical notations, our procedural thoughts will be
  expressed in Lisp. Lisp was invented in the late 1950s as a formalism for
  reasoning about the use of certain kinds of logical expressions, called
  <em|recursion equations><index|recusion equations>, as a model for
  computation. The language was conceived by John McCarthy and is based on
  his paper ``Recursive Functions of Symbolic Expressions and Their
  Computation by Machine'' (McCarthy 1960).

  Despite its inception as a mathematical formalism, Lisp is a practical
  programming language. A Lisp <em|interpreter><index|interpreter> is a
  machine that carries out processes described in the Lisp language. The
  first Lisp interpreter was implemented by <label|%_idx_32>McCarthy with the
  help of colleagues and students in the Artificial Intelligence Group of the
  <label|%_idx_34>MIT Research Laboratory of Electronics and in the MIT
  Computation Center.<hlink||https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-9.html#footnote_Temp_7><\footnote>
    The <em|Lisp 1 Programmer's Manual> appeared in 1960, and the <em|Lisp
    1.5 Programmer's Manual> <label|%_idx_36>(McCarthy 1965) was published in
    1962. The early history of Lisp is described in McCarthy 1978.
  </footnote> Lisp, whose name is an acronym for LISt Processing, was
  designed to provide symbol-manipulating capabilities for attacking
  programming problems such as the symbolic differentiation and integration
  of algebraic expressions. It included for this purpose new data objects
  known as atoms and lists, which most strikingly set it apart from all other
  languages of the period.

  Lisp was not the product of a concerted design effort. Instead, it evolved
  informally in an experimental manner in response to users' needs and to
  pragmatic implementation considerations. Lisp's informal evolution has
  continued through the years, and the community of Lisp users has
  traditionally resisted attempts to promulgate any ``official'' definition
  of the language. This evolution, together with the flexibility and elegance
  of the initial conception, has enabled Lisp, which is the second oldest
  language in widespread use today (only <label|%_idx_40>Fortran is older),
  to continually adapt to encompass the most modern ideas about program
  design. Thus, Lisp is by now a family of dialects, which, while sharing
  most of the original features, may differ from one another in significant
  ways. The dialect of Lisp used in this book is called
  <label|%_idx_42><label|%_idx_44>Scheme.<\footnote>
    The two dialects in which most major Lisp programs of the 1970s were
    written are <label|%_idx_46><label|%_idx_48>MacLisp <label|%_idx_50>(Moon
    1978; <label|%_idx_52>Pitman 1983), developed at the <label|%_idx_54>MIT
    Project MAC, and <label|%_idx_56><label|%_idx_58>Interlisp
    <label|%_idx_60>(Teitelman 1974), developed at <label|%_idx_62>Bolt
    Beranek and Newman Inc. and the <label|%_idx_64>Xerox Palo Alto Research
    Center. <label|%_idx_66><label|%_idx_68>Portable Standard Lisp
    <label|%_idx_70>(Hearn 1969; <label|%_idx_72>Griss 1981) was a Lisp
    dialect designed to be easily portable between different machines.
    MacLisp spawned a number of subdialects, such as
    <label|%_idx_74><label|%_idx_76>Franz Lisp, which was developed at the
    <label|%_idx_78>University of California at Berkeley, and
    <label|%_idx_80><label|%_idx_82>Zetalisp (Moon 1981), which was based on
    a special-purpose processor designed at the <label|%_idx_84>MIT
    Artificial Intelligence Laboratory to run Lisp very efficiently. The Lisp
    dialect used in this book, called <label|%_idx_86>Scheme (Steele 1975),
    was invented in 1975 by <label|%_idx_88><label|%_idx_90>Guy Lewis Steele
    Jr. and Gerald Jay Sussman of the MIT Artificial Intelligence Laboratory
    and later reimplemented for instructional use at MIT. Scheme became an
    IEEE standard in 1990 (IEEE 1990). The
    <label|%_idx_92><label|%_idx_94>Common Lisp dialect (Steele 1982, Steele
    1990) was developed by the Lisp community to combine features from the
    earlier Lisp dialects to make an industrial standard for Lisp. Common
    Lisp became an ANSI standard in 1994 (ANSI<nbsp>1994).
  </footnote>

  Because of its experimental character and its emphasis on symbol
  manipulation, Lisp was at first very inefficient for numerical
  computations, at least in comparison with Fortran. Over the years, however,
  Lisp compilers have been developed that translate programs into machine
  code that can perform numerical computations reasonably efficiently. And
  for special applications, Lisp has been used with great
  effectiveness.<\footnote>
    One such special application was a breakthrough computation of scientific
    importance -- an integration of the motion of the
    <label|%_idx_102><label|%_idx_104>Solar System that extended previous
    results by nearly two orders of magnitude, and demonstrated that the
    dynamics of the Solar System is chaotic. This computation was made
    possible by new integration algorithms, a special-purpose compiler, and a
    special-purpose computer all implemented with the aid of software tools
    written in Lisp <label|%_idx_106>(Abelson et al. 1992; Sussman and Wisdom
    1992).
  </footnote> Although Lisp has not yet overcome its old reputation as
  hopelessly inefficient, Lisp is now used in many applications where
  efficiency is not the central concern. For example, Lisp has become a
  language of choice for operating-system shell languages and for extension
  languages for editors and computer-aided design systems.

  If Lisp is not a mainstream language, why are we using it as the framework
  for our discussion of programming? Because the language possesses unique
  features that make it an excellent medium for studying important
  programming constructs and data structures and for relating them to the
  linguistic features that support them. The most significant of these
  features is the fact that Lisp descriptions of processes, called
  <em|procedures><index|procedures>, can themselves be represented and
  manipulated as Lisp data. The importance of this is that there are powerful
  program-design techniques that rely on the ability to blur the traditional
  distinction between ``passive'' data and ``active'' processes. As we shall
  discover, Lisp's flexibility in handling procedures as data makes it one of
  the most convenient languages in existence for exploring these techniques.
  The ability to represent procedures as data also makes Lisp an excellent
  language for writing programs that must manipulate other programs as data,
  such as the interpreters and compilers that support computer languages.
  Above and beyond these considerations, programming in Lisp is great
  fun.<hlink||https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-9.html#call_footnote_Temp_9>\ 

  <section|The Elements of Programming>

  A powerful programming language is more than just a means for instructing a
  computer to perform tasks. The language also serves as a framework within
  which we organize our ideas about processes. Thus, when we describe a
  language, we should pay particular attention to the means that the language
  provides for combining simple ideas to form more complex ideas. Every
  powerful language has three mechanisms for accomplishing this:

  <\itemize>
    <item><with|font-series|bold|primitive expressions>, which represent the
    simplest entities the language is concerned with,

    <item><with|font-series|bold|means of combination>, by which compound
    elements are built from simpler ones, and

    <item><with|font-series|bold|means of abstraction>, by which compound
    elements can be named and manipulated as units.
  </itemize>

  In programming, we deal with two kinds of elements: procedures and data.
  (Later we will discover that they are really not so distinct.) Informally,
  data is \Pstuff\Q that we want to manipulate, and procedures are
  descriptions of the rules for manipulating the data. Thus, any powerful
  programming language should be able to describe primitive data and
  primitive procedures and should have methods for combining and abstracting
  procedures and data.

  In this chapter we will deal only with simple numerical data so that we can
  focus on the rules for building procedures.<\footnote>
    The characterization of numbers as \Psimple data\Q is a barefaced bluff.
    In fact, the treatment of numbers is one of the trickiest and most
    confusing aspects of any programming language. Some typical issues
    involved are these: Some computer systems distinguish
    <em|integers><index|integers>, such as 2, from <em|real
    numbers><index|real numbers>, such as 2.71. Is the real number 2.00
    different from the integer 2? Are the arithmetic operations used for
    integers the same as the operations used for real numbers? Does 6 divided
    by 2 produce 3, or 3.0? How large a number can we represent? How many
    decimal places of accuracy can we represent? Is the range of integers the
    same as the range of real numbers? Above and beyond these questions, of
    course, lies a collection of issues concerning roundoff and truncation
    errors\Vthe entire science of numerical analysis. Since our focus in this
    book is on large-scale program design rather than on numerical
    techniques, we are going to ignore these problems. The numerical examples
    in this chapter will exhibit the usual roundoff behavior that one
    observes when using arithmetic operations that preserve a limited number
    of decimal places of accuracy in noninteger operations.
  </footnote> In later chapters we will see that these same rules allow us to
  build procedures to manipulate compound data as well.

  <subsection|Expressions>

  One easy way to get started at programming is to examine some typical
  interactions with an interpreter for the Scheme dialect of Lisp. Imagine
  that you are sitting at a computer terminal. You type an
  <em|expression><index|expression>, and the interpreter responds by
  displaying the result of its <em|evaluating><index|evaluating> that
  expression.

  One kind of primitive expression you might type is a number. (More
  precisely, the expression that you type consists of the numerals that
  represent the number in base 10.) If you present Lisp with a number

  <code|486>

  the interpreter will respond by printing<\footnote>
    Throughout this book, when we wish to emphasize the distinction between
    the input typed by the user and the response printed by the interpreter,
    we will show the latter in slanted characters.
  </footnote>

  <code|<with|font-shape|italic|486>>

  Expressions representing numbers may be combined with an expression
  representing a primitive procedure (such as <code*|+> or <code*|*>) to form
  a compound expression that represents the application of the procedure to
  those numbers. For example:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (+ 137 349)
    <|unfolded-io>
      486
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (- 1000 334)
    <|unfolded-io>
      666
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (- 1000 334)
    <|unfolded-io>
      666
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (* 5 99)
    <|unfolded-io>
      495
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (/ 10 5)
    <|unfolded-io>
      2
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (+ 2.7 10)
    <|unfolded-io>
      12.7
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Expressions such as these, formed by delimiting a list of expressions
  within parentheses in order to denote procedure application, are called
  <em|combinations><index|combinations>. The leftmost element in the list is
  called the <em|operator><index|operator>, and the other elements are called
  <em|operands><index|operands>. The value of a combination is obtained by
  applying the procedure specified by the operator to the
  <em|arguments><index|arguments> that are the values of the operands.

  The convention of placing the operator to the left of the operands is known
  as <em|prefix notation><index|prefix notation>, and it may be somewhat
  confusing at first because it departs significantly from the customary
  mathematical convention. Prefix notation has several advantages, however.
  One of them is that it can accommodate procedures that may take an
  arbitrary number of arguments, as in the following examples:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (+ 21 35 12 7)
    <|unfolded-io>
      75
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (* 25 4 12)
    <|unfolded-io>
      1200
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  No ambiguity can arise, because the operator is always the leftmost element
  and the entire combination is delimited by the parentheses.

  A second advantage of prefix notation is that it extends in a
  straightforward way to allow combinations to be
  <with|font-shape|italic|nested>, that is, to have combinations whose
  elements are themselves combinations:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (+ (* 3 5) (- 10 6))
    <|unfolded-io>
      19
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  There is no limit (in principle) to the depth of such nesting and to the
  overall complexity of the expressions that the Lisp interpreter can
  evaluate. It is we humans who get confused by still relatively simple
  expressions such as

  <code|(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))>

  which the interpreter would readily evaluate to be 57. We can help
  ourselves by writing such an expression in the form

  <\scm-code>
    (+ (* 3

    \ \ \ \ \ \ (+ (* 2 4)

    \ \ \ \ \ \ \ \ \ (+ 3 5)))

    \ \ \ (+ (- 10 7)

    \ \ \ \ \ \ 6))
  </scm-code>

  following a formatting convention known as
  <em|pretty-printing><index|pretty-printing>, in which each long combination
  is written so that the operands are aligned vertically. The resulting
  indentations display clearly the structure of the expression.<\footnote>
    Lisp systems typically provide features to aid the user in formatting
    expressions. Two especially useful features are one that automatically
    indents to the proper pretty-print position whenever a new line is
    started and one that highlights the matching left parenthesis whenever a
    right parenthesis is typed.
  </footnote>

  Even with complex expressions, the interpreter always operates in the same
  basic cycle: It reads an expression from the terminal, evaluates the
  expression, and prints the result. This mode of operation is often
  expressed by saying that the interpreter runs in a <em|read-eval-print
  loop><index|read-eval-print loop>. Observe in particular that it is not
  necessary to explicitly instruct the interpreter to print the value of the
  expression.<\footnote>
    Lisp obeys the convention that every expression has a value. This
    convention, together with the old reputation of Lisp as an inefficient
    language, is the source of the quip by Alan Perlis (paraphrasing Oscar
    Wilde) that \PLisp programmers know the value of everything but the cost
    of nothing.\Q
  </footnote>

  <subsection|Naming and the Environment>

  \;

  A critical aspect of a programming language is the means it provides for
  using names to refer to computational objects. We say that the name
  identifies a <em|variable><index|variable> whose <em|value><index|value> is
  the object.

  In the Scheme dialect of Lisp, we name things with <code*|define>. Typing

  <\session|scheme|default>
    <\input|Scheme] >
      (define size 2)
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  causes the interpreter to associate the value 2 with the name
  <code*|size>.<\footnote>
    In this book, we do not show the interpreter's response to evaluating
    definitions, since this is highly implementation-dependent.
  </footnote> Once the name <code*|size> has been associated with the number
  2, we can refer to the value 2 by name:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      size
    <|unfolded-io>
      2
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (* 5 size)
    <|unfolded-io>
      10
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Here are further examples of the use of <code*|define>:

  <\session|scheme|default>
    <\input|Scheme] >
      (define pi 3.14159)
    </input>

    <\input|Scheme] >
      (define radius 10)
    </input>

    <\unfolded-io|Scheme] >
      (* pi (* radius radius))
    <|unfolded-io>
      314.159
    </unfolded-io>

    <\input|Scheme] >
      (define circumference (* 2 pi radius))
    </input>

    <\unfolded-io|Scheme] >
      circumference
    <|unfolded-io>
      62.8318
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  <code*|Define> is our language's simplest means of abstraction, for it
  allows us to use simple names to refer to the results of compound
  operations, such as the <code*|circumference> computed above. In general,
  computational objects may have very complex structures, and it would be
  extremely inconvenient to have to remember and repeat their details each
  time we want to use them. Indeed, complex programs are constructed by
  building, step by step, computational objects of increasing complexity. The
  interpreter makes this step-by-step program construction particularly
  convenient because name-object associations can be created incrementally in
  successive interactions. This feature encourages the incremental
  development and testing of programs and is largely responsible for the fact
  that a Lisp program usually consists of a large number of relatively simple
  procedures.

  It should be clear that the possibility of associating values with symbols
  and later retrieving them means that the interpreter must maintain some
  sort of memory that keeps track of the name-object pairs. This memory is
  called the <em|environment><index|environment> (more precisely the
  <em|global environment><index|global environment>, since we will see later
  that a computation may involve a number of different
  environments).<\footnote>
    <hlink|Chapter 3|Chapter-3.xhtml#Chapter-3> will show that this notion of
    environment is crucial, both for understanding how the interpreter works
    and for implementing interpreters.
  </footnote>

  <subsection|Evaluating Combinations><label|1.1.3>

  One of our goals in this chapter is to isolate issues about thinking
  procedurally. As a case in point, let us consider that, in evaluating
  combinations, the interpreter is itself following a procedure.

  <\itemize-dot>
    <item>To evaluate a combination, do the following:

    <\enumerate>
      <item>Evaluate the subexpressions of the combination.

      <item>Apply the procedure that is the value of the leftmost
      subexpression (the operator) to the arguments that are the values of
      the other subexpressions (the operands).
    </enumerate>
  </itemize-dot>

  Even this simple rule illustrates some important points about processes in
  general. First, observe that the first step dictates that in order to
  accomplish the evaluation process for a combination we must first perform
  the evaluation process on each element of the combination. Thus, the
  evaluation rule is <em|recursive><index|recursive> in nature; that is, it
  includes, as one of its steps, the need to invoke the rule
  itself.<\footnote>
    It may seem strange that the evaluation rule says, as part of the first
    step, that we should evaluate the leftmost element of a combination,
    since at this point that can only be an operator such as <code*|+> or
    <code*|*> representing a built-in primitive procedure such as addition or
    multiplication. We will see later that it is useful to be able to work
    with combinations whose operators are themselves compound expressions.
  </footnote>

  Notice how succinctly the idea of recursion can be used to express what, in
  the case of a deeply nested combination, would otherwise be viewed as a
  rather complicated process. For example, evaluating

  <\scm-code>
    (* (+ 2 (* 4 6))

    \ \ \ (+ 3 5 7))
  </scm-code>

  requires that the evaluation rule be applied to four different
  combinations. We can obtain a picture of this process by representing the
  combination in the form of a tree, as shown in <hlink|Figure
  1.1|#Figure1.1>. Each combination is represented by a node with branches
  corresponding to the operator and the operands of the combination stemming
  from it. The terminal nodes (that is, nodes with no branches stemming from
  them) represent either operators or numbers. Viewing evaluation in terms of
  the tree, we can imagine that the values of the operands percolate upward,
  starting from the terminal nodes and then combining at higher and higher
  levels. In general, we shall see that recursion is a very powerful
  technique for dealing with hierarchical, treelike objects. In fact, the
  \Ppercolate values upward\Q form of the evaluation rule is an example of a
  general kind of process known as <em|tree accumulation><index|tree
  accumulation>.

  <\big-figure|<tree|390|*|<tree|26|+|2|<tree|24|*|4|6>>|<tree|15|+|3|5|7>>>
    <label|Figure1.1>Tree representation, showing the value of each
    subcombination.
  </big-figure>

  Next, observe that the repeated application of the first step brings us to
  the point where we need to evaluate, not combinations, but primitive
  expressions such as numerals, built-in operators, or other names. We take
  care of the primitive cases by stipulating that

  <\itemize>
    <item>the values of numerals are the numbers that they name,

    <item>the values of built-in operators are the machine instruction
    sequences that carry out the corresponding operations, and

    <item>the values of other names are the objects associated with those
    names in the environment.
  </itemize>

  We may regard the second rule as a special case of the third one by
  stipulating that symbols such as <code*|+> and <code*|*> are also included
  in the global environment, and are associated with the sequences of machine
  instructions that are their \Pvalues.\Q The key point to notice is the role
  of the environment in determining the meaning of the symbols in
  expressions. In an interactive language such as Lisp, it is meaningless to
  speak of the value of an expression such as <scm|(+ x 1)> without
  specifying any information about the environment that would provide a
  meaning for the symbol <code*|x> (or even for the symbol <code*|+>). As we
  shall see in <hlink|Chapter 3|Chapter-3.xhtml#Chapter-3>, the general
  notion of the environment as providing a context in which evaluation takes
  place will play an important role in our understanding of program
  execution.

  Notice that the evaluation rule given above does not handle definitions.
  For instance, evaluating <code*|(define x 3)> does not apply <code*|define>
  to two arguments, one of which is the value of the symbol <code*|x> and the
  other of which is 3, since the purpose of the <code*|define> is precisely
  to associate <code*|x> with a value. (That is, <code*|(define x 3)> is not
  a combination.)

  Such exceptions to the general evaluation rule are called <em|special
  forms><index|special forms>. <code*|Define> is the only example of a
  special form that we have seen so far, but we will meet others shortly.
  Each special form has its own evaluation rule. The various kinds of
  expressions (each with its associated evaluation rule) constitute the
  syntax of the programming language. In comparison with most other
  programming languages, Lisp has a very simple syntax; that is, the
  evaluation rule for expressions can be described by a simple general rule
  together with specialized rules for a small number of special
  forms.<\footnote>
    Special syntactic forms that are simply convenient alternative surface
    structures for things that can be written in more uniform ways are
    sometimes called <em|syntactic sugar><index|syntactic sugar>, to use a
    phrase coined by Peter Landin. In comparison with users of other
    languages, Lisp programmers, as a rule, are less concerned with matters
    of syntax. (By contrast, examine any Pascal manual and notice how much of
    it is devoted to descriptions of syntax.) This disdain for syntax is due
    partly to the flexibility of Lisp, which makes it easy to change surface
    syntax, and partly to the observation that many \Pconvenient\Q syntactic
    constructs, which make the language less uniform, end up causing more
    trouble than they are worth when programs become large and complex. In
    the words of Alan Perlis, \PSyntactic sugar causes cancer of the
    semicolon.\Q
  </footnote>

  <subsection|Compound Procedures><label|1.1.4>

  We have identified in Lisp some of the elements that must appear in any
  powerful programming language:

  <\itemize>
    <item>Numbers and arithmetic operations are primitive data and
    procedures.

    <item>Nesting of combinations provides a means of combining operations.

    <item>Definitions that associate names with values provide a limited
    means of abstraction.
  </itemize>

  Now we will learn about <em|procedure definitions><index|procedure
  definitions>, a much more powerful abstraction technique by which a
  compound operation can be given a name and then referred to as a unit.

  We begin by examining how to express the idea of \Psquaring.\Q We might
  say, \PTo square something, multiply it by itself.\Q This is expressed in
  our language as

  <\session|scheme|default>
    <\input|Scheme] >
      (define (square x) (* x x))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  We can understand this in the following way:

  <\code>
    (define (square x) \ \ \ (* \ \ \ \ \ \ x \ \ \ \ \ \ x))

    \ \ \| \ \ \ \ \ \| \ \ \ \ \ \| \ \ \ \ \ \| \ \ \ \ \ \ \|
    \ \ \ \ \ \ \|

    \ To square something, multiply it by itself.
  </code>

  We have here a <em|compound procedure><index|compound procedure>, which has
  been given the name <code*|square>. The procedure represents the operation
  of multiplying something by itself. The thing to be multiplied is given a
  local name, <code*|x>, which plays the same role that a pronoun plays in
  natural language. Evaluating the definition creates this compound procedure
  and associates it with the name <code*|square>.<\footnote>
    Observe that there are two different operations being combined here: we
    are creating the procedure, and we are giving it the name <code*|square>.
    It is possible, indeed important, to be able to separate these two
    notions\Vto create procedures without naming them, and to give names to
    procedures that have already been created. We will see how to do this in
    <hlink|1.3.2|1_002e3.xhtml#g_t1_002e3_002e2>.
  </footnote>

  The general form of a procedure definition is

  <\scm-code>
    (define (\<langle\><var|name>\<rangle\> \<langle\><var|formal
    parameters>\<rangle\>) \<langle\><var|body>\<rangle\>)
  </scm-code>

  \;

  The <code*|\<langle\>><var|name><code*|\<rangle\>> is a symbol to be
  associated with the procedure definition in the environment.<\footnote>
    Throughout this book, we will describe the general syntax of expressions
    by using italic symbols delimited by angle brackets\Ve.g.,
    <code*|\<langle\>><var|name><code*|\<rangle\>>\Vto denote the \Pslots\Q
    in the expression to be filled in when such an expression is actually
    used.
  </footnote> The <code*|\<langle\>><var|formal parameters><code*|\<rangle\>>
  are the names used within the body of the procedure to refer to the
  corresponding arguments of the procedure. The
  <code*|\<langle\>><var|body><code*|\<rangle\>> is an expression that will
  yield the value of the procedure application when the formal parameters are
  replaced by the actual arguments to which the procedure is
  applied.<hlink||#FOOT14><\footnote>
    More generally, the body of the procedure can be a sequence of
    expressions. In this case, the interpreter evaluates each expression in
    the sequence in turn and returns the value of the final expression as the
    value of the procedure application.
  </footnote> The <code*|\<langle\>><var|name><code*|\<rangle\>> and the
  <code*|\<langle\>><var|formal parameters><code*|\<rangle\>> are grouped
  within parentheses, just as they would be in an actual call to the
  procedure being defined.

  Having defined <code*|square>, we can now use it:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (square 21)
    <|unfolded-io>
      441
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (square (+ 2 5))
    <|unfolded-io>
      49
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (square (square 3))
    <|unfolded-io>
      81
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  We can also use <code*|square> as a building block in defining other
  procedures. For example, <math|x<rsup|2>+y<rsup|2>> can be expressed as

  <\scm-code>
    (+ (square x) (square y))
  </scm-code>

  \;

  We can easily define a procedure <code*|sum-of-squares> that, given any two
  numbers as arguments, produces the sum of their squares:

  <\session|scheme|default>
    <\input|Scheme] >
      (define (sum-of-squares x y)

      \ \ (+ (square x) (square y)))
    </input>

    <\unfolded-io|Scheme] >
      (sum-of-squares 3 4)
    <|unfolded-io>
      25
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Now we can use <code*|sum-of-squares> as a building block in constructing
  further procedures:

  <\session|scheme|default>
    <\input|Scheme] >
      (define (f a)

      \ \ (sum-of-squares (+ a 1) (* a 2)))
    </input>

    <\unfolded-io|Scheme] >
      (f 5)
    <|unfolded-io>
      136
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Compound procedures are used in exactly the same way as primitive
  procedures. Indeed, one could not tell by looking at the definition of
  <code*|sum-of-squares> given above whether <code*|square> was built into
  the interpreter, like <code*|+> and <code*|*>, or defined as a compound
  procedure.

  <subsection|The Substitution Model for Procedure Application>

  To evaluate a combination whose operator names a compound procedure, the
  interpreter follows much the same process as for combinations whose
  operators name primitive procedures, which we described in
  <hlink|1.1.3|#1.1.3>. That is, the interpreter evaluates the elements of
  the combination and applies the procedure (which is the value of the
  operator of the combination) to the arguments (which are the values of the
  operands of the combination).

  We can assume that the mechanism for applying primitive procedures to
  arguments is built into the interpreter. For compound procedures, the
  application process is as follows:

  <\itemize>
    <item>To apply a compound procedure to arguments, evaluate the body of
    the procedure with each formal parameter replaced by the corresponding
    argument.
  </itemize>

  To illustrate this process, let's evaluate the combination

  <\scm-code>
    (f 5)
  </scm-code>

  where <code*|f> is the procedure defined in
  <hlink|1.1.4|#g_t1_002e1_002e4>. We begin by retrieving the body of
  <code*|f>:

  <\scm-code>
    (sum-of-squares (+ a 1) (* a 2))
  </scm-code>

  Then we replace the formal parameter <code*|a> by the argument 5:

  <\scm-code>
    (sum-of-squares (+ 5 1) (* 5 2))
  </scm-code>

  Thus the problem reduces to the evaluation of a combination with two
  operands and an operator <code*|sum-of-squares>. Evaluating this
  combination involves three subproblems. We must evaluate the operator to
  get the procedure to be applied, and we must evaluate the operands to get
  the arguments. Now <code*|(+ 5 1)> produces 6 and <code*|(* 5 2)> produces
  10, so we must apply the <code*|sum-of-squares> procedure to 6 and 10.
  These values are substituted for the formal parameters <code*|x> and
  <code*|y> in the body of <code*|sum-of-squares>, reducing the expression to

  <\scm-code>
    (+ (square 6) (square 10))
  </scm-code>

  If we use the definition of <code*|square>, this reduces to

  <\scm-code>
    (+ (* 6 6) (* 10 10))
  </scm-code>

  which reduces by multiplication to

  <\scm-code>
    (+ 36 100)
  </scm-code>

  and finally to

  <\scm-code>
    136
  </scm-code>

  The process we have just described is called the <em|substitution
  model><index|substitution model> for procedure application. It can be taken
  as a model that determines the \Pmeaning\Q of procedure application,
  insofar as the procedures in this chapter are concerned. However, there are
  two points that should be stressed:

  <\itemize>
    <item>The purpose of the substitution is to help us think about procedure
    application, not to provide a description of how the interpreter really
    works. Typical interpreters do not evaluate procedure applications by
    manipulating the text of a procedure to substitute values for the formal
    parameters. In practice, the \Psubstitution\Q is accomplished by using a
    local environment for the formal parameters. We will discuss this more
    fully in <hlink|Chapter 3|Chapter-3.xhtml#Chapter-3> and <hlink|Chapter
    4|Chapter-4.xhtml#Chapter-4> when we examine the implementation of an
    interpreter in detail.

    <item>Over the course of this book, we will present a sequence of
    increasingly elaborate models of how interpreters work, culminating with
    a complete implementation of an interpreter and compiler in
    <hlink|Chapter 5|Chapter-5.xhtml#Chapter-5>. The substitution model is
    only the first of these models\Va way to get started thinking formally
    about the evaluation process. In general, when modeling phenomena in
    science and engineering, we begin with simplified, incomplete models. As
    we examine things in greater detail, these simple models become
    inadequate and must be replaced by more refined models. The substitution
    model is no exception. In particular, when we address in <hlink|Chapter
    3|Chapter-3.xhtml#Chapter-3> the use of procedures with \Pmutable data,\Q
    we will see that the substitution model breaks down and must be replaced
    by a more complicated model of procedure application.<\footnote>
      Despite the simplicity of the substitution idea, it turns out to be
      surprisingly complicated to give a rigorous mathematical definition of
      the substitution process. The problem arises from the possibility of
      confusion between the names used for the formal parameters of a
      procedure and the (possibly identical) names used in the expressions to
      which the procedure may be applied. Indeed, there is a long history of
      erroneous definitions of <em|substitution><index|substitution> in the
      literature of logic and programming semantics. See <hlink|Stoy
      1977|References.xhtml#Stoy-1977> for a careful discussion of
      substitution.
    </footnote>
  </itemize>

  <paragraph*|Applicative order versus normal order>

  According to the description of evaluation given in <hlink|1.1.3|#1.1.3>,
  the interpreter first evaluates the operator and operands and then applies
  the resulting procedure to the resulting arguments. This is not the only
  way to perform evaluation. An alternative evaluation model would not
  evaluate the operands until their values were needed. Instead it would
  first substitute operand expressions for parameters until it obtained an
  expression involving only primitive operators, and would then perform the
  evaluation. If we used this method, the evaluation of <code*|(f 5)> would
  proceed according to the sequence of expansions

  <\scm-code>
    (sum-of-squares (+ 5 1) (* 5 2))

    \;

    (+ (square (+ 5 1)) \ \ \ (square (* 5 2)))

    \;

    (+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))
  </scm-code>

  followed by the reductions

  <\scm-code>
    (+ (* 6 6) \ \ \ \ \ \ \ \ \ \ \ \ \ (* 10 10))

    \;

    (+ 36 \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 100)

    136
  </scm-code>

  This gives the same answer as our previous evaluation model, but the
  process is different. In particular, the evaluations of <code*|(+ 5 1)> and
  <code*|(* 5 2)> are each performed twice here, corresponding to the
  reduction of the expression <code*|(* x x)> with <code*|x> replaced
  respectively by <code*|(+ 5 1)> and <code*|(* 5 2)>.

  This alternative \Pfully expand and then reduce\Q evaluation method is
  known as <em|normal-order evaluation><index|normal order evaluation>, in
  contrast to the \Pevaluate the arguments and then apply\Q method that the
  interpreter actually uses, which is called <em|applicative-order
  evaluation><index|application-order evaluation>. It can be shown that, for
  procedure applications that can be modeled using substitution (including
  all the procedures in the first two chapters of this book) and that yield
  legitimate values, normal-order and applicative-order evaluation produce
  the same value. (See <hlink|Exercise 1.5|#Exercise-1_002e5> for an instance
  of an \Pillegitimate\Q value where normal-order and applicative-order
  evaluation do not give the same result.)

  Lisp uses applicative-order evaluation, partly because of the additional
  efficiency obtained from avoiding multiple evaluations of expressions such
  as those illustrated with <code*|(+ 5 1)> and <code*|(* 5 2)> above and,
  more significantly, because normal-order evaluation becomes much more
  complicated to deal with when we leave the realm of procedures that can be
  modeled by substitution. On the other hand, normal-order evaluation can be
  an extremely valuable tool, and we will investigate some of its
  implications in <hlink|Chapter 3|Chapter-3.xhtml#Chapter-3> and
  <hlink|Chapter 4|Chapter-4.xhtml#Chapter-4>.<\footnote>
    In <hlink|Chapter 3|Chapter-3.xhtml#Chapter-3> we will introduce
    <em|stream processing><index|stream processing>, which is a way of
    handling apparently \Pinfinite\Q data structures by incorporating a
    limited form of normal-order evaluation. In
    <hlink|4.2|4_002e2.xhtml#g_t4_002e2> we will modify the Scheme
    interpreter to produce a normal-order variant of Scheme.
  </footnote>

  <subsection|Conditional Expressions and Predicates>

  The expressive power of the class of procedures that we can define at this
  point is very limited, because we have no way to make tests and to perform
  different operations depending on the result of a test. For instance, we
  cannot define a procedure that computes the absolute value of a number by
  testing whether the number is positive, negative, or zero and taking
  different actions in the different cases according to the rule

  <\equation*>
    <around|\||x|\|>=<around*|{|<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|r>|<cwith|1|-1|2|2|cell-halign|l>|<cwith|1|-1|3|3|cell-halign|l>|<table|<row|<cell|x>|<cell|<with|mode|text|if>>|<cell|x\<gtr\>0,>>|<row|<cell|0>|<cell|<with|mode|text|if>>|<cell|x=0,>>|<row|<cell|-x>|<cell|<with|mode|text|if>>|<cell|x\<less\>0.>>>>>|\<nobracket\>>
  </equation*>

  \ 

  This construct is called a <em|case analysis><index|case analysis>, and
  there is a special form in Lisp for notating such a case analysis. It is
  called <code*|cond> (which stands for \Pconditional\Q), and it is used as
  follows:

  <\scm-code>
    (define (abs x)

    \ \ (cond ((\<gtr\> x 0) x)

    \ \ \ \ \ \ \ \ ((= x 0) 0)

    \ \ \ \ \ \ \ \ ((\<less\> x 0) (- x))))
  </scm-code>

  The general form of a conditional expression is

  <\scm-code>
    (cond (\<langle\><var|p\<#2081\>>\<rangle\>
    \<langle\><var|e\<#2081\>>\<rangle\>)

    \ \ \ \ \ \ (\<langle\><var|p\<#2082\>>\<rangle\>
    \<langle\><var|e\<#2082\>>\<rangle\>)

    \ \ \ \ \ \ ...

    \ \ \ \ \ \ (\<langle\><var|p\<#2099\>>\<rangle\>
    \<langle\><var|e\<#2099\>>\<rangle\>))
  </scm-code>

  consisting of the symbol <code*|cond> followed by parenthesized pairs of
  expressions

  <code|(\<langle\><var|p>\<rangle\> \<langle\><var|e>\<rangle\>)>

  called <em|clauses><index|clauses>. The first expression in each pair is a
  <em|predicate><index|predicate>\Vthat is, an expression whose value is
  interpreted as either true or false.<\footnote>
    \PInterpreted as either true or false\Q means this: In Scheme, there are
    two distinguished values that are denoted by the constants <code*|#t> and
    <code*|#f>. When the interpreter checks a predicate's value, it
    interprets <code*|#f> as false. Any other value is treated as true.
    (Thus, providing <code*|#t> is logically unnecessary, but it is
    convenient.) In this book we will use names <code*|true> and
    <code*|false>, which are associated with the values <code*|#t> and
    <code*|#f> respectively.
  </footnote>

  Conditional expressions are evaluated as follows. The predicate
  <math|<around*|\<langle\>|p<rsub|1>|\<rangle\>>> is evaluated first. If its
  value is false, then <math|<around*|\<langle\>|p<rsub|2>|\<rangle\>>> is
  evaluated. If <math|<around*|\<langle\>|p<rsub|2>|\<rangle\>>>'s value is
  also false, then <math|<around*|\<langle\>|p<rsub|3>|\<rangle\>>> is
  evaluated. This process continues until a predicate is found whose value is
  true, in which case the interpreter returns the value of the corresponding
  <em|consequent expression><index|consequent expression>
  <math|<around*|\<langle\>|e|\<rangle\>>> of the clause as the value of the
  conditional expression. If none of the <math|<around*|\<langle\>|p|\<rangle\>>>'s
  is found to be true, the value of the <code*|cond> is undefined.

  The word <em|predicate><index|predicate> is used for procedures that return
  true or false, as well as for expressions that evaluate to true or false.
  The absolute-value procedure <code*|abs> makes use of the primitive
  predicates <code*|\<gtr\>>, <code*|\<less\>>, and <code*|=>.<\footnote>
    <code*|Abs> also uses the \Pminus\Q operator <code*|->, which, when used
    with a single operand, as in <code*|(- x)>, indicates negation.
  </footnote> These take two numbers as arguments and test whether the first
  number is, respectively, greater than, less than, or equal to the second
  number, returning true or false accordingly.

  Another way to write the absolute-value procedure is

  <\scm-code>
    (define (abs x)

    \ \ (cond ((\<less\> x 0) (- x))

    \ \ (else x)))
  </scm-code>

  which could be expressed in English as \PIf <math|x> is less than zero
  return <math|-x>; otherwise return <math|x>.\Q <code*|Else> is a special
  symbol that can be used in place of the
  <math|<around*|\<langle\>|p|\<rangle\>>> in the final clause of a
  <code*|cond>. This causes the <code*|cond> to return as its value the value
  of the corresponding <math|<around*|\<langle\>|e|\<rangle\>>> whenever all
  previous clauses have been bypassed. In fact, any expression that always
  evaluates to a true value could be used as the
  <math|<around*|\<langle\>|p|\<rangle\>>> here.

  Here is yet another way to write the absolute-value procedure:

  <\scm-code>
    (define (abs x)

    (if (\<less\> x 0) \ 

    \ \ \ \ (- x)

    \ \ \ \ x))
  </scm-code>

  This uses the special form <code*|if>, a restricted type of conditional
  that can be used when there are precisely two cases in the case analysis.
  The general form of an <code*|if> expression is

  <code|(if \<langle\><var|predicate>\<rangle\>
  \<langle\><var|consequent>\<rangle\> \<langle\><var|alternative>\<rangle\>)>

  To evaluate an <code*|if> expression, the interpreter starts by evaluating
  the <code*|\<langle\>><var|predicate><code*|\<rangle\>> part of the
  expression. If the <code*|\<langle\>><var|predicate><code*|\<rangle\>>
  evaluates to a true value, the interpreter then evaluates the
  <code*|\<langle\>><var|consequent><code*|\<rangle\>> and returns its value.
  Otherwise it evaluates the <code*|\<langle\>><var|alternative><code*|\<rangle\>>
  and returns its value.<\footnote>
    A minor difference between <code*|if> and <code*|cond> is that the
    <code*|\<langle\>><var|e><code*|\<rangle\>> part of each <code*|cond>
    clause may be a sequence of expressions. If the corresponding
    <code*|\<langle\>><var|p><code*|\<rangle\>> is found to be true, the
    expressions <code*|\<langle\>><var|e><code*|\<rangle\>> are evaluated in
    sequence and the value of the final expression in the sequence is
    returned as the value of the <code*|cond>. In an <code*|if> expression,
    however, the <code*|\<langle\>><var|consequent><code*|\<rangle\>> and
    <code*|\<langle\>><var|alternative><code*|\<rangle\>> must be single
    expressions.
  </footnote>

  In addition to primitive predicates such as <code*|\<less\>>, <code*|=>,
  and <code*|\<gtr\>>, there are logical composition operations, which enable
  us to construct compound predicates. The three most frequently used are
  these:

  <\description>
    <item*|(and \<langle\><var|e\<#2081\>>\<rangle\> \<ldots\>
    \<langle\><var|e\<#2099\>>\<rangle\>)>

    The interpreter evaluates the expressions
    <code*|\<langle\>><var|e><code*|\<rangle\>> one at a time, in
    left-to-right order. If any <code*|\<langle\>><var|e><code*|\<rangle\>>
    evaluates to false, the value of the <code*|and> expression is false, and
    the rest of the <code*|\<langle\>><var|e><code*|\<rangle\>>'s are not
    evaluated. If all <code*|\<langle\>><var|e><code*|\<rangle\>>'s evaluate
    to true values, the value of the <code*|and> expression is the value of
    the last one.

    <item*|(or \<langle\><var|e\<#2081\>>\<rangle\> \<ldots\>
    \<langle\><var|e\<#2099\>>\<rangle\>)>

    The interpreter evaluates the expressions
    <code*|\<langle\>><var|e><code*|\<rangle\>> one at a time, in
    left-to-right order. If any <code*|\<langle\>><var|e><code*|\<rangle\>>
    evaluates to a true value, that value is returned as the value of the
    <code*|or> expression, and the rest of the
    <code*|\<langle\>><var|e><code*|\<rangle\>>'s are not evaluated. If all
    <code*|\<langle\>><var|e><code*|\<rangle\>>'s evaluate to false, the
    value of the <code*|or> expression is false.

    <item*|(not \<langle\><var|e>\<rangle\>)>

    The value of a <code*|not> expression is true when the expression
    <code*|\<langle\>><var|e><code*|\<rangle\>> evaluates to false, and false
    otherwise.
  </description>

  Notice that <code*|and> and <code*|or> are special forms, not procedures,
  because the subexpressions are not necessarily all evaluated. <code*|Not>
  is an ordinary procedure.

  As an example of how these are used, the condition that a number <math|x>
  be in the range <math|5\<less\>x\<less\>10> may be expressed as

  <\scm-code>
    (and (\<gtr\> x 5) (\<less\> x 10))
  </scm-code>

  As another example, we can define a predicate to test whether one number is
  greater than or equal to another as

  <\scm-code>
    (define (\<gtr\>= x y)

    \ \ (or (\<gtr\> x y) (= x y)))
  </scm-code>

  or alternatively as

  <\scm-code>
    (define (\<gtr\>= x y)

    \ \ (not (\<less\> x y)))
  </scm-code>

  <\exercise>
    Below is a sequence of expressions. What is the result printed by the
    interpreter in response to each expression? Assume that the sequence is
    to be evaluated in the order in which it is presented.

    <\session|scheme|default>
      <\folded-io|Scheme] >
        10
      <|folded-io>
        10
      </folded-io>

      <\folded-io|Scheme] >
        (+ 5 3 4)
      <|folded-io>
        12
      </folded-io>

      <\folded-io|Scheme] >
        (- 9 1)
      <|folded-io>
        8
      </folded-io>

      <\folded-io|Scheme] >
        (/ 6 2)
      <|folded-io>
        3
      </folded-io>

      <\folded-io|Scheme] >
        (+ (* 2 4) (- 4 6))
      <|folded-io>
        6
      </folded-io>

      <\input|Scheme] >
        (define a 3)
      </input>

      <\input|Scheme] >
        (define b (+ a 1))
      </input>

      <\folded-io|Scheme] >
        (+ a b (* a b))
      <|folded-io>
        19
      </folded-io>

      <\folded-io|Scheme] >
        (= a b)
      <|folded-io>
        #f
      </folded-io>

      <\folded-io|Scheme] >
        (if (and (\<gtr\> b a) (\<less\> b (* a b)))

        \ \ \ \ b

        \ \ \ \ a)
      <|folded-io>
        4
      </folded-io>

      <\folded-io|Scheme] >
        (cond ((= a 4) 6)

        \ \ \ \ \ \ ((= b 4) (+ 6 7 a))

        \ \ \ \ \ \ (else 25))
      <|folded-io>
        16
      </folded-io>

      <\folded-io|Scheme] >
        (+ 2 (if (\<gtr\> b a) b a))
      <|folded-io>
        6
      </folded-io>

      <\folded-io|Scheme] >
        (* (cond ((\<gtr\> a b) a)

        \ \ \ \ \ \ \ \ \ ((\<less\> a b) b)

        \ \ \ \ \ \ \ \ \ (else -1)))
      <|folded-io>
        4
      </folded-io>

      <\input|Scheme] >
        \;
      </input>
    </session>
  </exercise>

  <\exercise>
    Translate the following expression into prefix form:
    <math|<frac|5+4+<around*|(|2-<around*|(|3-<around*|(|6+<frac|4|5>|)>|)>|)>|3<around*|(|6-2|)><around*|(|2-7|)>>>.
  </exercise>

  <\exercise>
    Define a procedure that takes three numbers as arguments and returns the
    sum of the squares of the two larger numbers.
  </exercise>

  <\exercise>
    \ Observe that our model of evaluation allows for combinations whose
    operators are compound expressions. Use this observation to describe the
    behavior of the following procedure:

    <\scm-code>
      (define (a-plus-abs-b a b)

      \ \ ((if (\<gtr\> b 0) + -) a b))
    </scm-code>
  </exercise>

  <\exercise>
    Ben Bitdiddle has invented a test to determine whether the interpreter he
    is faced with is using applicative-order evaluation or normal-order
    evaluation. He defines the following two procedures:

    <\scm-code>
      (define (p) (p))

      \;

      (define (test x y)

      \ \ (if (= x 0)

      \ \ \ \ \ \ 0

      \ \ \ \ \ \ y))
    </scm-code>

    Then he evaluates the expression

    <\scm-code>
      (test 0 (p))
    </scm-code>

    What behavior will Ben observe with an interpreter that uses
    applicative-order evaluation? What behavior will he observe with an
    interpreter that uses normal-order evaluation? Explain your answer.
    (Assume that the evaluation rule for the special form <code*|if> is the
    same whether the interpreter is using normal or applicative order: The
    predicate expression is evaluated first, and the result determines
    whether to evaluate the consequent or the alternative expression.)
  </exercise>

  <subsection|Example: Square Roots by Newton's Method><label|1.1.7>

  Procedures, as introduced above, are much like ordinary mathematical
  functions. They specify a value that is determined by one or more
  parameters. But there is an important difference between mathematical
  functions and computer procedures. Procedures must be effective.

  As a case in point, consider the problem of computing square roots. We can
  define the square-root function as <math|<sqrt|x>=<with|mode|text|the> y
  <with|mode|text|such that> y\<geq\>0 <with|mode|text|and> y<rsup|2>=x>.
  This describes a perfectly legitimate mathematical function. We could use
  it to recognize whether one number is the square root of another, or to
  derive facts about square roots in general. On the other hand, the
  definition does not describe a procedure. Indeed, it tells us almost
  nothing about how to actually find the square root of a given number. It
  will not help matters to rephrase this definition in pseudo-Lisp:

  <\scm-code>
    (define (sqrt x)

    \ \ (the y (and (\<gtr\>= y 0)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ (= (square y) x))))
  </scm-code>

  This only begs the question.

  The contrast between function and procedure is a reflection of the general
  distinction between describing properties of things and describing how to
  do things, or, as it is sometimes referred to, the distinction between
  declarative knowledge and imperative knowledge. In mathematics we are
  usually concerned with declarative (what is) descriptions, whereas in
  computer science we are usually concerned with imperative (how to)
  descriptions.<\footnote>
    Declarative and imperative descriptions are intimately related, as indeed
    are mathematics and computer science. For instance, to say that the
    answer produced by a program is \Pcorrect\Q is to make a declarative
    statement about the program. There is a large amount of research aimed at
    establishing techniques for proving that programs are correct, and much
    of the technical difficulty of this subject has to do with negotiating
    the transition between imperative statements (from which programs are
    constructed) and declarative statements (which can be used to deduce
    things). In a related vein, an important current area in
    programming-language design is the exploration of so-called very
    high-level languages, in which one actually programs in terms of
    declarative statements. The idea is to make interpreters sophisticated
    enough so that, given \Pwhat is\Q knowledge specified by the programmer,
    they can generate \Phow to\Q knowledge automatically. This cannot be done
    in general, but there are important areas where progress has been made.
    We shall revisit this idea in <hlink|Chapter
    4|Chapter-4.xhtml#Chapter-4>.
  </footnote>

  How does one compute square roots? The most common way is to use Newton's
  method of successive approximations, which says that whenever we have a
  guess <math|y> for the value of the square root of a number <math|x>, we
  can perform a simple manipulation to get a better guess (one closer to the
  actual square root) by averaging <math|y> with
  <math|x<around*|/|y|\<nobracket\>>>.<hlink||#FOOT21><\footnote>
    This square-root algorithm is actually a special case of Newton's method,
    which is a general technique for finding roots of equations. The
    square-root algorithm itself was developed by Heron of Alexandria in the
    first century <abbr|A.D.> We will see how to express the general Newton's
    method as a Lisp procedure in <hlink|1.3.4|1_002e3.xhtml#g_t1_002e3_002e4>.
  </footnote> For example, we can compute the square root of 2 as follows.
  Suppose our initial guess is 1:

  <\code>
    Guess \ \ \ \ Quotient \ \ \ \ \ Average

    \;

    1 \ \ \ \ \ \ \ \ (2/1) \ = 2 \ \ \ ((2 + 1)/2) \ = 1.5

    \;

    1.5 \ \ \ \ \ \ (2/1.5) \ \ \ \ \ \ ((1.3333 + 1.5)/2)

    \ \ \ \ \ \ \ \ \ \ \ \ = 1.3333 \ \ \ \ \ = 1.4167

    \;

    1.4167 \ \ \ (2/1.4167) \ \ \ ((1.4167 + 1.4118)/2)\ 

    \ \ \ \ \ \ \ \ \ \ \ \ = 1.4118 \ \ \ \ \ = 1.4142 \ 

    \;

    1.4142 \ \ \ ... \ \ \ \ \ \ \ \ \ \ ...
  </code>

  Continuing this process, we obtain better and better approximations to the
  square root.

  Now let's formalize the process in terms of procedures. We start with a
  value for the radicand (the number whose square root we are trying to
  compute) and a value for the guess. If the guess is good enough for our
  purposes, we are done; if not, we must repeat the process with an improved
  guess. We write this basic strategy as a procedure:

  <\scm-code>
    (define (sqrt-iter guess x)

    \ \ (if (good-enough? guess x)

    \ \ \ \ \ \ guess

    \ \ \ \ \ \ (sqrt-iter (improve guess x)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ x)))
  </scm-code>

  A guess is improved by averaging it with the quotient of the radicand and
  the old guess:

  <\scm-code>
    (define (improve guess x)

    \ \ (average guess (/ x guess)))
  </scm-code>

  where

  <\scm-code>
    (define (average x y)

    \ \ (/ (+ x y) 2))
  </scm-code>

  We also have to say what we mean by \Pgood enough.\Q The following will do
  for illustration, but it is not really a very good test. (See
  <hlink|Exercise 1.7|#Exercise-1_002e7>.) The idea is to improve the answer
  until it is close enough so that its square differs from the radicand by
  less than a predetermined tolerance (here 0.001):<\footnote>
    We will usually give predicates names ending with question marks, to help
    us remember that they are predicates. This is just a stylistic
    convention. As far as the interpreter is concerned, the question mark is
    just an ordinary character.
  </footnote>

  <\scm-code>
    (define (good-enough? guess x)

    \ \ (\<less\> (abs (- (square guess) x)) 0.001))
  </scm-code>

  Finally, we need a way to get started. For instance, we can always guess
  that the square root of any number is 1:<\footnote>
    Observe that we express our initial guess as 1.0 rather than 1. This
    would not make any difference in many Lisp implementations. <abbr|MIT>
    Scheme, however, distinguishes between exact integers and decimal values,
    and dividing two integers produces a rational number rather than a
    decimal. For example, dividing 10 by 6 yields 5/3, while dividing 10.0 by
    6.0 yields 1.6666666666666667. (We will learn how to implement arithmetic
    on rational numbers in <hlink|2.1.1|2_002e1.xhtml#g_t2_002e1_002e1>.) If
    we start with an initial guess of 1 in our square-root program, and
    <math|x> is an exact integer, all subsequent values produced in the
    square-root computation will be rational numbers rather than decimals.
    Mixed operations on rational numbers and decimals always yield decimals,
    so starting with an initial guess of 1.0 forces all subsequent values to
    be decimals.
  </footnote>

  <\scm-code>
    (define (sqrt x)

    \ \ (sqrt-iter 1.0 x))
  </scm-code>

  If we type these definitions to the interpreter, we can use <code*|sqrt>
  just as we can use any procedure:

  <\scm-code>
    (sqrt 9)

    3.00009155413138

    (sqrt (+ 100 37))

    11.704699917758145

    (sqrt (+ (sqrt 2) (sqrt 3)))

    1.7739279023207892

    (square (sqrt 1000))

    1000.000369924366
  </scm-code>

  The <code*|sqrt> program also illustrates that the simple procedural
  language we have introduced so far is sufficient for writing any purely
  numerical program that one could write in, say, C or Pascal. This might
  seem surprising, since we have not included in our language any iterative
  (looping) constructs that direct the computer to do something over and over
  again. <code*|Sqrt-iter>, on the other hand, demonstrates how iteration can
  be accomplished using no special construct other than the ordinary ability
  to call a procedure.<\footnote>
    Readers who are worried about the efficiency issues involved in using
    procedure calls to implement iteration should note the remarks on \Ptail
    recursion\Q in <hlink|1.2.1|1_002e2.xhtml#g_t1_002e2_002e1>.
  </footnote>

  <\exercise>
    Alyssa P. Hacker doesn't see why <code*|if> needs to be provided as a
    special form. \PWhy can't I just define it as an ordinary procedure in
    terms of <code*|cond>?\Q she asks. Alyssa's friend Eva Lu Ator claims
    this can indeed be done, and she defines a new version of <code*|if>:

    <\scm-code>
      (define (new-if predicate then-clause else-clause)

      \ \ (cond (predicate then-clause)

      \ \ \ \ \ \ \ \ (else else-clause)))
    </scm-code>

    Eva demonstrates the program for Alyssa:

    <\scm-code>
      (new-if (= 2 3) 0 5)

      <with|font-shape|italic|5>

      \;

      (new-if (= 1 1) 0 5)

      <with|font-shape|italic|0>
    </scm-code>

    Delighted, Alyssa uses <code*|new-if> to rewrite the square-root program:

    <\scm-code>
      (define (sqrt-iter guess x)

      \ \ (new-if (good-enough? guess x)

      \ \ \ \ \ \ \ \ \ \ guess

      \ \ \ \ \ \ \ \ \ \ (sqrt-iter (improve guess x)

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ x)))
    </scm-code>

    What happens when Alyssa attempts to use this to compute square roots?
    Explain.
  </exercise>

  <\exercise>
    The <code*|good-enough?> test used in computing square roots will not be
    very effective for finding the square roots of very small numbers. Also,
    in real computers, arithmetic operations are almost always performed with
    limited precision. This makes our test inadequate for very large numbers.
    Explain these statements, with examples showing how the test fails for
    small and large numbers. An alternative strategy for implementing
    <code*|good-enough?> is to watch how <code*|guess> changes from one
    iteration to the next and to stop when the change is a very small
    fraction of the guess. Design a square-root procedure that uses this kind
    of end test. Does this work better for small and large numbers?
  </exercise>

  <\exercise>
    Newton's method for cube roots is based on the fact that if <math|y> is
    an approximation to the cube root of <math|x>, then a better
    approximation is given by the value <math|<frac|x<around*|/|y<rsup|2>+2*y|\<nobracket\>>|3>>.
    Use this formula to implement a cube-root procedure analogous to the
    square-root procedure. (In <hlink|1.3.4|1_002e3.xhtml#g_t1_002e3_002e4>
    we will see how to implement Newton's method in general as an abstraction
    of these square-root and cube-root procedures.)
  </exercise>

  <subsection|Procedures as Black-Box Abstractions><label|1.1.8>

  <code*|Sqrt> is our first example of a process defined by a set of mutually
  defined procedures. Notice that the definition of <code*|sqrt-iter> is
  <em|recursive><index|recursive>; that is, the procedure is defined in terms
  of itself. The idea of being able to define a procedure in terms of itself
  may be disturbing; it may seem unclear how such a \Pcircular\Q definition
  could make sense at all, much less specify a well-defined process to be
  carried out by a computer. This will be addressed more carefully in
  <hlink|1.2|1_002e2.xhtml#g_t1_002e2>. But first let's consider some other
  important points illustrated by the <code*|sqrt> example.

  Observe that the problem of computing square roots breaks up naturally into
  a number of subproblems: how to tell whether a guess is good enough, how to
  improve a guess, and so on. Each of these tasks is accomplished by a
  separate procedure. The entire <code*|sqrt> program can be viewed as a
  cluster of procedures (shown in <hlink|Figure 1.2|#fig1.2>) that mirrors
  the decomposition of the problem into subproblems.

  <\big-figure|<tree|sqrt|<tree|sqrt-iter|<tree|good-enough|square|abs>|<tree|improve|average>>>>
    <label|fig1.2>Procedural decomposition of the <scm|sqrt> program
  </big-figure>

  The importance of this decomposition strategy is not simply that one is
  dividing the program into parts. After all, we could take any large program
  and divide it into parts\Vthe first ten lines, the next ten lines, the next
  ten lines, and so on. Rather, it is crucial that each procedure
  accomplishes an identifiable task that can be used as a module in defining
  other procedures. For example, when we define the <code*|good-enough?>
  procedure in terms of <code*|square>, we are able to regard the
  <code*|square> procedure as a \Pblack box.\Q We are not at that moment
  concerned with <em|how> the procedure computes its result, only with the
  fact that it computes the square. The details of how the square is computed
  can be suppressed, to be considered at a later time. Indeed, as far as the
  <code*|good-enough?> procedure is concerned, <code*|square> is not quite a
  procedure but rather an abstraction of a procedure, a so-called
  <em|procedural abstraction><index|procedural abstraction>. At this level of
  abstraction, any procedure that computes the square is equally good.

  Thus, considering only the values they return, the following two procedures
  for squaring a number should be indistinguishable. Each takes a numerical
  argument and produces the square of that number as the value.<\footnote>
    It is not even clear which of these procedures is a more efficient
    implementation. This depends upon the hardware available. There are
    machines for which the \Pobvious\Q implementation is the less efficient
    one. Consider a machine that has extensive tables of logarithms and
    antilogarithms stored in a very efficient manner.
  </footnote>

  <\scm-code>
    (define (square x) (* x x))

    \;

    (define (square x)\ 

    \ \ (exp (double (log x))))

    \;

    (define (double x) (+ x x))
  </scm-code>

  So a procedure definition should be able to suppress detail. The users of
  the procedure may not have written the procedure themselves, but may have
  obtained it from another programmer as a black box. A user should not need
  to know how the procedure is implemented in order to use it.

  <paragraph*|Local names>

  One detail of a procedure's implementation that should not matter to the
  user of the procedure is the implementer's choice of names for the
  procedure's formal parameters. Thus, the following procedures should not be
  distinguishable:

  <\scm-code>
    (define (square x) (* x x))

    \;

    (define (square y) (* y y))
  </scm-code>

  This principle\Vthat the meaning of a procedure should be independent of
  the parameter names used by its author\Vseems on the surface to be
  self-evident, but its consequences are profound. The simplest consequence
  is that the parameter names of a procedure must be local to the body of the
  procedure. For example, we used <code*|square> in the definition of
  <code*|good-enough?> in our square-root procedure:

  <\scm-code>
    (define (good-enough? guess x)

    \ \ (\<less\> (abs (- (square guess) x)) 0.001))
  </scm-code>

  The intention of the author of <code*|good-enough?> is to determine if the
  square of the first argument is within a given tolerance of the second
  argument. We see that the author of <code*|good-enough?> used the name
  <code*|guess> to refer to the first argument and <code*|x> to refer to the
  second argument. The argument of <code*|square> is <code*|guess>. If the
  author of <code*|square> used <code*|x> (as above) to refer to that
  argument, we see that the <code*|x> in <code*|good-enough?> must be a
  different <code*|x> than the one in <code*|square>. Running the procedure
  <code*|square> must not affect the value of <code*|x> that is used by
  <code*|good-enough?>, because that value of <code*|x> may be needed by
  <code*|good-enough?> after <code*|square> is done computing.

  If the parameters were not local to the bodies of their respective
  procedures, then the parameter <code*|x> in <code*|square> could be
  confused with the parameter <code*|x> in <code*|good-enough?>, and the
  behavior of <code*|good-enough?> would depend upon which version of
  <code*|square> we used. Thus, <code*|square> would not be the black box we
  desired.

  A formal parameter of a procedure has a very special role in the procedure
  definition, in that it doesn't matter what name the formal parameter has.
  Such a name is called a <em|bound variable><index|bound variable>, and we
  say that the procedure definition <em|binds><index|binds> its formal
  parameters. The meaning of a procedure definition is unchanged if a bound
  variable is consistently renamed throughout the definition.<\footnote>
    The concept of consistent renaming is actually subtle and difficult to
    define formally. Famous logicians have made embarrassing errors here.
  </footnote> If a variable is not bound, we say that it is
  <em|free><index|free>. The set of expressions for which a binding defines a
  name is called the <em|scope><index|scope> of that name. In a procedure
  definition, the bound variables declared as the formal parameters of the
  procedure have the body of the procedure as their scope.

  In the definition of <code*|good-enough?> above, <code*|guess> and
  <code*|x> are bound variables but <code*|\<less\>>, <code*|->, <code*|abs>,
  and <code*|square> are free. The meaning of <code*|good-enough?> should be
  independent of the names we choose for <code*|guess> and <code*|x> so long
  as they are distinct and different from <code*|\<less\>>, <code*|->,
  <code*|abs>, and <code*|square>. (If we renamed <code*|guess> to
  <code*|abs> we would have introduced a bug by
  <em|capturing><index|capturing> the variable <code*|abs>. It would have
  changed from free to bound.) The meaning of <code*|good-enough?> is not
  independent of the names of its free variables, however. It surely depends
  upon the fact (external to this definition) that the symbol <code*|abs>
  names a procedure for computing the absolute value of a number.
  <code*|Good-enough?> will compute a different function if we substitute
  <code*|cos> for <code*|abs> in its definition.

  <paragraph*|Internal definitions and block structure>

  We have one kind of name isolation available to us so far: The formal
  parameters of a procedure are local to the body of the procedure. The
  square-root program illustrates another way in which we would like to
  control the use of names. The existing program consists of separate
  procedures:

  <\scm-code>
    (define (sqrt x)

    \ \ (sqrt-iter 1.0 x))

    (define (sqrt-iter guess x)

    \ \ (if (good-enough? guess x)

    \ \ \ \ \ \ guess

    \ \ \ \ \ \ (sqrt-iter (improve guess x) x)))

    (define (good-enough? guess x)

    \ \ (\<less\> (abs (- (square guess) x)) 0.001))

    (define (improve guess x)

    \ \ (average guess (/ x guess)))
  </scm-code>

  The problem with this program is that the only procedure that is important
  to users of <code*|sqrt> is <code*|sqrt>. The other procedures
  (<code*|sqrt-iter>, <code*|good-enough?>, and <code*|improve>) only clutter
  up their minds. They may not define any other procedure called
  <code*|good-enough?> as part of another program to work together with the
  square-root program, because <code*|sqrt> needs it. The problem is
  especially severe in the construction of large systems by many separate
  programmers. For example, in the construction of a large library of
  numerical procedures, many numerical functions are computed as successive
  approximations and thus might have procedures named <code*|good-enough?>
  and <code*|improve> as auxiliary procedures. We would like to localize the
  subprocedures, hiding them inside <code*|sqrt> so that <code*|sqrt> could
  coexist with other successive approximations, each having its own private
  <code*|good-enough?> procedure. To make this possible, we allow a procedure
  to have internal definitions that are local to that procedure. For example,
  in the square-root problem we can write

  <\scm-code>
    (define (sqrt x)

    \ \ (define (good-enough? guess x)

    \ \ \ \ (\<less\> (abs (- (square guess) x)) 0.001))

    \ \ (define (improve guess x)

    \ \ \ \ (average guess (/ x guess)))

    \ \ (define (sqrt-iter guess x)

    \ \ \ \ (if (good-enough? guess x)

    \ \ \ \ \ \ \ \ guess

    \ \ \ \ \ \ \ \ (sqrt-iter (improve guess x) x)))

    \ \ (sqrt-iter 1.0 x))
  </scm-code>

  Such nesting of definitions, called <em|block structure><index|block
  structure>, is basically the right solution to the simplest name-packaging
  problem. But there is a better idea lurking here. In addition to
  internalizing the definitions of the auxiliary procedures, we can simplify
  them. Since <code*|x> is bound in the definition of <code*|sqrt>, the
  procedures <code*|good-enough?>, <code*|improve>, and <code*|sqrt-iter>,
  which are defined internally to <code*|sqrt>, are in the scope of
  <code*|x>. Thus, it is not necessary to pass <code*|x> explicitly to each
  of these procedures. Instead, we allow <code*|x> to be a free variable in
  the internal definitions, as shown below. Then <code*|x> gets its value
  from the argument with which the enclosing procedure <code*|sqrt> is
  called. This discipline is called <em|lexical scoping><index|lexical
  scoping>.<\footnote>
    Lexical scoping dictates that free variables in a procedure are taken to
    refer to bindings made by enclosing procedure definitions; that is, they
    are looked up in the environment in which the procedure was defined. We
    will see how this works in detail in chapter 3 when we study environments
    and the detailed behavior of the interpreter.
  </footnote>

  <\scm-code>
    (define (sqrt x)

    \ \ (define (good-enough? guess)

    \ \ \ \ (\<less\> (abs (- (square guess) x)) 0.001))

    \ \ (define (improve guess)

    \ \ \ \ (average guess (/ x guess)))

    \ \ (define (sqrt-iter guess)

    \ \ \ \ (if (good-enough? guess)

    \ \ \ \ \ \ \ \ guess

    \ \ \ \ \ \ \ \ (sqrt-iter (improve guess))))

    \ \ (sqrt-iter 1.0))
  </scm-code>

  We will use block structure extensively to help us break up large programs
  into tractable pieces.<\footnote>
    Embedded definitions must come first in a procedure body. The management
    is not responsible for the consequences of running programs that
    intertwine definition and use.
  </footnote> The idea of block structure originated with the programming
  language Algol 60. It appears in most advanced programming languages and is
  an important tool for helping to organize the construction of large
  programs.

  <section|Procedures and the Processes They Generate>

  We have now considered the elements of programming: We have used primitive
  arithmetic operations, we have combined these operations, and we have
  abstracted these composite operations by defining them as compound
  procedures. But that is not enough to enable us to say that we know how to
  program. Our situation is analogous to that of someone who has learned the
  rules for how the pieces move in chess but knows nothing of typical
  openings, tactics, or strategy. Like the novice chess player, we don't yet
  know the common patterns of usage in the domain. We lack the knowledge of
  which moves are worth making (which procedures are worth defining). We lack
  the experience to predict the consequences of making a move (executing a
  procedure).

  The ability to visualize the consequences of the actions under
  consideration is crucial to becoming an expert programmer, just as it is in
  any synthetic, creative activity. In becoming an expert photographer, for
  example, one must learn how to look at a scene and know how dark each
  region will appear on a print for each possible choice of exposure and
  development conditions. Only then can one reason backward, planning
  framing, lighting, exposure, and development to obtain the desired effects.
  So it is with programming, where we are planning the course of action to be
  taken by a process and where we control the process by means of a program.
  To become experts, we must learn to visualize the processes generated by
  various types of procedures. Only after we have developed such a skill can
  we learn to reliably construct programs that exhibit the desired behavior.

  A procedure is a pattern for the <em|local evolution><index|local
  evolution> of a computational process. It specifies how each stage of the
  process is built upon the previous stage. We would like to be able to make
  statements about the overall, or <em|global><index|global>, behavior of a
  process whose local evolution has been specified by a procedure. This is
  very difficult to do in general, but we can at least try to describe some
  typical patterns of process evolution.

  In this section we will examine some common \Pshapes\Q for processes
  generated by simple procedures. We will also investigate the rates at which
  these processes consume the important computational resources of time and
  space. The procedures we will consider are very simple. Their role is like
  that played by test patterns in photography: as oversimplified prototypical
  patterns, rather than practical examples in their own right.

  <subsection|Linear Recursion and Iteration><label|1.2.1>

  We begin by considering the factorial function, defined by
  <math|n!=n\<cdot\><around*|(|n-1|)>\<cdot\><around*|(|n-2|)>*\<cdots\>*3\<cdot\>2\<cdot\>1>.
  There are many ways to compute factorials. One way is to make use of the
  observation that <math|n>! is equal to <math|n> times
  <math|<around*|(|n-1|)>>! for any positive integer <math|n>:
  <math|n!=n\<cdot\><around*|[|<around*|(|n-1|)>\<cdot\><around*|(|n-2|)>*\<cdots\>*3\<cdot\>2\<cdot\>1|]>=n\<cdot\><around*|(|n-1|)>>!.
  Thus, we can compute <math|n>! by computing <math|<around*|(|n-1|)>>! and
  multiplying the result by <math|n>. If we add the stipulation that 1! is
  equal to 1, this observation translates directly into a procedure:

  <\scm-code>
    (define (factorial n)

    \ \ (if (= n 1)

    \ \ \ \ \ \ 1

    \ \ \ \ \ \ (* n (factorial (- n 1)))))
  </scm-code>

  We can use the substitution model of <hlink|1.1.5|#1.1.5> to watch this
  procedure in action computing 6!, as shown in <hlink|Figure 1.3|#fig1.3>.

  <\big-figure>
    <\scm-code>
      (factorial 6)

      (* 6 (factorial 5))

      (* 6 (* 5 (factorial 4)))

      (* 6 (* 5 (* 4 (factorial 3))))

      (* 6 (* 5 (* 4 (* 3 (factorial 2)))))

      (* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))

      (* 6 (* 5 (* 4 (* 3 (* 2 1)))))

      (* 6 (* 5 (* 4 (* 3 2))))

      (* 6 (* 5 (* 4 6)))

      (* 6 (* 5 24))

      (* 6 120)

      720
    </scm-code>
  <|big-figure>
    <label|fig1.3>A linear recursive process for computing 6!.
  </big-figure>

  Now let's take a different perspective on computing factorials. We could
  describe a rule for computing <math|n>! by specifying that we first
  multiply 1 by 2, then multiply the result by 3, then by 4, and so on until
  we reach <math|n>. More formally, we maintain a running product, together
  with a counter that counts from 1 up to <math|n>. We can describe the
  computation by saying that the counter and the product simultaneously
  change from one step to the next according to the rule

  <\code>
    product <math|\<leftarrow\>> counter * product

    counter <math|\<leftarrow\>> counter + 1
  </code>

  and stipulating that <math|n>! is the value of the product when the counter
  exceeds <math|n>.

  Once again, we can recast our description as a procedure for computing
  factorials:<\footnote>
    In a real program we would probably use the block structure introduced in
    the last section to hide the definition of <code*|fact-iter>:

    <\scm-code>
      (define (factorial n)

      \ \ (define (iter product counter)

      \ \ \ \ (if (\<gtr\> counter n)

      \ \ \ \ \ \ \ \ product

      \ \ \ \ \ \ \ \ (iter (* counter product)

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ (+ counter 1))))

      \ \ (iter 1 1))
    </scm-code>

    We avoided doing this here so as to minimize the number of things to
    think about at once.
  </footnote>

  <\scm-code>
    (define (factorial n)

    \ \ (fact-iter 1 1 n))

    \;

    (define (fact-iter product counter max-count)

    \ \ (if (\<gtr\> counter max-count)

    \ \ \ \ \ \ product

    \ \ \ \ \ \ (fact-iter (* counter product)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (+ counter 1)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ max-count)))
  </scm-code>

  As before, we can use the substitution model to visualize the process of
  computing 6!, as shown in <hlink|Figure 1.4|#fig1.4>.

  <\big-figure>
    <\scm-code>
      (factorial 6)

      (fact-iter 1 \ \ 1 6)

      (fact-iter 1 \ \ 2 6)

      (fact-iter 2 \ \ 3 6)

      (fact-iter 6 \ \ 4 6)

      (fact-iter 24 \ 5 6)

      (fact-iter 120 6 6)

      (fact-iter 720 7 6)

      720
    </scm-code>
  <|big-figure>
    <label|fig1.4>A linear iterative process for computing 6!.
  </big-figure>

  Compare the two processes. From one point of view, they seem hardly
  different at all. Both compute the same mathematical function on the same
  domain, and each requires a number of steps proportional to <math|n> to
  compute <math|n>!. Indeed, both processes even carry out the same sequence
  of multiplications, obtaining the same sequence of partial products. On the
  other hand, when we consider the \Pshapes\Q of the two processes, we find
  that they evolve quite differently.

  Consider the first process. The substitution model reveals a shape of
  expansion followed by contraction, indicated by the arrow in <hlink|Figure
  1.3|#fig1.3>. The expansion occurs as the process builds up a chain of
  <em|deferred operations><index|deferred operations> (in this case, a chain
  of multiplications). The contraction occurs as the operations are actually
  performed. This type of process, characterized by a chain of deferred
  operations, is called a <em|recursive process><index|recursive process>.
  Carrying out this process requires that the interpreter keep track of the
  operations to be performed later on. In the computation of <math|n>!, the
  length of the chain of deferred multiplications, and hence the amount of
  information needed to keep track of it, grows linearly with <math|n> (is
  proportional to <math|n>), just like the number of steps. Such a process is
  called a <em|linear recursive process><index|linear recursive process>.

  By contrast, the second process does not grow and shrink. At each step, all
  we need to keep track of, for any <math|n>, are the current values of the
  variables <code*|product>, <code*|counter>, and <code*|max-count>. We call
  this an <em|iterative process><index|iterative process>. In general, an
  iterative process is one whose state can be summarized by a fixed number of
  <em|state variables><index|state variables>, together with a fixed rule
  that describes how the state variables should be updated as the process
  moves from state to state and an (optional) end test that specifies
  conditions under which the process should terminate. In computing
  <math|n>!, the number of steps required grows linearly with <math|n>. Such
  a process is called a <em|linear iterative process><index|linear iterative
  process>.

  The contrast between the two processes can be seen in another way. In the
  iterative case, the program variables provide a complete description of the
  state of the process at any point. If we stopped the computation between
  steps, all we would need to do to resume the computation is to supply the
  interpreter with the values of the three program variables. Not so with the
  recursive process. In this case there is some additional \Phidden\Q
  information, maintained by the interpreter and not contained in the program
  variables, which indicates \Pwhere the process is\Q in negotiating the
  chain of deferred operations. The longer the chain, the more information
  must be maintained.<\footnote>
    When we discuss the implementation of procedures on register machines in
    <hlink|Chapter 5|Chapter-5.xhtml#Chapter-5>, we will see that any
    iterative process can be realized \Pin hardware\Q as a machine that has a
    fixed set of registers and no auxiliary memory. In contrast, realizing a
    recursive process requires a machine that uses an auxiliary data
    structure known as a <label|index-stack> <em|stack>.
  </footnote>

  In contrasting iteration and recursion, we must be careful not to confuse
  the notion of a recursive <em|process><index|process> with the notion of a
  recursive <em|procedure><index|procedure>. When we describe a procedure as
  recursive, we are referring to the syntactic fact that the procedure
  definition refers (either directly or indirectly) to the procedure itself.
  But when we describe a process as following a pattern that is, say,
  linearly recursive, we are speaking about how the process evolves, not
  about the syntax of how a procedure is written. It may seem disturbing that
  we refer to a recursive procedure such as <code*|fact-iter> as generating
  an iterative process. However, the process really is iterative: Its state
  is captured completely by its three state variables, and an interpreter
  need keep track of only three variables in order to execute the process.

  One reason that the distinction between process and procedure may be
  confusing is that most implementations of common languages (including Ada,
  Pascal, and C) are designed in such a way that the interpretation of any
  recursive procedure consumes an amount of memory that grows with the number
  of procedure calls, even when the process described is, in principle,
  iterative. As a consequence, these languages can describe iterative
  processes only by resorting to special-purpose \Plooping constructs\Q such
  as <code*|do>, <code*|repeat>, <code*|until>, <code*|for>, and
  <code*|while>. The implementation of Scheme we shall consider in
  <hlink|Chapter 5|Chapter-5.xhtml#Chapter-5> does not share this defect. It
  will execute an iterative process in constant space, even if the iterative
  process is described by a recursive procedure. An implementation with this
  property is called <em|tail-recursive><index|tail-recursive>. With a
  tail-recursive implementation, iteration can be expressed using the
  ordinary procedure call mechanism, so that special iteration constructs are
  useful only as syntactic sugar.<hlink||#FOOT31><\footnote>
    Tail recursion has long been known as a compiler optimization trick. A
    coherent semantic basis for tail recursion was provided by Carl
    <hlink|Hewitt (1977)|References.xhtml#Hewitt-_00281977_0029>, who
    explained it in terms of the \Pmessage-passing\Q model of computation
    that we shall discuss in <hlink|Chapter 3|Chapter-3.xhtml#Chapter-3>.
    Inspired by this, Gerald Jay Sussman and Guy Lewis Steele Jr. (see
    <hlink|Steele and Sussman 1975|References.xhtml#Steele-and-Sussman-1975>)
    constructed a tail-recursive interpreter for Scheme. Steele later showed
    how tail recursion is a consequence of the natural way to compile
    procedure calls (<hlink|Steele 1977|References.xhtml#Steele-1977>). The
    <abbr|IEEE> standard for Scheme requires that Scheme implementations be
    tail-recursive.
  </footnote>

  <strong|<label|Exercise-1_002e9>Exercise 1.9:> Each of the following two
  procedures defines a method for adding two positive integers in terms of
  the procedures <code*|inc>, which increments its argument by 1, and
  <code*|dec>, which decrements its argument by 1.

  <\scm-code>
    (define (+ a b)

    \ \ (if (= a 0)

    \ \ \ \ \ \ b

    \ \ \ \ \ \ (inc (+ (dec a) b))))

    \;

    (define (+ a b)

    \ \ (if (= a 0)

    \ \ \ \ \ \ b

    \ \ \ \ \ \ (+ (dec a) (inc b))))
  </scm-code>

  Using the substitution model, illustrate the process generated by each
  procedure in evaluating <code*|(+ 4 5)>. Are these processes iterative or
  recursive?

  <strong|<label|Exercise-1_002e10>Exercise 1.10:> The following procedure
  computes a mathematical function called Ackermann's function.

  <\scm-code>
    (define (A x y)

    \ \ (cond ((= y 0) 0)

    \ \ \ \ \ \ \ \ ((= x 0) (* 2 y))

    \ \ \ \ \ \ \ \ ((= y 1) 2)

    \ \ \ \ \ \ \ \ (else (A (- x 1)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (A x (- y 1))))))
  </scm-code>

  What are the values of the following expressions?

  <\scm-code>
    (A 1 10)

    \;

    (A 2 4)

    \;

    (A 3 3)
  </scm-code>

  Consider the following procedures, where <code*|A> is the procedure defined
  above:

  <\scm-code>
    (define (f n) (A 0 n))

    \;

    (define (g n) (A 1 n))

    \;

    (define (h n) (A 2 n))

    \;

    (define (k n) (* 5 n n))
  </scm-code>

  Give concise mathematical definitions for the functions computed by the
  procedures <code*|f>, <code*|g>, and <code*|h> for positive integer values
  of <math|n>. For example, <code*|(k n)> computes <math|5*n<rsup|2>>.

  <subsection|Tree Recursion><label|1.2.2>

  Another common pattern of computation is called <em|tree
  recursion><index|tree recursion>. As an example, consider computing the
  sequence of Fibonacci numbers, in which each number is the sum of the
  preceding two:

  0, 1, 1, 2, 3, 5, 8, 13, 21, \<ldots\>.

  In general, the Fibonacci numbers can be defined by the rule

  <\equation*>
    <with|mode|text|Fib><around*|(|n|)>=<around*|{|<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|2|2|cell-halign|l>|<table|<row|<cell|0>|<cell|<with|mode|text|if>
    n=0,>>|<row|<cell|1>|<cell|<with|mode|text|if>
    n=1,>>|<row|<cell|<with|mode|text|Fib><around*|(|n-1|)>+<with|mode|text|Fib><around*|(|n-2|)>>|<cell|<with|mode|text|otherwise>.>>>>>|\<nobracket\>>
  </equation*>

  We can immediately translate this definition into a recursive procedure for
  computing Fibonacci numbers:

  <\session|scheme|default>
    <\input|Scheme] >
      <label|define_fib>(define (fib n)

      \ \ (cond ((= n 0) 0)

      \ \ \ \ \ \ \ \ ((= n 1) 1)

      \ \ \ \ \ \ \ \ (else (+ (fib (- n 1))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (fib (- n 2))))))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  <\big-figure|<tree|fib 5|<tree|fib 4|<tree|fib 3|<tree|fib 2|<tree|fib
  1|1>|<tree|fib 0|0>>>|<tree|fib 2|<tree|fib 1|1>|<tree|fib 0|0>>>|<tree|fib
  3|<tree|fib 2|<tree|fib 1|1>|<tree|fib 0|0>>>>>
    <label|fig1.5>The tree-recursive process generated in computing
    <code*|(fib 5)>.
  </big-figure>

  Consider the pattern of this computation. To compute <code*|(fib 5)>, we
  compute <code*|(fib 4)> and <code*|(fib 3)>. To compute <code*|(fib 4)>, we
  compute <code*|(fib 3)> and <code*|(fib 2)>. In general, the evolved
  process looks like a tree, as shown in <hlink|Figure 1.5|#fig1.5>. Notice
  that the branches split into two at each level (except at the bottom); this
  reflects the fact that the <code*|fib> procedure calls itself twice each
  time it is invoked.

  This procedure is instructive as a prototypical tree recursion, but it is a
  terrible way to compute Fibonacci numbers because it does so much redundant
  computation. Notice in <hlink|Figure 1.5|#fig1.5> that the entire
  computation of <code*|(fib 3)>\Valmost half the work\Vis duplicated. In
  fact, it is not hard to show that the number of times the procedure will
  compute <code*|(fib 1)> or <code*|(fib 0)> (the number of leaves in the
  above tree, in general) is precisely <math|<with|mode|text|Fib><around*|(|n+1|)>>.
  To get an idea of how bad this is, one can show that the value of
  <math|<with|mode|text|Fib><around*|(|n|)>> grows exponentially with
  <math|n>. More precisely (see <hlink|Exercise 1.13|#Exercise-1_002e13>),
  <math|<with|mode|text|Fib><around*|(|n|)>> is the closest integer to
  <math|\<varphi\><rsup|n><around*|/|<sqrt|5>|\<nobracket\>>>, where
  <math|\<varphi\>=<frac|1+<sqrt|5>|2>\<approx\>1.6180> is the <em|golden
  ratio><index|golden ratio>, which satisfies the equation
  <math|\<varphi\><rsup|2>=\<varphi\>+1>. Thus, the process uses a number of
  steps that grows exponentially with the input. On the other hand, the space
  required grows only linearly with the input, because we need keep track
  only of which nodes are above us in the tree at any point in the
  computation. In general, the number of steps required by a tree-recursive
  process will be proportional to the number of nodes in the tree, while the
  space required will be proportional to the maximum depth of the tree.

  We can also formulate an iterative process for computing the Fibonacci
  numbers. The idea is to use a pair of integers <math|a> and <math|b>,
  initialized to <math|<with|mode|text|Fib(1) = 1>> and
  <math|<with|mode|text|Fib(0) = 0>>, and to repeatedly apply the
  simultaneous transformations

  <math|<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<table|<row|<cell|a\<leftarrow\>a+b,>>|<row|<cell|b\<leftarrow\>a.>>>>>>

  It is not hard to show that, after applying this transformation <math|n>
  times, <math|a> and <math|b> will be equal, respectively, to
  <math|<with|mode|text|Fib><around*|(|n+1|)>> and
  <math|<with|mode|text|Fib><around*|(|n|)>>. Thus, we can compute Fibonacci
  numbers iteratively using the procedure

  <\scm-code>
    (define (fib n)

    \ \ (fib-iter 1 0 n))

    \;

    (define (fib-iter a b count)

    \ \ (if (= count 0)

    \ \ \ \ \ \ b

    \ \ \ \ \ \ (fib-iter (+ a b) a (- count 1))))
  </scm-code>

  This second method for computing <math|<with|mode|text|Fib><around*|(|n|)>>
  is a linear iteration. The difference in number of steps required by the
  two methods\Vone linear in <math|n>, one growing as fast as
  <math|<with|mode|text|Fib><around*|(|n|)>> itself\Vis enormous, even for
  small inputs.

  One should not conclude from this that tree-recursive processes are
  useless. When we consider processes that operate on hierarchically
  structured data rather than numbers, we will find that tree recursion is a
  natural and powerful tool.<hlink||#FOOT32><\footnote>
    An example of this was hinted at in <hlink|1.1.3|#1.1.3>. The interpreter
    itself evaluates expressions using a tree-recursive process.
  </footnote> But even in numerical operations, tree-recursive processes can
  be useful in helping us to understand and design programs. For instance,
  although the first <code*|fib> procedure is much less efficient than the
  second one, it is more straightforward, being little more than a
  translation into Lisp of the definition of the Fibonacci sequence. To
  formulate the iterative algorithm required noticing that the computation
  could be recast as an iteration with three state variables.

  <paragraph*|Example: Counting change>

  It takes only a bit of cleverness to come up with the iterative Fibonacci
  algorithm. In contrast, consider the following problem: How many different
  ways can we make change of $1.00, given half-dollars, quarters, dimes,
  nickels, and pennies? More generally, can we write a procedure to compute
  the number of ways to change any given amount of money?

  This problem has a simple solution as a recursive procedure. Suppose we
  think of the types of coins available as arranged in some order. Then the
  following relation holds:

  The number of ways to change amount <math|a> using <math|n> kinds of coins
  equals

  <\itemize>
    <item>the number of ways to change amount <math|a> using all but the
    first kind of coin, plus

    <item>the number of ways to change amount <math|a-d> using all <math|n>
    kinds of coins, where <math|d> is the denomination of the first kind of
    coin.
  </itemize>

  To see why this is true, observe that the ways to make change can be
  divided into two groups: those that do not use any of the first kind of
  coin, and those that do. Therefore, the total number of ways to make change
  for some amount is equal to the number of ways to make change for the
  amount without using any of the first kind of coin, plus the number of ways
  to make change assuming that we do use the first kind of coin. But the
  latter number is equal to the number of ways to make change for the amount
  that remains after using a coin of the first kind.

  Thus, we can recursively reduce the problem of changing a given amount to
  the problem of changing smaller amounts using fewer kinds of coins.
  Consider this reduction rule carefully, and convince yourself that we can
  use it to describe an algorithm if we specify the following degenerate
  cases:<\footnote>
    For example, work through in detail how the reduction rule applies to the
    problem of making change for 10 cents using pennies and nickels.
  </footnote>

  <\itemize>
    <item>If <math|a> is exactly 0, we should count that as 1 way to make
    change.

    <item>If <math|a> is less than 0, we should count that as 0 ways to make
    change.

    <item>If <math|n> is 0, we should count that as 0 ways to make change.
  </itemize>

  We can easily translate this description into a recursive procedure:

  <\session|scheme|default>
    <\input|Scheme] >
      (define (first-denomination kinds-of-coins)

      \ \ (cond ((= kinds-of-coins 1) 1)

      \ \ \ \ \ \ \ \ ((= kinds-of-coins 2) 5)

      \ \ \ \ \ \ \ \ ((= kinds-of-coins 3) 10)

      \ \ \ \ \ \ \ \ ((= kinds-of-coins 4) 25)

      \ \ \ \ \ \ \ \ ((= kinds-of-coins 5) 50)))

      (define (cc amount kinds-of-coins)

      \ \ (cond ((= amount 0) 1)

      \ \ \ \ \ \ \ \ ((or (\<less\> amount 0) (= kinds-of-coins 0)) 0)

      \ \ \ \ \ \ \ \ (else (+ (cc amount

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (- kinds-of-coins 1))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (cc (- amount

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (first-denomination
      kinds-of-coins))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ kinds-of-coins)))))

      (define (count-change amount)

      \ \ (cc amount 5))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  (The <code*|first-denomination> procedure takes as input the number of
  kinds of coins available and returns the denomination of the first kind.
  Here we are thinking of the coins as arranged in order from largest to
  smallest, but any order would do as well.) We can now answer our original
  question about changing a dollar:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (count-change 100)
    <|unfolded-io>
      292
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  <code*|Count-change> generates a tree-recursive process with redundancies
  similar to those in our first implementation of <code*|fib>. (It will take
  quite a while for that 292 to be computed.) On the other hand, it is not
  obvious how to design a better algorithm for computing the result, and we
  leave this problem as a challenge. The observation that a tree-recursive
  process may be highly inefficient but often easy to specify and understand
  has led people to propose that one could get the best of both worlds by
  designing a \Psmart compiler\Q that could transform tree-recursive
  procedures into more efficient procedures that compute the same
  result.<\footnote>
    One approach to coping with redundant computations is to arrange matters
    so that we automatically construct a table of values as they are
    computed. Each time we are asked to apply the procedure to some argument,
    we first look to see if the value is already stored in the table, in
    which case we avoid performing the redundant computation. This strategy,
    known as <em|tabulation><index|tabulation> or
    <em|memoization><index|memoization>, can be implemented in a
    straightforward way. Tabulation can sometimes be used to transform
    processes that require an exponential number of steps (such as
    <code*|count-change>) into processes whose space and time requirements
    grow linearly with the input. See <hlink|Exercise
    3.27|3_002e3.xhtml#Exercise-3_002e27>.
  </footnote>

  <strong|<label|Exercise-1_002e11>Exercise 1.11:> A function <math|f> is
  defined by the rule that <math|f<around*|(|n|)>=n> if <math|n\<less\>3> and
  <math|f<around*|(|n|)>=f<around*|(|n-1|)>+2*f<around*|(|n-2|)>+3*f<around*|(|n-3|)>>
  if <math|n\<geq\>3>. Write a procedure that computes <math|f> by means of a
  recursive process. Write a procedure that computes <math|f> by means of an
  iterative process.

  <strong|<label|Exercise-1_002e12>Exercise 1.12:> The following pattern of
  numbers is called <em|Pascal's triangle><index|Pascal's triangle>.

  <\code>
    \ \ \ \ \ \ \ \ \ 1

    \ \ \ \ \ \ \ 1 \ \ 1

    \ \ \ \ \ 1 \ \ 2 \ \ 1

    \ \ \ 1 \ \ 3 \ \ 3 \ \ 1

    \ 1 \ \ 4 \ \ 6 \ \ 4 \ \ 1

    \ \ \ \ \ \ \ . . .
  </code>

  The numbers at the edge of the triangle are all 1, and each number inside
  the triangle is the sum of the two numbers above it.<\footnote>
    The elements of Pascal's triangle are called the <em|binomial
    coefficients><index|binomial coefficients>, because the
    <math|n<rsup|<with|mode|text|th>>> row consists of the coefficients of
    the terms in the expansion of <math|<around*|(|x+y|)><rsup|n>>. This
    pattern for computing the coefficients appeared in Blaise Pascal's 1653
    seminal work on probability theory, <cite*|Traité du triangle
    arithmétique>. According to <hlink|Knuth
    (1973)|References.xhtml#Knuth-_00281973_0029>, the same pattern appears
    in the <cite*|Szu-yuen Yü-chien> (\PThe Precious Mirror of the Four
    Elements\Q), published by the Chinese mathematician Chu Shih-chieh in
    1303, in the works of the twelfth-century Persian poet and mathematician
    Omar Khayyam, and in the works of the twelfth-century Hindu mathematician
    Bháscara Áchárya.
  </footnote> Write a procedure that computes elements of Pascal's triangle
  by means of a recursive process.

  <strong|<label|Exercise-1_002e13>Exercise 1.13:> Prove that
  <math|<with|mode|text|Fib><around*|(|n|)>> is the closest integer to
  <math|\<varphi\><rsup|n><around*|/|<sqrt|5>|\<nobracket\>>>, where
  <math|\<varphi\>=<around*|(|1+<sqrt|5>|)><around*|/|2|\<nobracket\>>>.
  Hint: Let <math|\<psi\>=<around*|(|1-<sqrt|5>|)><around*|/|2|\<nobracket\>>>.
  Use induction and the definition of the Fibonacci numbers (see
  <hlink|1.2.2|#1.2.2>) to prove that <math|<with|mode|text|Fib><around*|(|n|)>=<around*|(|\<varphi\><rsup|n>-\<psi\><rsup|n>|)><around*|/|<sqrt|5>|\<nobracket\>>>.

  <subsection|Orders of Growth>

  The previous examples illustrate that processes can differ considerably in
  the rates at which they consume computational resources. One convenient way
  to describe this difference is to use the notion of <em|order of
  growth><index|order of growth> to obtain a gross measure of the resources
  required by a process as the inputs become larger.

  Let <math|n> be a parameter that measures the size of the problem, and let
  <math|R<around*|(|n|)>> be the amount of resources the process requires for
  a problem of size <math|n>. In our previous examples we took <math|n> to be
  the number for which a given function is to be computed, but there are
  other possibilities. For instance, if our goal is to compute an
  approximation to the square root of a number, we might take <math|n> to be
  the number of digits accuracy required. For matrix multiplication we might
  take <math|n> to be the number of rows in the matrices. In general there
  are a number of properties of the problem with respect to which it will be
  desirable to analyze a given process. Similarly, <math|R<around*|(|n|)>>
  might measure the number of internal storage registers used, the number of
  elementary machine operations performed, and so on. In computers that do
  only a fixed number of operations at a time, the time required will be
  proportional to the number of elementary machine operations performed.

  We say that <math|R<around*|(|n|)>> has order of growth
  <math|\<Theta\><around*|(|f<around*|(|n|)>|)>>, written
  <math|R<around*|(|n|)>=\<Theta\><around*|(|f<around*|(|n|)>|)>> (pronounced
  \Ptheta of <math|f<around*|(|n|)>>\Q), if there are positive constants
  <math|k<rsub|1>> and <math|k<rsub|2>> independent of <math|n> such that
  <math|k<rsub|1>*f<around*|(|n|)>\<leq\>R<around*|(|n|)>\<leq\>k<rsub|2>*f<around*|(|n|)>>
  for any sufficiently large value of <math|n>. (In other words, for large
  <math|n>, the value <math|R<around*|(|n|)>> is sandwiched between
  <math|k<rsub|1>*f<around*|(|n|)>> and <math|k<rsub|2>*f<around*|(|n|)>>.)

  For instance, with the linear recursive process for computing factorial
  described in <hlink|1.2.1|#1.2.1> the number of steps grows proportionally
  to the input <math|n>. Thus, the steps required for this process grows as
  <math|\<Theta\><around*|(|n|)>>. We also saw that the space required grows
  as <math|\<Theta\><around*|(|n|)>>. For the iterative factorial, the number
  of steps is still <math|\<Theta\><around*|(|n|)>> but the space is
  <math|\<Theta\><around*|(|1|)>>\Vthat is, constant.<\footnote>
    These statements mask a great deal of oversimplification. For instance,
    if we count process steps as \Pmachine operations\Q we are making the
    assumption that the number of machine operations needed to perform, say,
    a multiplication is independent of the size of the numbers to be
    multiplied, which is false if the numbers are sufficiently large. Similar
    remarks hold for the estimates of space. Like the design and description
    of a process, the analysis of a process can be carried out at various
    levels of abstraction.
  </footnote> The tree-recursive Fibonacci computation requires
  <math|\<Theta\><around*|(|\<varphi\><rsup|n>|)>> steps and space
  <math|\<Theta\><around*|(|n|)>>, where <math|\<varphi\>> is the golden
  ratio described in <hlink|1.2.2|#1.2.2>.

  Orders of growth provide only a crude description of the behavior of a
  process. For example, a process requiring <math|n<rsup|2>> steps and a
  process requiring <math|1000*n<rsup|2>> steps and a process requiring
  <math|3*n<rsup|2>+10*n+17> steps all have
  <math|\<Theta\><around*|(|n<rsup|2>|)>> order of growth. On the other hand,
  order of growth provides a useful indication of how we may expect the
  behavior of the process to change as we change the size of the problem. For
  a <math|\<Theta\><around*|(|n|)>> (linear) process, doubling the size will
  roughly double the amount of resources used. For an exponential process,
  each increment in problem size will multiply the resource utilization by a
  constant factor. In the remainder of <hlink|1.2|#g_t1_002e2> we will
  examine two algorithms whose order of growth is logarithmic, so that
  doubling the problem size increases the resource requirement by a constant
  amount.

  <strong|<label|Exercise-1_002e14>Exercise 1.14:> Draw the tree illustrating
  the process generated by the <code*|count-change> procedure of
  <hlink|1.2.2|#1.2.2> in making change for 11 cents. What are the orders of
  growth of the space and number of steps used by this process as the amount
  to be changed increases?

  <strong|<label|Exercise-1_002e15>Exercise 1.15:> The sine of an angle
  (specified in radians) can be computed by making use of the approximation
  <math|sin\<nospace\>x\<approx\>x> if <math|x> is sufficiently small, and
  the trigonometric identity <math|sin\<nospace\>x=3
  sin\<nospace\><frac|x|3>-4 sin<rsup|3>\<nospace\><frac|x|3>> to reduce the
  size of the argument of sin. (For purposes of this exercise an angle is
  considered \Psufficiently small\Q if its magnitude is not greater than 0.1
  radians.) These ideas are incorporated in the following procedures:

  <\scm-code>
    (define (cube x) (* x x x))

    (define (p x) (- (* 3 x) (* 4 (cube x))))

    (define (sine angle)

    \ \ \ (if (not (\<gtr\> (abs angle) 0.1))

    \ \ \ \ \ \ \ angle

    \ \ \ \ \ \ \ (p (sine (/ angle 3.0)))))
  </scm-code>

  <\enumerate-alpha>
    <item>How many times is the procedure <code*|p> applied when <code*|(sine
    12.15)> is evaluated?

    <item>What is the order of growth in space and number of steps (as a
    function of <math|a>) used by the process generated by the <code*|sine>
    procedure when <code*|(sine a)> is evaluated?
  </enumerate-alpha>

  <subsection|Exponentiation><label|1.2.4>

  Consider the problem of computing the exponential of a given number. We
  would like a procedure that takes as arguments a base <math|b> and a
  positive integer exponent <math|n> and computes <math|b<rsup|n>>. One way
  to do this is via the recursive definition

  <\equation*>
    <tabular|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<table|<row|<cell|b<rsup|n>=b\<cdot\>b<rsup|n-1>,>>|<row|<cell|b<rsup|0>=1,>>>>>
  </equation*>

  \ which translates readily into the procedure

  <\scm-code>
    (define (expt b n)

    \ \ (if (= n 0)

    \ \ \ \ \ \ 1

    \ \ \ \ \ \ (* b (expt b (- n 1)))))
  </scm-code>

  This is a linear recursive process, which requires
  <math|\<Theta\><around*|(|n|)>> steps and <math|\<Theta\><around*|(|n|)>>
  space. Just as with factorial, we can readily formulate an equivalent
  linear iteration:

  <\scm-code>
    (define (expt b n)

    \ \ (expt-iter b n 1))

    \;

    (define (expt-iter b counter product)

    \ \ (if (= counter 0)

    \ \ \ \ \ \ product

    \ \ \ \ \ \ (expt-iter b

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (- counter 1)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (* b product))))\ 
  </scm-code>

  This version requires <math|\<Theta\><around*|(|n|)>> steps and
  <math|\<Theta\><around*|(|1|)>> space.

  We can compute exponentials in fewer steps by using successive squaring.
  For instance, rather than computing <math|b<rsup|8>> as
  <math|b\<cdot\><around*|(|b\<cdot\><around*|(|b\<cdot\><around*|(|b\<cdot\><around*|(|b\<cdot\><around*|(|b\<cdot\><around*|(|b\<cdot\>b|)>|)>|)>|)>|)>|)>>,
  we can compute it using three multiplications:

  <\equation*>
    <tabular|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<table|<row|<cell|b<rsup|2>=b\<cdot\>b,>>|<row|<cell|b<rsup|4>=b<rsup|2>\<cdot\>b<rsup|2>,>>|<row|<cell|b<rsup|8>=b<rsup|4>\<cdot\>b<rsup|4>.>>>>>
  </equation*>

  This method works fine for exponents that are powers of 2. We can also take
  advantage of successive squaring in computing exponentials in general if we
  use the rule

  <\equation*>
    <tabular|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|2|2|cell-halign|l>|<table|<row|<cell|b<rsup|n>=<around*|(|b<rsup|n<around*|/|2|\<nobracket\>>>|)><rsup|2>>|<cell|<with|mode|text|if>
    n <with|mode|text|is even>,>>|<row|<cell|b<rsup|n>=b\<cdot\>b<rsup|n-1>>|<cell|<with|mode|text|if>
    n <with|mode|text|is odd>.>>>>>
  </equation*>

  We can express this method as a procedure:

  <\scm-code>
    (define (fast-expt b n)

    \ \ (cond ((= n 0) 1)

    \ \ \ \ \ \ \ \ ((even? n) (square (fast-expt b (/ n 2))))

    \ \ \ \ \ \ \ \ (else (* b (fast-expt b (- n 1))))))
  </scm-code>

  where the predicate to test whether an integer is even is defined in terms
  of the primitive procedure <code*|remainder> by

  <\scm-code>
    (define (even? n)

    \ \ (= (remainder n 2) 0))
  </scm-code>

  The process evolved by <code*|fast-expt> grows logarithmically with
  <math|n> in both space and number of steps. To see this, observe that
  computing <math|b<rsup|2*n>> using <code*|fast-expt> requires only one more
  multiplication than computing <math|b<rsup|n>>. The size of the exponent we
  can compute therefore doubles (approximately) with every new multiplication
  we are allowed. Thus, the number of multiplications required for an
  exponent of <math|n> grows about as fast as the logarithm of <math|n> to
  the base 2. The process has <math|\<Theta\><around*|(|log\<nospace\>n|)>>
  growth.<\footnote>
    More precisely, the number of multiplications required is equal to 1 less
    than the log base 2 of <math|n> plus the number of ones in the binary
    representation of <math|n>. This total is always less than twice the log
    base 2 of <math|n>. The arbitrary constants <math|k<rsub|1>> and
    <math|k<rsub|2>> in the definition of order notation imply that, for a
    logarithmic process, the base to which logarithms are taken does not
    matter, so all such processes are described as
    <math|\<Theta\><around*|(|log\<nospace\>n|)>>.
  </footnote>

  The difference between <math|\<Theta\><around*|(|log\<nospace\>n|)>> growth
  and <math|\<Theta\><around*|(|n|)>> growth becomes striking as <math|n>
  becomes large. For example, <code*|fast-expt> for <math|n> = 1000 requires
  only 14 multiplications.<\footnote>
    You may wonder why anyone would care about raising numbers to the 1000th
    power. See <hlink|1.2.6|#g_t1_002e2_002e6>.
  </footnote> It is also possible to use the idea of successive squaring to
  devise an iterative algorithm that computes exponentials with a logarithmic
  number of steps (see <hlink|Exercise 1.16|#Exercise-1_002e16>), although,
  as is often the case with iterative algorithms, this is not written down so
  straightforwardly as the recursive algorithm.<\footnote>
    This iterative algorithm is ancient. It appears in the
    <cite*|Chandah-sutra> by Áchárya Pingala, written before 200 <abbr|B.C.>
    See <hlink|Knuth 1981|References.xhtml#Knuth-1981>, section 4.6.3, for a
    full discussion and analysis of this and other methods of exponentiation.
  </footnote>

  <strong|<label|Exercise-1_002e16>Exercise 1.16:> Design a procedure that
  evolves an iterative exponentiation process that uses successive squaring
  and uses a logarithmic number of steps, as does <code*|fast-expt>. (Hint:
  Using the observation that <math|<around*|(|b<rsup|n<around*|/|2|\<nobracket\>>>|)><rsup|2>=<around*|(|b<rsup|2>|)><rsup|n<around*|/|2|\<nobracket\>>>>,
  keep, along with the exponent <math|n> and the base <math|b>, an additional
  state variable <math|a>, and define the state transformation in such a way
  that the product <math|ab<rsup|n>> is unchanged from state to state. At the
  beginning of the process <math|a> is taken to be 1, and the answer is given
  by the value of <math|a> at the end of the process. In general, the
  technique of defining an <label|index-invariant-quantity> <em|invariant
  quantity><index|invariant quantity> that remains unchanged from state to
  state is a powerful way to think about the design of iterative algorithms.)

  <strong|<label|Exercise-1_002e17>Exercise 1.17:> The exponentiation
  algorithms in this section are based on performing exponentiation by means
  of repeated multiplication. In a similar way, one can perform integer
  multiplication by means of repeated addition. The following multiplication
  procedure (in which it is assumed that our language can only add, not
  multiply) is analogous to the <code*|expt> procedure:

  <\scm-code>
    (define (* a b)

    \ \ (if (= b 0)

    \ \ \ \ \ \ 0

    \ \ \ \ \ \ (+ a (* a (- b 1)))))
  </scm-code>

  This algorithm takes a number of steps that is linear in <code*|b>. Now
  suppose we include, together with addition, operations <code*|double>,
  which doubles an integer, and <code*|halve>, which divides an (even)
  integer by 2. Using these, design a multiplication procedure analogous to
  <code*|fast-expt> that uses a logarithmic number of steps.

  <strong|<label|Exercise-1_002e18>Exercise 1.18:> Using the results of
  <hlink|Exercise 1.16|#Exercise-1_002e16> and <hlink|Exercise
  1.17|#Exercise-1_002e17>, devise a procedure that generates an iterative
  process for multiplying two integers in terms of adding, doubling, and
  halving and uses a logarithmic number of steps.<\footnote>
    This algorithm, which is sometimes known as the \PRussian peasant
    method\Q of multiplication, is ancient. Examples of its use are found in
    the Rhind Papyrus, one of the two oldest mathematical documents in
    existence, written about 1700 <abbr|B.C.> (and copied from an even older
    document) by an Egyptian scribe named A'h-mose.
  </footnote>

  <strong|<label|Exercise-1_002e19>Exercise 1.19:> There is a clever
  algorithm for computing the Fibonacci numbers in a logarithmic number of
  steps. Recall the transformation of the state variables <math|a> and
  <math|b> in the <code*|fib-iter> process of
  <hlink|1.2.2|#g_t1_002e2_002e2>: <math|a\<leftarrow\>a+b> and
  <math|b\<leftarrow\>a>. Call this transformation <math|T>, and observe that
  applying <math|T> over and over again <math|n> times, starting with 1 and
  0, produces the pair <math|<with|mode|text|Fib><around*|(|n+1|)>> and
  <math|<with|mode|text|Fib><around*|(|n|)>>. In other words, the Fibonacci
  numbers are produced by applying <math|T<rsup|n>>, the
  <math|n<rsup|<with|mode|text|th>>> power of the transformation <math|T>,
  starting with the pair (1, 0). Now consider <math|T> to be the special case
  of <math|p=0> and <math|q=1> in a family of transformations
  <math|T<rsub|pq>>, where <math|T<rsub|pq>> transforms the pair
  <math|<around*|(|a,b|)>> according to <math|a\<leftarrow\>bq+aq+ap> and
  <math|b\<leftarrow\>bp+aq>. Show that if we apply such a transformation
  <math|T<rsub|pq>> twice, the effect is the same as using a single
  transformation <math|T<rsub|p<rsup|\<prime\>>*q<rsup|\<prime\>>>> of the
  same form, and compute <math|p<rsup|\<prime\>>> and
  <math|q<rsup|\<prime\>>> in terms of <math|p> and <math|q>. This gives us
  an explicit way to square these transformations, and thus we can compute
  <math|T<rsup|n>> using successive squaring, as in the <code*|fast-expt>
  procedure. Put this all together to complete the following procedure, which
  runs in a logarithmic number of steps:<\footnote>
    This exercise was suggested to us by Joe Stoy, based on an example in
    <hlink|Kaldewaij 1990|References.xhtml#Kaldewaij-1990>.
  </footnote>

  <\scm-code>
    (define (fib n)

    \ \ (fib-iter 1 0 0 1 n))

    (define (fib-iter a b p q count)

    \ \ (cond ((= count 0) b)

    \ \ \ \ \ \ \ \ ((even? count)

    \ \ \ \ \ \ \ \ \ (fib-iter a

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ b

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \<less\>??\<gtr\> \ \ \ \ \ ;
    compute p'

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \<less\>??\<gtr\> \ \ \ \ \ ;
    compute q'

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (/ count 2)))

    \ \ \ \ \ \ \ \ (else (fib-iter (+ (* b q) (* a q) (* a p))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (+ (* b p) (* a q))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ p

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ q

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (- count 1)))))
  </scm-code>

  <subsection|Greatest Common Divisors>

  The greatest common divisor (<abbr|GCD>) of two integers <math|a> and
  <math|b> is defined to be the largest integer that divides both <math|a>
  and <math|b> with no remainder. For example, the <abbr|GCD> of 16 and 28 is
  4. In <hlink|Chapter 2|Chapter-2.xhtml#Chapter-2>, when we investigate how
  to implement rational-number arithmetic, we will need to be able to compute
  <abbr|GCD>s in order to reduce rational numbers to lowest terms. (To reduce
  a rational number to lowest terms, we must divide both the numerator and
  the denominator by their <abbr|GCD>. For example, 16/28 reduces to 4/7.)
  One way to find the <abbr|GCD> of two integers is to factor them and search
  for common factors, but there is a famous algorithm that is much more
  efficient.

  The idea of the algorithm is based on the observation that, if <math|r> is
  the remainder when <math|a> is divided by <math|b>, then the common
  divisors of <math|a> and <math|b> are precisely the same as the common
  divisors of <math|b> and <math|r>. Thus, we can use the equation

  <\equation*>
    GCD<around*|(|a,b|)>=GCD<around*|(|b,r|)>
  </equation*>

  to successively reduce the problem of computing a <abbr|GCD> to the problem
  of computing the <abbr|GCD> of smaller and smaller pairs of integers. For
  example,

  <\eqnarray*>
    <tformat|<table|<row|<cell|GCD<around*|(|206,40|)>>|<cell|=>|<cell|GCD<around*|(|40,6|)>>>|<row|<cell|>|<cell|=>|<cell|GCD<around*|(|6,4|)>>>|<row|<cell|>|<cell|=>|<cell|GCD<around*|(|4,2|)>>>|<row|<cell|>|<cell|=>|<cell|GCD<around*|(|2,0|)>>>|<row|<cell|>|<cell|=>|<cell|2>>>>
  </eqnarray*>

  reduces <abbr|GCD>(206, 40) to <abbr|GCD>(2, 0), which is 2. It is possible
  to show that starting with any two positive integers and performing
  repeated reductions will always eventually produce a pair where the second
  number is 0. Then the <abbr|GCD> is the other number in the pair. This
  method for computing the <abbr|GCD> is known as <em|Euclid's
  Algorithm><index|Euclid's Algorithm>.<\footnote>
    Euclid's Algorithm is so called because it appears in Euclid's
    <cite*|Elements> (Book 7, ca. 300 <abbr|B.C.>). According to <hlink|Knuth
    (1973)|References.xhtml#Knuth-_00281973_0029>, it can be considered the
    oldest known nontrivial algorithm. The ancient Egyptian method of
    multiplication (<hlink|Exercise 1.18|#Exercise-1_002e18>) is surely
    older, but, as Knuth explains, Euclid's algorithm is the oldest known to
    have been presented as a general algorithm, rather than as a set of
    illustrative examples.
  </footnote>

  It is easy to express Euclid's Algorithm as a procedure:

  <\scm-code>
    (define (gcd a b)

    \ \ (if (= b 0)

    \ \ \ \ \ \ a

    \ \ \ \ \ \ (gcd b (remainder a b))))
  </scm-code>

  This generates an iterative process, whose number of steps grows as the
  logarithm of the numbers involved.

  The fact that the number of steps required by Euclid's Algorithm has
  logarithmic growth bears an interesting relation to the Fibonacci numbers:

  <\render-theorem|Lamé's Theorem>
    If Euclid's Algorithm requires <math|k> steps to compute the <abbr|GCD>
    of some pair, then the smaller number in the pair must be greater than or
    equal to the <math|k<rsup|<with|mode|text|th>>> Fibonacci
    number.<\footnote>
      This theorem was proved in 1845 by Gabriel Lamé, a French mathematician
      and engineer known chiefly for his contributions to mathematical
      physics. To prove the theorem, we consider pairs
      <math|<around*|(|a<rsub|k>,b<rsub|k>|)>>, where
      <math|a<rsub|k>\<geq\>b<rsub|k>>, for which Euclid's Algorithm
      terminates in <math|k> steps. The proof is based on the claim that, if
      <math|<around*|(|a<rsub|k+1>,b<rsub|k+1>|)>\<rightarrow\><around*|(|a<rsub|k>,b<rsub|k>|)>\<rightarrow\><around*|(|a<rsub|k-1>,b<rsub|k-1>|)>>
      are three successive pairs in the reduction process, then we must have
      <math|b<rsub|k+1>\<geq\>b<rsub|k>+b<rsub|k-1>>. To verify the claim,
      consider that a reduction step is defined by applying the
      transformation <math|a<rsub|k-1>=b<rsub|k>>, <math|b<rsub|k-1>=>
      remainder of <math|a<rsub|k>> divided by <math|b<rsub|k>>. The second
      equation means that <math|a<rsub|k>=qb<rsub|k>+b<rsub|k-1>> for some
      positive integer <math|q>. And since <math|q> must be at least 1 we
      have <math|a<rsub|k>=qb<rsub|k>+b<rsub|k-1>\<geq\>b<rsub|k>+b<rsub|k-1>>.
      But in the previous reduction step we have
      <math|b<rsub|k+1>=a<rsub|k>>. Therefore,
      <math|b<rsub|k+1>=a<rsub|k>\<geq\>b<rsub|k>+b<rsub|k-1>>. This verifies
      the claim. Now we can prove the theorem by induction on <math|k>, the
      number of steps that the algorithm requires to terminate. The result is
      true for <math|k=1>, since this merely requires that <math|b> be at
      least as large as <math|<with|mode|text|Fib><around*|(|1|)>=1>. Now,
      assume that the result is true for all integers less than or equal to
      <math|k> and establish the result for <math|k+1>. Let
      <math|<around*|(|a<rsub|k+1>,b<rsub|k+1>|)>\<rightarrow\><around*|(|a<rsub|k>,b<rsub|k>|)>\<rightarrow\><around*|(|a<rsub|k-1>,b<rsub|k-1>|)>>
      be successive pairs in the reduction process. By our induction
      hypotheses, we have <math|b<rsub|k-1>\<geq\><with|mode|text|Fib><around*|(|k-1|)>>
      and <math|b<rsub|k>\<geq\><with|mode|text|Fib><around*|(|k|)>>. Thus,
      applying the claim we just proved together with the definition of the
      Fibonacci numbers gives <math|b<rsub|k+1>\<geq\>b<rsub|k>+b<rsub|k-1>\<geq\><with|mode|text|Fib><around*|(|k|)>+<with|mode|text|Fib><around*|(|k-1|)>=<with|mode|text|Fib><around*|(|k+1|)>>,
      which completes the proof of Lamé's Theorem.
    </footnote>
  </render-theorem>

  We can use this theorem to get an order-of-growth estimate for Euclid's
  Algorithm. Let <math|n> be the smaller of the two inputs to the procedure.
  If the process takes <math|k> steps, then we must have
  <math|n\<geq\><with|mode|text|Fib><around*|(|k|)>\<approx\>\<varphi\><rsup|k><around*|/|<sqrt|5>|\<nobracket\>>>.
  Therefore the number of steps <math|k> grows as the logarithm (to the base
  <math|\<varphi\>>) of <math|n>. Hence, the order of growth is
  <math|\<Theta\><around*|(|log\<nospace\>n|)>>.

  <strong|<label|Exercise-1_002e20>Exercise 1.20:> The process that a
  procedure generates is of course dependent on the rules used by the
  interpreter. As an example, consider the iterative <code*|gcd> procedure
  given above. Suppose we were to interpret this procedure using normal-order
  evaluation, as discussed in <hlink|1.1.5|1_002e1.xhtml#g_t1_002e1_002e5>.
  (The normal-order-evaluation rule for <code*|if> is described in
  <hlink|Exercise 1.5|1_002e1.xhtml#Exercise-1_002e5>.) Using the
  substitution method (for normal order), illustrate the process generated in
  evaluating <code*|(gcd 206 40)> and indicate the <code*|remainder>
  operations that are actually performed. How many <code*|remainder>
  operations are actually performed in the normal-order evaluation of
  <code*|(gcd 206 40)>? In the applicative-order evaluation?

  <subsection|Example: Testing for Primality><label|#1.2.6>

  This section describes two methods for checking the primality of an integer
  <math|n>, one with order of growth <math|\<Theta\><around*|(|<sqrt|n>|)>>,
  and a \Pprobabilistic\Q algorithm with order of growth
  <math|\<Theta\><around*|(|log\<nospace\>n|)>>. The exercises at the end of
  this section suggest programming projects based on these algorithms.

  <paragraph*|Searching for divisors>

  Since ancient times, mathematicians have been fascinated by problems
  concerning prime numbers, and many people have worked on the problem of
  determining ways to test if numbers are prime. One way to test if a number
  is prime is to find the number's divisors. The following program finds the
  smallest integral divisor (greater than 1) of a given number <math|n>. It
  does this in a straightforward way, by testing <math|n> for divisibility by
  successive integers starting with 2.

  <\scm-code>
    (define (smallest-divisor n)

    \ \ (find-divisor n 2))

    (define (find-divisor n test-divisor)

    \ \ (cond ((\<gtr\> (square test-divisor) n) n)

    \ \ \ \ \ \ \ \ ((divides? test-divisor n) test-divisor)

    \ \ \ \ \ \ \ \ (else (find-divisor n (+ test-divisor 1)))))

    (define (divides? a b)

    \ \ (= (remainder b a) 0))
  </scm-code>

  We can test whether a number is prime as follows: <math|n> is prime if and
  only if <math|n> is its own smallest divisor.

  <\scm-code>
    (define (prime? n)

    \ \ (= n (smallest-divisor n)))
  </scm-code>

  The end test for <code*|find-divisor> is based on the fact that if <math|n>
  is not prime it must have a divisor less than or equal to
  <math|<sqrt|n>>.<\footnote>
    If <math|d> is a divisor of <math|n>, then so is
    <math|n<around*|/|d|\<nobracket\>>>. But <math|d> and
    <math|n<around*|/|d|\<nobracket\>>> cannot both be greater than
    <math|<sqrt|n>>.
  </footnote> This means that the algorithm need only test divisors between 1
  and <math|<sqrt|n>>. Consequently, the number of steps required to identify
  <math|n> as prime will have order of growth
  <math|\<Theta\><around*|(|<sqrt|n>|)>>.

  <paragraph*|The Fermat test>

  The <math|\<Theta\><around*|(|log\<nospace\>n|)>> primality test is based
  on a result from number theory known as Fermat's Little Theorem.<\footnote>
    Pierre de Fermat (1601-1665) is considered to be the founder of modern
    number theory. He obtained many important number-theoretic results, but
    he usually announced just the results, without providing his proofs.
    Fermat's Little Theorem was stated in a letter he wrote in 1640. The
    first published proof was given by Euler in 1736 (and an earlier,
    identical proof was discovered in the unpublished manuscripts of
    Leibniz). The most famous of Fermat's results\Vknown as Fermat's Last
    Theorem\Vwas jotted down in 1637 in his copy of the book
    <cite*|Arithmetic> (by the third-century Greek mathematician Diophantus)
    with the remark \PI have discovered a truly remarkable proof, but this
    margin is too small to contain it.\Q Finding a proof of Fermat's Last
    Theorem became one of the most famous challenges in number theory. A
    complete solution was finally given in 1995 by Andrew Wiles of Princeton
    University.
  </footnote>

  <\render-theorem|Fermat's Little Theorem>
    If <math|n> is a prime number and <math|a> is any positive integer less
    than <math|n>, then <math|a> raised to the
    <math|n<rsup|<with|mode|text|th>>> power is congruent to <math|a> modulo
    <math|n>.
  </render-theorem>

  (Two numbers are said to be <em|congruent modulo><index|congruent modulo>
  <math|n> if they both have the same remainder when divided by <math|n>. The
  remainder of a number <math|a> when divided by <math|n> is also referred to
  as the <em|remainder of><index|remainder of> <math|a> <em|modulo> <math|n>,
  or simply as <math|a> <em|modulo><index|modulo> <math|n>.)

  If <math|n> is not prime, then, in general, most of the numbers
  <math|a\<less\>n> will not satisfy the above relation. This leads to the
  following algorithm for testing primality: Given a number <math|n>, pick a
  random number <math|a\<less\>n> and compute the remainder of
  <math|a<rsup|n>> modulo <math|n>. If the result is not equal to <math|a>,
  then <math|n> is certainly not prime. If it is <math|a>, then chances are
  good that <math|n> is prime. Now pick another random number <math|a> and
  test it with the same method. If it also satisfies the equation, then we
  can be even more confident that <math|n> is prime. By trying more and more
  values of <math|a>, we can increase our confidence in the result. This
  algorithm is known as the Fermat test.

  To implement the Fermat test, we need a procedure that computes the
  exponential of a number modulo another number:

  <\scm-code>
    (define (expmod base exp m)

    \ \ (cond ((= exp 0) 1)

    \ \ \ \ \ \ \ \ ((even? exp)

    \ \ \ \ \ \ \ \ \ (remainder (square (expmod base (/ exp 2) m))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ m))

    \ \ \ \ \ \ \ \ (else

    \ \ \ \ \ \ \ \ \ (remainder (* base (expmod base (- exp 1) m))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ m))))
  </scm-code>

  This is very similar to the <code*|fast-expt> procedure of
  <hlink|1.2.4|#1.2.4>. It uses successive squaring, so that the number of
  steps grows logarithmically with the exponent.<\footnote>
    The reduction steps in the cases where the exponent <math|e> is greater
    than 1 are based on the fact that, for any integers <math|x>, <math|y>,
    and <math|m>, we can find the remainder of <math|x> times <math|y> modulo
    <math|m> by computing separately the remainders of <math|x> modulo
    <math|m> and <math|y> modulo <math|m>, multiplying these, and then taking
    the remainder of the result modulo <math|m>. For instance, in the case
    where <math|e> is even, we compute the remainder of
    <math|b<rsup|e<around*|/|2|\<nobracket\>>>> modulo <math|m>, square this,
    and take the remainder modulo <math|m>. This technique is useful because
    it means we can perform our computation without ever having to deal with
    numbers much larger than <math|m>. (Compare <hlink|Exercise
    1.25|#Exercise-1_002e25>.)
  </footnote>

  The Fermat test is performed by choosing at random a number <math|a>
  between 1 and <math|n-1> inclusive and checking whether the remainder
  modulo <math|n> of the <math|n<rsup|<with|mode|text|th>>> power of <math|a>
  is equal to <math|a>. The random number <math|a> is chosen using the
  procedure <code*|random>, which we assume is included as a primitive in
  Scheme. <code*|Random> returns a nonnegative integer less than its integer
  input. Hence, to obtain a random number between 1 and <math|n-1>, we call
  <code*|random> with an input of <math|n-1> and add 1 to the result:

  <\scm-code>
    (define (fermat-test n)

    \ \ (define (try-it a)

    \ \ \ \ (= (expmod a n n) a))

    \ \ (try-it (+ 1 (random (- n 1)))))
  </scm-code>

  The following procedure runs the test a given number of times, as specified
  by a parameter. Its value is true if the test succeeds every time, and
  false otherwise.

  <\scm-code>
    (define (fast-prime? n times)

    \ \ (cond ((= times 0) true)

    \ \ \ \ \ \ \ \ ((fermat-test n) (fast-prime? n (- times 1)))

    \ \ \ \ \ \ \ \ (else false)))
  </scm-code>

  <paragraph*|Probabilistic methods>

  The Fermat test differs in character from most familiar algorithms, in
  which one computes an answer that is guaranteed to be correct. Here, the
  answer obtained is only probably correct. More precisely, if <math|n> ever
  fails the Fermat test, we can be certain that <math|n> is not prime. But
  the fact that <math|n> passes the test, while an extremely strong
  indication, is still not a guarantee that <math|n> is prime. What we would
  like to say is that for any number <math|n>, if we perform the test enough
  times and find that <math|n> always passes the test, then the probability
  of error in our primality test can be made as small as we like.

  Unfortunately, this assertion is not quite correct. There do exist numbers
  that fool the Fermat test: numbers <math|n> that are not prime and yet have
  the property that <math|a<rsup|n>> is congruent to <math|a> modulo <math|n>
  for all integers <math|a\<less\>n>. Such numbers are extremely rare, so the
  Fermat test is quite reliable in practice.<\footnote>
    Numbers that fool the Fermat test are called <em|Carmichael
    numbers><index|Carmichael numbers>, and little is known about them other
    than that they are extremely rare. There are 255 Carmichael numbers below
    100,000,000. The smallest few are 561, 1105, 1729, 2465, 2821, and 6601.
    In testing primality of very large numbers chosen at random, the chance
    of stumbling upon a value that fools the Fermat test is less than the
    chance that cosmic radiation will cause the computer to make an error in
    carrying out a \Pcorrect\Q algorithm. Considering an algorithm to be
    inadequate for the first reason but not for the second illustrates the
    difference between mathematics and engineering.
  </footnote>

  There are variations of the Fermat test that cannot be fooled. In these
  tests, as with the Fermat method, one tests the primality of an integer
  <math|n> by choosing a random integer <math|a\<less\>n> and checking some
  condition that depends upon <math|n> and <math|a>. (See <hlink|Exercise
  1.28|#Exercise-1_002e28> for an example of such a test.) On the other hand,
  in contrast to the Fermat test, one can prove that, for any <math|n>, the
  condition does not hold for most of the integers <math|a\<less\>n> unless
  <math|n> is prime. Thus, if <math|n> passes the test for some random choice
  of <math|a>, the chances are better than even that <math|n> is prime. If
  <math|n> passes the test for two random choices of <math|a>, the chances
  are better than 3 out of 4 that <math|n> is prime. By running the test with
  more and more randomly chosen values of <math|a> we can make the
  probability of error as small as we like.

  The existence of tests for which one can prove that the chance of error
  becomes arbitrarily small has sparked interest in algorithms of this type,
  which have come to be known as <em|probabilistic
  algorithms><index|probabilistic algorithms>. There is a great deal of
  research activity in this area, and probabilistic algorithms have been
  fruitfully applied to many fields.<\footnote>
    One of the most striking applications of probabilistic prime testing has
    been to the field of cryptography. Although it is now computationally
    infeasible to factor an arbitrary 200-digit number, the primality of such
    a number can be checked in a few seconds with the Fermat test. This fact
    forms the basis of a technique for constructing \Punbreakable codes\Q
    suggested by <hlink|Rivest et al. (1977)|References.xhtml#Rivest-et-al_002e-_00281977_0029>.
    The resulting <em|RSA algorithm><index|RSA algorithm> has become a widely
    used technique for enhancing the security of electronic communications.
    Because of this and related developments, the study of prime numbers,
    once considered the epitome of a topic in \Ppure\Q mathematics to be
    studied only for its own sake, now turns out to have important practical
    applications to cryptography, electronic funds transfer, and information
    retrieval.
  </footnote>

  <strong|<label|Exercise-1_002e21>Exercise 1.21:> Use the
  <code*|smallest-divisor> procedure to find the smallest divisor of each of
  the following numbers: 199, 1999, 19999.

  <strong|<label|Exercise-1_002e22>Exercise 1.22:> Most Lisp implementations
  include a primitive called <code*|runtime> that returns an integer that
  specifies the amount of time the system has been running (measured, for
  example, in microseconds). The following <code*|timed-prime-test>
  procedure, when called with an integer <math|n>, prints <math|n> and checks
  to see if <math|n> is prime. If <math|n> is prime, the procedure prints
  three asterisks followed by the amount of time used in performing the test.

  <\scm-code>
    (define (timed-prime-test n)

    \ \ (newline)

    \ \ (display n)

    \ \ (start-prime-test n (runtime)))

    (define (start-prime-test n start-time)

    \ \ (if (prime? n)

    \ \ \ \ \ \ (report-prime (- (runtime) start-time))))

    (define (report-prime elapsed-time)

    \ \ (display " *** ")

    \ \ (display elapsed-time))
  </scm-code>

  Using this procedure, write a procedure <code*|search-for-primes> that
  checks the primality of consecutive odd integers in a specified range. Use
  your procedure to find the three smallest primes larger than 1000; larger
  than 10,000; larger than 100,000; larger than 1,000,000. Note the time
  needed to test each prime. Since the testing algorithm has order of growth
  of <math|\<Theta\><around*|(|<sqrt|n>|)>>, you should expect that testing
  for primes around 10,000 should take about <math|<sqrt|10>> times as long
  as testing for primes around 1000. Do your timing data bear this out? How
  well do the data for 100,000 and 1,000,000 support the
  <math|\<Theta\><around*|(|<sqrt|n>|)>> prediction? Is your result
  compatible with the notion that programs on your machine run in time
  proportional to the number of steps required for the computation?

  <strong|<label|Exercise-1_002e23>Exercise 1.23:> The
  <code*|smallest-divisor> procedure shown at the start of this section does
  lots of needless testing: After it checks to see if the number is divisible
  by 2 there is no point in checking to see if it is divisible by any larger
  even numbers. This suggests that the values used for <code*|test-divisor>
  should not be 2, 3, 4, 5, 6, \<ldots\>, but rather 2, 3, 5, 7, 9,
  \<ldots\>. To implement this change, define a procedure <code*|next> that
  returns 3 if its input is equal to 2 and otherwise returns its input plus
  2. Modify the <code*|smallest-divisor> procedure to use <code*|(next
  test-divisor)> instead of <code*|(+ test-divisor 1)>. With
  <code*|timed-prime-test> incorporating this modified version of
  <code*|smallest-divisor>, run the test for each of the 12 primes found in
  <hlink|Exercise 1.22|#Exercise-1_002e22>. Since this modification halves
  the number of test steps, you should expect it to run about twice as fast.
  Is this expectation confirmed? If not, what is the observed ratio of the
  speeds of the two algorithms, and how do you explain the fact that it is
  different from 2?

  <strong|<label|Exercise-1_002e24>Exercise 1.24:> Modify the
  <code*|timed-prime-test> procedure of <hlink|Exercise
  1.22|#Exercise-1_002e22> to use <code*|fast-prime?> (the Fermat method),
  and test each of the 12 primes you found in that exercise. Since the Fermat
  test has <math|\<Theta\><around*|(|log\<nospace\>n|)>> growth, how would
  you expect the time to test primes near 1,000,000 to compare with the time
  needed to test primes near 1000? Do your data bear this out? Can you
  explain any discrepancy you find?

  <strong|<label|Exercise-1_002e25>Exercise 1.25:> Alyssa P. Hacker complains
  that we went to a lot of extra work in writing <code*|expmod>. After all,
  she says, since we already know how to compute exponentials, we could have
  simply written

  <\scm-code>
    (define (expmod base exp m)

    \ \ (remainder (fast-expt base exp) m))
  </scm-code>

  Is she correct? Would this procedure serve as well for our fast prime
  tester? Explain.

  <strong|<label|Exercise-1_002e26>Exercise 1.26:> Louis Reasoner is having
  great difficulty doing <hlink|Exercise 1.24|#Exercise-1_002e24>. His
  <code*|fast-prime?> test seems to run more slowly than his <code*|prime?>
  test. Louis calls his friend Eva Lu Ator over to help. When they examine
  Louis's code, they find that he has rewritten the <code*|expmod> procedure
  to use an explicit multiplication, rather than calling <code*|square>:

  <\scm-code>
    (define (expmod base exp m)

    \ \ (cond ((= exp 0) 1)

    \ \ \ \ \ \ \ \ ((even? exp)

    \ \ \ \ \ \ \ \ \ (remainder (* (expmod base (/ exp 2) m)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (expmod base (/ exp 2) m))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ m))

    \ \ \ \ \ \ \ \ (else

    \ \ \ \ \ \ \ \ \ (remainder (* base (expmod base (- exp 1) m))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ m))))
  </scm-code>

  \PI don't see what difference that could make,\Q says Louis. \PI<nbsp>do.\Q
  says Eva. \PBy writing the procedure like that, you have transformed the
  <math|\<Theta\><around*|(|log\<nospace\>n|)>> process into a
  <math|\<Theta\><around*|(|n|)>> process.\Q Explain.

  <strong|<label|Exercise-1_002e27>Exercise 1.27:> Demonstrate that the
  Carmichael numbers listed in <hlink|Footnote 47|#Footnote-47> really do
  fool the Fermat test. That is, write a procedure that takes an integer
  <math|n> and tests whether <math|a<rsup|n>> is congruent to <math|a> modulo
  <math|n> for every <math|a\<less\>n>, and try your procedure on the given
  Carmichael numbers.

  <strong|<label|Exercise-1_002e28>Exercise 1.28:> One variant of the Fermat
  test that cannot be fooled is called the <em|Miller-Rabin
  test><index|Miller-Rabin test> (<hlink|Miller
  1976|References.xhtml#Miller-1976>; <hlink|Rabin
  1980|References.xhtml#Rabin-1980>). This starts from an alternate form of
  Fermat's Little Theorem, which states that if <math|n> is a prime number
  and <math|a> is any positive integer less than <math|n>, then <math|a>
  raised to the <math|<around*|(|n-1|)>>-st power is congruent to 1 modulo
  <math|n>. To test the primality of a number <math|n> by the Miller-Rabin
  test, we pick a random number <math|a\<less\>n> and raise <math|a> to the
  <math|<around*|(|n-1|)>>-st power modulo <math|n> using the <code*|expmod>
  procedure. However, whenever we perform the squaring step in
  <code*|expmod>, we check to see if we have discovered a \Pnontrivial square
  root of 1 modulo <math|n>,\Q that is, a number not equal to 1 or <math|n-1>
  whose square is equal to 1 modulo <math|n>. It is possible to prove that if
  such a nontrivial square root of 1 exists, then <math|n> is not prime. It
  is also possible to prove that if <math|n> is an odd number that is not
  prime, then, for at least half the numbers <math|a\<less\>n>, computing
  <math|a<rsup|n-1>> in this way will reveal a nontrivial square root of 1
  modulo <math|n>. (This is why the Miller-Rabin test cannot be fooled.)
  Modify the <code*|expmod> procedure to signal if it discovers a nontrivial
  square root of 1, and use this to implement the Miller-Rabin test with a
  procedure analogous to <code*|fermat-test>. Check your procedure by testing
  various known primes and non-primes. Hint: One convenient way to make
  <code*|expmod> signal is to have it return 0.

  <section|Formulating Abstractions with Higher-Order Procedures><label|1.3>

  We have seen that procedures are, in effect, abstractions that describe
  compound operations on numbers independent of the particular numbers. For
  example, when we

  <\session|scheme|default>
    <\input|Scheme] >
      (define (cube x) (* x x x))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  we are not talking about the cube of a particular number, but rather about
  a method for obtaining the cube of any number. Of course we could get along
  without ever defining this procedure, by always writing expressions such as

  <\scm-code>
    (* 3 3 3)

    (* x x x)

    (* y y y)
  </scm-code>

  and never mentioning <code*|cube> explicitly. This would place us at a
  serious disadvantage, forcing us to work always at the level of the
  particular operations that happen to be primitives in the language
  (multiplication, in this case) rather than in terms of higher-level
  operations. Our programs would be able to compute cubes, but our language
  would lack the ability to express the concept of cubing. One of the things
  we should demand from a powerful programming language is the ability to
  build abstractions by assigning names to common patterns and then to work
  in terms of the abstractions directly. Procedures provide this ability.
  This is why all but the most primitive programming languages include
  mechanisms for defining procedures.

  Yet even in numerical processing we will be severely limited in our ability
  to create abstractions if we are restricted to procedures whose parameters
  must be numbers. Often the same programming pattern will be used with a
  number of different procedures. To express such patterns as concepts, we
  will need to construct procedures that can accept procedures as arguments
  or return procedures as values. Procedures that manipulate procedures are
  called <em|higher-order procedures><index|higher-order procedures>. This
  section shows how higher-order procedures can serve as powerful abstraction
  mechanisms, vastly increasing the expressive power of our language.

  <subsection|Procedures as Arguments><label|1.3.1>

  Consider the following three procedures. The first computes the sum of the
  integers from <code*|a> through <code*|b>:

  <\scm-code>
    (define (sum-integers a b)

    \ \ (if (\<gtr\> a b)

    \ \ \ \ \ \ 0

    \ \ \ \ \ \ (+ a (sum-integers (+ a 1) b))))
  </scm-code>

  The second computes the sum of the cubes of the integers in the given
  range:

  <\scm-code>
    (define (sum-cubes a b)

    \ \ (if (\<gtr\> a b)

    \ \ \ \ \ \ 0

    \ \ \ \ \ \ (+ (cube a) (sum-cubes (+ a 1) b))))
  </scm-code>

  The third computes the sum of a sequence of terms in the series
  <math|<frac|1|1\<cdot\>3>+<frac|1|5\<cdot\>7>+<frac|1|9\<cdot\>11>+\<ldots\>>,
  which converges to <math|\<pi\><around*|/|8|\<nobracket\>>> (very
  slowly):<\footnote>
    This series, usually written in the equivalent form
    <math|<frac|\<pi\>|4>=1-<frac|1|3>+<frac|1|5>-<frac|1|7>+\<ldots\>>, is
    due to Leibniz. We'll see how to use this as the basis for some fancy
    numerical tricks in <hlink|3.5.3|3_002e5.xhtml#g_t3_002e5_002e3>.
  </footnote>

  <\scm-code>
    (define (pi-sum a b)

    \ \ (if (\<gtr\> a b)

    \ \ \ \ \ \ 0

    \ \ \ \ \ \ (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))
  </scm-code>

  These three procedures clearly share a common underlying pattern. They are
  for the most part identical, differing only in the name of the procedure,
  the function of <code*|a> used to compute the term to be added, and the
  function that provides the next value of <code*|a>. We could generate each
  of the procedures by filling in slots in the same template:

  <\scm-code>
    (define (\<less\>name\<gtr\> a b)

    \ \ (if (\<gtr\> a b)

    \ \ \ \ \ \ 0

    \ \ \ \ \ \ (+ (\<less\>term\<gtr\> a)

    \ \ \ \ \ \ \ \ \ (\<less\>name\<gtr\> (\<less\>next\<gtr\> a) b))))
  </scm-code>

  The presence of such a common pattern is strong evidence that there is a
  useful abstraction waiting to be brought to the surface. Indeed,
  mathematicians long ago identified the abstraction of <em|summation of a
  series><index|summation of a series> and invented \Psigma notation,\Q for
  example <math|<above|<below|\<big-sum\>|n=a>|b>f<around*|(|n|)>=f<around*|(|a|)>+\<cdots\>+f<around*|(|b|)>>,
  to express this concept. The power of sigma notation is that it allows
  mathematicians to deal with the concept of summation itself rather than
  only with particular sums\Vfor example, to formulate general results about
  sums that are independent of the particular series being summed.

  Similarly, as program designers, we would like our language to be powerful
  enough so that we can write a procedure that expresses the concept of
  summation itself rather than only procedures that compute particular sums.
  We can do so readily in our procedural language by taking the common
  template shown above and transforming the \Pslots\Q into formal parameters:

  <\session|scheme|default>
    <\input|Scheme] >
      (define (sum term a next b)

      \ \ (if (\<gtr\> a b)

      \ \ \ \ \ \ 0

      \ \ \ \ \ \ (+ (term a)

      \ \ \ \ \ \ \ \ \ (sum term (next a) next b))))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Notice that <code*|sum> takes as its arguments the lower and upper bounds
  <code*|a> and <code*|b> together with the procedures <code*|term> and
  <code*|next>. We can use <code*|sum> just as we would any procedure. For
  example, we can use it (along with a procedure <code*|inc> that increments
  its argument by 1) to define <code*|sum-cubes>:

  <\session|scheme|default>
    <\input|Scheme] >
      (define (inc n) (+ n 1))
    </input>

    <\input|Scheme] >
      (define (sum-cubes a b)

      \ \ (sum cube a inc b))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Using this, we can compute the sum of the cubes of the integers from 1 to
  10:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (sum-cubes 1 10)
    <|unfolded-io>
      3025
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  With the aid of an identity procedure to compute the term, we can define
  <code*|sum-integers> in terms of <code*|sum>:

  <\session|scheme|default>
    <\input|Scheme] >
      (define (identity x) x)
    </input>

    <\input|Scheme] >
      (define (sum-integers a b)

      \ \ (sum identity a inc b))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Then we can add up the integers from 1 to 10:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (sum-integers 1 10)
    <|unfolded-io>
      55
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  We can also define <code*|pi-sum> in the same way:<\footnote>
    Notice that we have used block structure (<hlink|1.1.8|#1.1.8>) to embed
    the definitions of <code*|pi-next> and <code*|pi-term> within
    <code*|pi-sum>, since these procedures are unlikely to be useful for any
    other purpose. We will see how to get rid of them altogether in
    <hlink|1.3.2|#g_t1_002e3_002e2>.
  </footnote>

  <\session|scheme|default>
    <\input|Scheme] >
      (define (pi-sum a b)

      \ \ (define (pi-term x)

      \ \ \ \ (/ 1.0 (* x (+ x 2))))

      \ \ (define (pi-next x)

      \ \ \ \ (+ x 4))

      \ \ (sum pi-term a pi-next b))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Using these procedures, we can compute an approximation to <math|\<pi\>>:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (* 8 (pi-sum 1 1000))
    <|unfolded-io>
      3.139592655589783
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Once we have <code*|sum>, we can use it as a building block in formulating
  further concepts. For instance, the definite integral of a function
  <math|f> between the limits <math|a> and <math|b> can be approximated
  numerically using the formula <math|\<big-int\><rsub|a><rsup|b>f=<around*|[|f<around*|(|a+<frac|dx|2>|)>+f<around*|(|a+dx+<frac|dx|2>|)>+f<around*|(|a+2*dx+<frac|dx|2>|)>+\<ldots\>|]>*dx>
  for small values of <math|dx>. We can express this directly as a procedure:

  <\session|scheme|default>
    <\input|Scheme] >
      (define (integral f a b dx)

      \ \ (define (add-dx x) (+ x dx))

      \ \ (* (sum f (+ a (/ dx 2.0)) add-dx b)

      \ \ \ \ \ dx))
    </input>

    <\unfolded-io|Scheme] >
      (integral cube 0 1 0.01)
    <|unfolded-io>
      0.24998750000000042
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (integral cube 0 1 0.001)
    <|unfolded-io>
      0.249999875000001
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  (The exact value of the integral of <code*|cube> between 0 and 1 is 1/4.)

  <strong|<label|Exercise-1_002e29>Exercise 1.29:> Simpson's Rule is a more
  accurate method of numerical integration than the method illustrated above.
  Using Simpson's Rule, the integral of a function <math|f> between <math|a>
  and <math|b> is approximated as <math|<frac|h|3><around*|(|y<rsub|0>+4*y<rsub|1>+2*y<rsub|2>+4*y<rsub|3>+2*y<rsub|4>+\<cdots\>+2*y<rsub|n-2>+4*y<rsub|n-1>+y<rsub|n>|)>>,
  where <math|h=<around*|(|b-a|)><around*|/|n|\<nobracket\>>>, for some even
  integer <math|n>, and <math|y<rsub|k>=f<around*|(|a+kh|)>>. (Increasing
  <math|n> increases the accuracy of the approximation.) Define a procedure
  that takes as arguments <math|f>, <math|a>, <math|b>, and <math|n> and
  returns the value of the integral, computed using Simpson's Rule. Use your
  procedure to integrate <code*|cube> between 0 and 1 (with <math|n=100> and
  <math|n=1000>), and compare the results to those of the <code*|integral>
  procedure shown above.

  <strong|<label|Exercise-1_002e30>Exercise 1.30:> The <code*|sum> procedure
  above generates a linear recursion. The procedure can be rewritten so that
  the sum is performed iteratively. Show how to do this by filling in the
  missing expressions in the following definition:

  <\scm-code>
    (define (sum term a next b)

    \ \ (define (iter a result)

    \ \ \ \ (if \<less\>??\<gtr\>

    \ \ \ \ \ \ \ \ \<less\>??\<gtr\>

    \ \ \ \ \ \ \ \ (iter \<less\>??\<gtr\> \<less\>??\<gtr\>)))

    \ \ (iter \<less\>??\<gtr\> \<less\>??\<gtr\>))
  </scm-code>

  <strong|<label|Exercise-1_002e31>Exercise 1.31:>

  <\enumerate-alpha>
    <item>The <code*|sum> procedure is only the simplest of a vast number of
    similar abstractions that can be captured as higher-order
    procedures.<\footnote>
      The intent of <hlink|Exercise 1.31|#Exercise-1_002e31> through
      <hlink|Exercise 1.33|#Exercise-1_002e33> is to demonstrate the
      expressive power that is attained by using an appropriate abstraction
      to consolidate many seemingly disparate operations. However, though
      accumulation and filtering are elegant ideas, our hands are somewhat
      tied in using them at this point since we do not yet have data
      structures to provide suitable means of combination for these
      abstractions. We will return to these ideas in
      <hlink|2.2.3|2_002e2.xhtml#g_t2_002e2_002e3> when we show how to use
      <em|sequences><index|sequences> as interfaces for combining filters and
      accumulators to build even more powerful abstractions. We will see
      there how these methods really come into their own as a powerful and
      elegant approach to designing programs.
    </footnote> Write an analogous procedure called <code*|product> that
    returns the product of the values of a function at points over a given
    range. Show how to define <code*|factorial> in terms of <code*|product>.
    Also use <code*|product> to compute approximations to <math|\<pi\>> using
    the formula<\footnote>
      This formula was discovered by the seventeenth-century English
      mathematician John Wallis.
    </footnote>

    <\equation*>
      <frac|\<pi\>|4>=<frac|2\<cdot\>4\<cdot\>4\<cdot\>6\<cdot\>6\<cdot\>8\<cdot\>\<cdots\>|3\<cdot\>3\<cdot\>5\<cdot\>5\<cdot\>7\<cdot\>7\<cdot\>\<cdots\>>.
    </equation*>

    <item>If your <code*|product> procedure generates a recursive process,
    write one that generates an iterative process. If it generates an
    iterative process, write one that generates a recursive process.
  </enumerate-alpha>

  <strong|<label|Exercise-1_002e32>Exercise 1.32:>

  <\enumerate-alpha>
    <item>Show that <code*|sum> and <code*|product> (<hlink|Exercise
    1.31|#Exercise-1_002e31>) are both special cases of a still more general
    notion called <code*|accumulate> that combines a collection of terms,
    using some general accumulation function:

    <\code>
      (

      accumulate\ 

      \ combiner null-value term a next b

      )
    </code>

    <code*|Accumulate> takes as arguments the same term and range
    specifications as <code*|sum> and <code*|product>, together with a
    <code*|combiner> procedure (of two arguments) that specifies how the
    current term is to be combined with the accumulation of the preceding
    terms and a <code*|null-value> that specifies what base value to use when
    the terms run out. Write <code*|accumulate> and show how <code*|sum> and
    <code*|product> can both be defined as simple calls to
    <code*|accumulate>.

    <item>If your <code*|accumulate> procedure generates a recursive process,
    write one that generates an iterative process. If it generates an
    iterative process, write one that generates a recursive process.
  </enumerate-alpha>

  <strong|<label|Exercise-1_002e33>Exercise 1.33:> You can obtain an even
  more general version of <code*|accumulate> (<hlink|Exercise
  1.32|#Exercise-1_002e32>) by introducing the notion of a
  <em|filter><index|filter> on the terms to be combined. That is, combine
  only those terms derived from values in the range that satisfy a specified
  condition. The resulting <code*|filtered-accumulate> abstraction takes the
  same arguments as accumulate, together with an additional predicate of one
  argument that specifies the filter. Write <code*|filtered-accumulate> as a
  procedure. Show how to express the following using
  <code*|filtered-accumulate>:

  <\enumerate-alpha>
    <item>the sum of the squares of the prime numbers in the interval
    <math|a> to <math|b> (assuming that you have a <code*|prime?> predicate
    already written)

    <item>the product of all the positive integers less than <math|n> that
    are relatively prime to <math|n> (i.e., all positive integers
    <math|i\<less\>n> such that <math|<with|mode|text|GCD><around*|(|i,n|)>=1>).
  </enumerate-alpha>

  <subsection|Constructing Procedures Using <code*|Lambda>>

  In using <code*|sum> as in <hlink|1.3.1|#1.3.1>, it seems terribly awkward
  to have to define trivial procedures such as <code*|pi-term> and
  <code*|pi-next> just so we can use them as arguments to our higher-order
  procedure. Rather than define <code*|pi-next> and <code*|pi-term>, it would
  be more convenient to have a way to directly specify \Pthe procedure that
  returns its input incremented by 4\Q and \Pthe procedure that returns the
  reciprocal of its input times its input plus 2.\Q We can do this by
  introducing the special form <code*|lambda>, which creates procedures.
  Using <code*|lambda> we can describe what we want as

  <\scm-code>
    (lambda (x) (+ x 4))
  </scm-code>

  and

  <\scm-code>
    (lambda (x) (/ 1.0 (* x (+ x 2))))
  </scm-code>

  Then our <code*|pi-sum> procedure can be expressed without defining any
  auxiliary procedures as

  <\scm-code>
    (define (pi-sum a b)

    \ \ (sum (lambda (x) (/ 1.0 (* x (+ x 2))))

    \ \ \ \ \ \ \ a

    \ \ \ \ \ \ \ (lambda (x) (+ x 4))

    \ \ \ \ \ \ \ b))
  </scm-code>

  Again using <code*|lambda>, we can write the <code*|integral> procedure
  without having to define the auxiliary procedure <code*|add-dx>:

  <\scm-code>
    (define (integral f a b dx)

    \ \ (* (sum f

    \ \ \ \ \ \ \ \ \ \ (+ a (/ dx 2.0))

    \ \ \ \ \ \ \ \ \ \ (lambda (x) (+ x dx))

    \ \ \ \ \ \ \ \ \ \ b)

    \ \ \ \ \ dx))
  </scm-code>

  In general, <code*|lambda> is used to create procedures in the same way as
  <code*|define>, except that no name is specified for the procedure:

  <\scm-code>
    (lambda (\<langle\><var|formal-parameters>\<rangle\>)
    \<langle\><var|body>\<rangle\>)
  </scm-code>

  The resulting procedure is just as much a procedure as one that is created
  using <code*|define>. The only difference is that it has not been
  associated with any name in the environment. In fact,

  <\scm-code>
    (define (plus4 x) (+ x 4))
  </scm-code>

  is equivalent to

  <\scm-code>
    (define plus4 (lambda (x) (+ x 4)))
  </scm-code>

  We can read a <code*|lambda> expression as follows:

  <\code>
    (lambda \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (x) \ \ \ \ (+ \ \ x
    \ \ \ \ 4))

    \ \ \ \ \| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \|
    \ \ \ \ \ \ \| \ \ \| \ \ \ \ \|

    the procedure of an argument x that adds x and 4
  </code>

  Like any expression that has a procedure as its value, a <code*|lambda>
  expression can be used as the operator in a combination such as

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      ((lambda (x y z) (+ x y (square z))) 1 2 3)
    <|unfolded-io>
      12
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  or, more generally, in any context where we would normally use a procedure
  name.<\footnote>
    It would be clearer and less intimidating to people learning Lisp if a
    name more obvious than <code*|lambda>, such as <code*|make-procedure>,
    were used. But the convention is firmly entrenched. The notation is
    adopted from the \<lambda\>-calculus, a mathematical formalism introduced
    by the mathematical logician Alonzo <hlink|Church
    (1941)|References.xhtml#Church-_00281941_0029>. Church developed the
    \<lambda\>-calculus to provide a rigorous foundation for studying the
    notions of function and function application. The \<lambda\>-calculus has
    become a basic tool for mathematical investigations of the semantics of
    programming languages.
  </footnote>

  <paragraph*|Using <code*|let> to create local variables>

  Another use of <code*|lambda> is in creating local variables. We often need
  local variables in our procedures other than those that have been bound as
  formal parameters. For example, suppose we wish to compute the function
  <math|f<around*|(|x,y|)>=x<around*|(|1+xy|)><rsup|2>+y<around*|(|1-y|)>+<around*|(|1+xy|)><around*|(|1-y|)>>,
  which we could also express as

  \ <math|<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|r>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|l>|<table|<row|<cell|a>|<cell|=>|<cell|1+xy,>>|<row|<cell|<phantom|<around*|(|x,y|)>>b>|<cell|=>|<cell|1-y,>>|<row|<cell|f<around*|(|x,y|)>>|<cell|=>|<cell|xa<rsup|2>+yb+ab.>>>>>>\ 

  In writing a procedure to compute <math|f>, we would like to include as
  local variables not only <math|x> and <math|y> but also the names of
  intermediate quantities like <math|a> and <math|b>. One way to accomplish
  this is to use an auxiliary procedure to bind the local variables:

  <\scm-code>
    (define (f x y)

    \ \ (define (f-helper a b)

    \ \ \ \ (+ (* x (square a))

    \ \ \ \ \ \ \ (* y b)

    \ \ \ \ \ \ \ (* a b)))

    \ \ (f-helper (+ 1 (* x y))\ 

    \ \ \ \ \ \ \ \ \ \ \ \ (- 1 y)))
  </scm-code>

  Of course, we could use a <code*|lambda> expression to specify an anonymous
  procedure for binding our local variables. The body of <code*|f> then
  becomes a single call to that procedure:

  <\scm-code>
    (define (f x y)

    \ \ ((lambda (a b)

    \ \ \ \ \ (+ (* x (square a))

    \ \ \ \ \ \ \ \ (* y b)

    \ \ \ \ \ \ \ \ (* a b)))

    \ \ \ (+ 1 (* x y))

    \ \ \ (- 1 y)))
  </scm-code>

  This construct is so useful that there is a special form called <code*|let>
  to make its use more convenient. Using <code*|let>, the <code*|f> procedure
  could be written as

  <\scm-code>
    \;

    (define (f x y)

    \ \ (let ((a (+ 1 (* x y)))

    \ \ \ \ \ \ \ \ (b (- 1 y)))

    \ \ \ \ (+ (* x (square a))

    \ \ \ \ \ \ \ (* y b)

    \ \ \ \ \ \ \ (* a b))))
  </scm-code>

  The general form of a <code*|let> expression is

  <\scm-code>
    (let ((\<less\>var1\<gtr\> \<less\>exp1\<gtr\>)

    \ \ \ \ \ \ (\<less\>var2\<gtr\> \<less\>exp2\<gtr\>)

    \ \ \ \ \ \ 

    \ \ \ \ \ \ (\<less\>varn\<gtr\> \<less\>expn\<gtr\>))

    \ \ \ \<less\>body\<gtr\>)
  </scm-code>

  which can be thought of as saying

  <\scm-code>
    let \ \ \ \ \<less\>var1\<gtr\> have the value \<less\>exp1\<gtr\> and

    \ \ \ \ \ \ \ \ \<less\>var2\<gtr\> have the value \<less\>exp2\<gtr\>
    and

    \ \ \ \ \ \ \ \ ...

    \ \ \ \ \ \ \ \ \<less\>varn\<gtr\> have the value \<less\>expn\<gtr\>

    in \ \ \ \ \ \<less\>body\<gtr\>\ 
  </scm-code>

  The first part of the <code*|let> expression is a list of name-expression
  pairs. When the <code*|let> is evaluated, each name is associated with the
  value of the corresponding expression. The body of the <code*|let> is
  evaluated with these names bound as local variables. The way this happens
  is that the <code*|let> expression is interpreted as an alternate syntax
  for

  <\scm-code>
    ((lambda (\<less\>var1\<gtr\> ... \<less\>varn\<gtr\>)

    \ \ \ \ \<less\>body\<gtr\>)

    \ \<less\>exp1\<gtr\>

    \ ...

    \ \<less\>expn\<gtr\>)
  </scm-code>

  No new mechanism is required in the interpreter in order to provide local
  variables. A <code*|let> expression is simply syntactic sugar for the
  underlying <code*|lambda> application.

  We can see from this equivalence that the scope of a variable specified by
  a <code*|let> expression is the body of the <code*|let>. This implies that:

  <\itemize>
    <item><code*|Let> allows one to bind variables as locally as possible to
    where they are to be used. For example, if the value of <code*|x> is 5,
    the value of the expression

    <\scm-code>
      (+ (let ((x 3))

      \ \ \ \ \ (+ x (* x 10)))

      \ \ \ x)
    </scm-code>

    is 38. Here, the <code*|x> in the body of the <code*|let> is 3, so the
    value of the <code*|let> expression is 33. On the other hand, the
    <code*|x> that is the second argument to the outermost <code*|+> is still
    5.

    <item>The variables' values are computed outside the <code*|let>. This
    matters when the expressions that provide the values for the local
    variables depend upon variables having the same names as the local
    variables themselves. For example, if the value of <code*|x> is 2, the
    expression

    <\scm-code>
      (let ((x 3)

      \ \ \ \ \ \ (y (+ x 2)))

      \ \ (* x y))
    </scm-code>

    will have the value 12 because, inside the body of the <code*|let>,
    <code*|x> will be 3 and <code*|y> will be 4 (which is the outer <code*|x>
    plus 2).
  </itemize>

  Sometimes we can use internal definitions to get the same effect as with
  <code*|let>. For example, we could have defined the procedure <code*|f>
  above as

  <\scm-code>
    (define (f x y)

    \ \ (define a (+ 1 (* x y)))

    \ \ (define b (- 1 y))

    \ \ (+ (* x (square a))

    \ \ \ \ \ (* y b)

    \ \ \ \ \ (* a b)))
  </scm-code>

  We prefer, however, to use <code*|let> in situations like this and to use
  internal <code*|define> only for internal procedures.<\footnote>
    Understanding internal definitions well enough to be sure a program means
    what we intend it to mean requires a more elaborate model of the
    evaluation process than we have presented in this chapter. The subtleties
    do not arise with internal definitions of procedures, however. We will
    return to this issue in <hlink|4.1.6|4_002e1.xhtml#g_t4_002e1_002e6>,
    after we learn more about evaluation.
  </footnote>

  <strong|<label|Exercise-1_002e34>Exercise 1.34:> Suppose we define the
  procedure

  <\scm-code>
    (define (f g) (g 2))
  </scm-code>

  Then we have

  <\scm-code>
    (f square)

    <with|font-shape|italic|4>

    \;

    (f (lambda (z) (* z (+ z 1))))

    <with|font-shape|italic|6>
  </scm-code>

  What happens if we (perversely) ask the interpreter to evaluate the
  combination <code*|(f f)>? Explain.

  <subsection|Procedures as General Methods><label|1.3.3>

  We introduced compound procedures in <hlink|1.1.4|#1.1.4> as a mechanism
  for abstracting patterns of numerical operations so as to make them
  independent of the particular numbers involved. With higher-order
  procedures, such as the <code*|integral> procedure of <hlink|1.3.1|#1.3.1>,
  we began to see a more powerful kind of abstraction: procedures used to
  express general methods of computation, independent of the particular
  functions involved. In this section we discuss two more elaborate
  examples\Vgeneral methods for finding zeros and fixed points of
  functions\Vand show how these methods can be expressed directly as
  procedures.

  <paragraph*|Finding roots of equations by the half-interval method>

  The <em|half-interval method><index|half interval method> is a simple but
  powerful technique for finding roots of an equation
  <math|f<around*|(|x|)>=0>, where <math|f> is a continuous function. The
  idea is that, if we are given points <math|a> and <math|b> such that
  <math|f<around*|(|a|)>\<less\>0\<less\>f<around*|(|b|)>>, then <math|f>
  must have at least one zero between <math|a> and <math|b>. To locate a
  zero, let <math|x> be the average of <math|a> and <math|b>, and compute
  <math|f<around*|(|x|)>>. If <math|f<around*|(|x|)>\<gtr\>0>, then <math|f>
  must have a zero between <math|a> and <math|x>. If
  <math|f<around*|(|x|)>\<less\>0>, then <math|f> must have a zero between
  <math|x> and <math|b>. Continuing in this way, we can identify smaller and
  smaller intervals on which <math|f> must have a zero. When we reach a point
  where the interval is small enough, the process stops. Since the interval
  of uncertainty is reduced by half at each step of the process, the number
  of steps required grows as <math|\<Theta\><around*|(|log\<nospace\><around*|(|L<around*|/|T|)>|)>|\<nobracket\>>>,
  where <math|L> is the length of the original interval and <math|T> is the
  error tolerance (that is, the size of the interval we will consider \Psmall
  enough\Q). Here is a procedure that implements this strategy:

  <\session|scheme|default>
    <\input|Scheme] >
      (define (average x y) (/ (+ x y) 2))
    </input>

    <\input|Scheme] >
      (define (search f neg-point pos-point)

      \ \ (let ((midpoint (average neg-point pos-point)))

      \ \ \ \ (if (close-enough? neg-point pos-point)

      \ \ \ \ \ \ \ \ midpoint

      \ \ \ \ \ \ \ \ (let ((test-value (f midpoint)))

      \ \ \ \ \ \ \ \ \ \ (cond ((positive? test-value)

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (search f neg-point midpoint))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ((negative? test-value)

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (search f midpoint pos-point))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (else midpoint))))))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  We assume that we are initially given the function <math|f> together with
  points at which its values are negative and positive. We first compute the
  midpoint of the two given points. Next we check to see if the given
  interval is small enough, and if so we simply return the midpoint as our
  answer. Otherwise, we compute as a test value the value of <math|f> at the
  midpoint. If the test value is positive, then we continue the process with
  a new interval running from the original negative point to the midpoint. If
  the test value is negative, we continue with the interval from the midpoint
  to the positive point. Finally, there is the possibility that the test
  value is 0, in which case the midpoint is itself the root we are searching
  for.

  To test whether the endpoints are \Pclose enough\Q we can use a procedure
  similar to the one used in <hlink|1.1.7|#1.1.7> for computing square
  roots:<\footnote>
    We have used 0.001 as a representative \Psmall\Q number to indicate a
    tolerance for the acceptable error in a calculation. The appropriate
    tolerance for a real calculation depends upon the problem to be solved
    and the limitations of the computer and the algorithm. This is often a
    very subtle consideration, requiring help from a numerical analyst or
    some other kind of magician.
  </footnote>

  <\session|scheme|default>
    <\input|Scheme] >
      (define (close-enough? x y)

      \ \ (\<less\> (abs (- x y)) 0.001))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  <code*|Search> is awkward to use directly, because we can accidentally give
  it points at which <math|f>'s values do not have the required sign, in
  which case we get a wrong answer. Instead we will use <code*|search> via
  the following procedure, which checks to see which of the endpoints has a
  negative function value and which has a positive value, and calls the
  <code*|search> procedure accordingly. If the function has the same sign on
  the two given points, the half-interval method cannot be used, in which
  case the procedure signals an error.<\footnote>
    This can be accomplished using <code*|error>, which takes as arguments a
    number of items that are printed as error messages.
  </footnote>

  <\session|scheme|default>
    <\input|Scheme] >
      (define (half-interval-method f a b)

      \ \ (let ((a-value (f a))

      \ \ \ \ \ \ \ \ (b-value (f b)))

      \ \ \ \ (cond ((and (negative? a-value) (positive? b-value))

      \ \ \ \ \ \ \ \ \ \ \ (search f a b))

      \ \ \ \ \ \ \ \ \ \ ((and (negative? b-value) (positive? a-value))

      \ \ \ \ \ \ \ \ \ \ \ (search f b a))

      \ \ \ \ \ \ \ \ \ \ (else

      \ \ \ \ \ \ \ \ \ \ \ (error "Values are not of opposite sign" a b)))))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  The following example uses the half-interval method to approximate
  <math|\<pi\>> as the root between 2 and 4 of <math|sin\<nospace\>x=0>:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (half-interval-method sin 2.0 4.0)
    <|unfolded-io>
      3.14111328125
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Here is another example, using the half-interval method to search for a
  root of the equation <math|x<rsup|3>-2*x-3=0> between 1 and 2:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (half-interval-method (lambda (x) (- (* x x x) (* 2 x) 3))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 1.0

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 2.0)
    <|unfolded-io>
      1.89306640625
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  <paragraph*|Finding fixed points of functions>

  A number <math|x> is called a <em|fixed point><index|fixed point> of a
  function <math|f> if <math|x> satisfies the equation
  <math|f<around*|(|x|)>=x>. For some functions <math|f> we can locate a
  fixed point by beginning with an initial guess and applying <math|f>
  repeatedly, <math|f<around*|(|x|)>,f<around*|(|f<around*|(|x|)>|)>,f<around*|(|f<around*|(|f<around*|(|x|)>|)>|)>,\<ldots\>>,
  until the value does not change very much. Using this idea, we can devise a
  procedure <code*|fixed-point> that takes as inputs a function and an
  initial guess and produces an approximation to a fixed point of the
  function. We apply the function repeatedly until we find two successive
  values whose difference is less than some prescribed tolerance:

  <\session|scheme|default>
    <\input|Scheme] >
      (define tolerance 0.00001)
    </input>

    <\input|Scheme] >
      (define (fixed-point f first-guess)

      \ \ (define (close-enough? v1 v2)

      \ \ \ \ (\<less\> (abs (- v1 v2)) tolerance))

      \ \ (define (try guess)

      \ \ \ \ (let ((next (f guess)))

      \ \ \ \ \ \ (if (close-enough? guess next)

      \ \ \ \ \ \ \ \ \ \ next

      \ \ \ \ \ \ \ \ \ \ (try next))))

      \ \ (try first-guess))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  For example, we can use this method to approximate the fixed point of the
  cosine function, starting with 1 as an initial approximation:<\footnote>
    Try this during a boring lecture: Set your calculator to radians mode and
    then repeatedly press the <code*|cos> button until you obtain the fixed
    point.
  </footnote>

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (fixed-point cos 1.0)
    <|unfolded-io>
      0.7390822985224024
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Similarly, we can find a solution to the equation
  <math|y=sin\<nospace\>y+cos\<nospace\>y>:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (fixed-point (lambda (y) (+ (sin y) (cos y)))

      \ \ \ \ \ \ \ \ \ \ \ \ \ 1.0)
    <|unfolded-io>
      1.2587315962971173
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  The fixed-point process is reminiscent of the process we used for finding
  square roots in <hlink|1.1.7|1_002e1.xhtml#g_t1_002e1_002e7>. Both are
  based on the idea of repeatedly improving a guess until the result
  satisfies some criterion. In fact, we can readily formulate the square-root
  computation as a fixed-point search. Computing the square root of some
  number <math|x> requires finding a <math|y> such that <math|y<rsup|2>=x>.
  Putting this equation into the equivalent form
  <math|y=x<around*|/|y|\<nobracket\>>>, we recognize that we are looking for
  a fixed point of the function<hlink|<label|DOCF58><rsup|58>|#FOOT58><\footnote>
    <math|\<mapsto\>> (pronounced \Pmaps to\Q) is the mathematician's way of
    writing <code*|lambda>. <math|y\<mapsto\>x<around*|/|y|\<nobracket\>>>
    means <code*|(lambda (y) (/ x y))>, that is, the function whose value at
    <math|y> is <math|x<around*|/|y|\<nobracket\>>>.
  </footnote> <math|y\<mapsto\>x<around*|/|y|\<nobracket\>>>, and we can
  therefore try to compute square roots as

  <\scm-code>
    (define (sqrt x)

    \ \ (fixed-point (lambda (y) (/ x y))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 1.0))
  </scm-code>

  Unfortunately, this fixed-point search does not converge. Consider an
  initial guess <math|y<rsub|1>>. The next guess is
  <math|y<rsub|2>=x<around*|/|y<rsub|1>|\<nobracket\>>> and the next guess is
  <math|y<rsub|3>=x<around*|/|y<rsub|2>=x<around*|/|<around*|(|x<around*|/|y<rsub|1>|)>=y<rsub|1>|\<nobracket\>>|\<nobracket\>>|\<nobracket\>>>.
  This results in an infinite loop in which the two guesses <math|y<rsub|1>>
  and <math|y<rsub|2>> repeat over and over, oscillating about the answer.

  One way to control such oscillations is to prevent the guesses from
  changing so much. Since the answer is always between our guess <math|y> and
  <math|x<around*|/|y|\<nobracket\>>>, we can make a new guess that is not as
  far from <math|y> as <math|x<around*|/|y|\<nobracket\>>> by averaging
  <math|y> with <math|x<around*|/|y|\<nobracket\>>>, so that the next guess
  after <math|y> is <math|<frac|1|2><around*|(|y+x<around*|/|y|)>|\<nobracket\>>>
  instead of <math|x<around*|/|y|\<nobracket\>>>. The process of making such
  a sequence of guesses is simply the process of looking for a fixed point of
  <math|y\<mapsto\><frac|1|2><around*|(|y+x<around*|/|y|)>|\<nobracket\>>>:

  <\scm-code>
    (define (sqrt x)

    \ \ (fixed-point (lambda (y) (average y (/ x y)))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 1.0))
  </scm-code>

  (Note that <math|y=<frac|1|2><around*|(|y+x<around*|/|y|)>|\<nobracket\>>>
  is a simple transformation of the equation
  <math|y=x<around*|/|y;|\<nobracket\>>> to derive it, add <math|y> to both
  sides of the equation and divide by 2.)

  With this modification, the square-root procedure works. In fact, if we
  unravel the definitions, we can see that the sequence of approximations to
  the square root generated here is precisely the same as the one generated
  by our original square-root procedure of
  <hlink|1.1.7|1_002e1.xhtml#g_t1_002e1_002e7>. This approach of averaging
  successive approximations to a solution, a technique that we call
  <em|average damping><index|average damping>, often aids the convergence of
  fixed-point searches.

  <strong|<label|Exercise-1_002e35>Exercise 1.35:> Show that the golden ratio
  <math|\<varphi\>> (<hlink|1.2.2|#1.2.2>) is a fixed point of the
  transformation <math|x\<mapsto\>1+1<around*|/|x|\<nobracket\>>>, and use
  this fact to compute <math|\<varphi\>> by means of the <code*|fixed-point>
  procedure.

  <strong|<label|Exercise-1_002e36>Exercise 1.36:> Modify <code*|fixed-point>
  so that it prints the sequence of approximations it generates, using the
  <code*|newline> and <code*|display> primitives shown in <hlink|Exercise
  1.22|1_002e2.xhtml#Exercise-1_002e22>. Then find a solution to
  <math|x<rsup|x>=1000> by finding a fixed point of
  <math|x\<mapsto\>log\<nospace\><around*|(|1000|)><around*|/|log\<nospace\><around*|(|x|)>|\<nobracket\>>>.
  (Use Scheme's primitive <code*|log> procedure, which computes natural
  logarithms.) Compare the number of steps this takes with and without
  average damping. (Note that you cannot start <code*|fixed-point> with a
  guess of 1, as this would cause division by
  <math|log\<nospace\><around*|(|1|)>=0>.)

  <strong|<label|Exercise-1_002e37>Exercise 1.37:>

  <\enumerate>
    <item>An infinite <em|continued fraction><index|continued fraction> is an
    expression of the form <math|f=<frac|N<rsub|1>|D<rsub|1>+<frac|N<rsub|2>|D<rsub|2>+<frac|N<rsub|3>|D<rsub|3>+\<ldots\>>>>>.
    As an example, one can show that the infinite continued fraction
    expansion with the <math|N<rsub|i>> and the <math|D<rsub|i>> all equal to
    1 produces <math|1<around*|/|\<varphi\>|\<nobracket\>>>, where
    <math|\<varphi\>> is the golden ratio (described in
    <hlink|1.2.2|1_002e2.xhtml#g_t1_002e2_002e2>). One way to approximate an
    infinite continued fraction is to truncate the expansion after a given
    number of terms. Such a truncation\Va so-called finite continued fraction
    <em|<with|font-shape|italic|k>-term finite continued
    fraction><index|k-term finite continued fraction>\Vhas the form
    <math|<frac|N<rsub|1>|D<rsub|1>+<frac|N<rsub|2>|\<ddots\>+<frac|N<rsub|k>|D<rsub|k>>>>>.
    Suppose that <code*|n> and <code*|d> are procedures of one argument (the
    term index <math|i>) that return the <math|N<rsub|i>> and
    <math|D<rsub|i>> of the terms of the continued fraction. Define a
    procedure <code*|cont-frac> such that evaluating <code*|(cont-frac n d
    k)> computes the value of the <math|k>-term finite continued fraction.
    Check your procedure by approximating
    <math|1<around*|/|\<varphi\>|\<nobracket\>>> using

    <\scm-code>
      (cont-frac (lambda (i) 1.0)

      \ \ \ \ \ \ \ \ \ \ \ (lambda (i) 1.0)

      \ \ \ \ \ \ \ \ \ \ \ k)
    </scm-code>

    for successive values of <code*|k>. How large must you make <code*|k> in
    order to get an approximation that is accurate to 4 decimal places?

    <item>If your <code*|cont-frac> procedure generates a recursive process,
    write one that generates an iterative process. If it generates an
    iterative process, write one that generates a recursive process.
  </enumerate>

  <strong|<label|Exercise-1_002e38>Exercise 1.38:> In 1737, the Swiss
  mathematician Leonhard Euler published a memoir <cite*|De Fractionibus
  Continuis>, which included a continued fraction expansion for <math|e-2>,
  where <math|e> is the base of the natural logarithms. In this fraction, the
  <math|N<rsub|i>> are all 1, and the <math|D<rsub|i>> are successively 1, 2,
  1, 1, 4, 1, 1, 6, 1, 1, 8, \<ldots\>. Write a program that uses your
  <code*|cont-frac> procedure from <hlink|Exercise 1.37|#Exercise-1_002e37>
  to approximate <math|e>, based on Euler's expansion.

  <strong|<label|Exercise-1_002e39>Exercise 1.39:> A continued fraction
  representation of the tangent function was published in 1770 by the German
  mathematician J.H. Lambert:

  <\equation*>
    tan\<nospace\>x=<frac|x|1-<frac|x<rsup|2>|3-<frac|x<rsup|2>|5-\<ldots\>>>>,
  </equation*>

  where <math|x> is in radians. Define a procedure <code*|(tan-cf x k)> that
  computes an approximation to the tangent function based on Lambert's
  formula. <code*|k> specifies the number of terms to compute, as in
  <hlink|Exercise 1.37|#Exercise-1_002e37>.

  <subsection|Procedures as Returned Values>

  The above examples demonstrate how the ability to pass procedures as
  arguments significantly enhances the expressive power of our programming
  language. We can achieve even more expressive power by creating procedures
  whose returned values are themselves procedures.

  We can illustrate this idea by looking again at the fixed-point example
  described at the end of <hlink|1.3.3|#1.3.3>. We formulated a new version
  of the square-root procedure as a fixed-point search, starting with the
  observation that <math|<sqrt|x>> is a fixed-point of the function
  <math|y\<mapsto\>x<around*|/|y|\<nobracket\>>>. Then we used average
  damping to make the approximations converge. Average damping is a useful
  general technique in itself. Namely, given a function <math|f>, we consider
  the function whose value at <math|x> is equal to the average of <math|x>
  and <math|f<around*|(|x|)>>.

  We can express the idea of average damping by means of the following
  procedure:

  <\session|scheme|default>
    <\input|Scheme] >
      (define (average-damp f)

      \ \ (lambda (x) (average x (f x))))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  <code*|Average-damp> is a procedure that takes as its argument a procedure
  <code*|f> and returns as its value a procedure (produced by the
  <code*|lambda>) that, when applied to a number <code*|x>, produces the
  average of <code*|x> and <code*|(f x)>. For example, applying
  <code*|average-damp> to the <code*|square> procedure produces a procedure
  whose value at some number <math|x> is the average of <math|x> and
  <math|x<rsup|2>>. Applying this resulting procedure to 10 returns the
  average of 10 and 100, or 55:<\footnote>
    Observe that this is a combination whose operator is itself a
    combination. <hlink|Exercise 1.4|1_002e1.xhtml#Exercise-1_002e4> already
    demonstrated the ability to form such combinations, but that was only a
    toy example. Here we begin to see the real need for such
    combinations\Vwhen applying a procedure that is obtained as the value
    returned by a higher-order procedure.
  </footnote>

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      ((average-damp square) 10)
    <|unfolded-io>
      55
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Using <code*|average-damp>, we can reformulate the square-root procedure as
  follows:

  <\scm-code>
    (define (sqrt x)

    \ \ (fixed-point (average-damp (lambda (y) (/ x y)))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 1.0))
  </scm-code>

  Notice how this formulation makes explicit the three ideas in the method:
  fixed-point search, average damping, and the function
  <math|y\<mapsto\>x<around*|/|y|\<nobracket\>>>. It is instructive to
  compare this formulation of the square-root method with the original
  version given in <hlink|1.1.7|1_002e1.xhtml#g_t1_002e1_002e7>. Bear in mind
  that these procedures express the same process, and notice how much clearer
  the idea becomes when we express the process in terms of these
  abstractions. In general, there are many ways to formulate a process as a
  procedure. Experienced programmers know how to choose procedural
  formulations that are particularly perspicuous, and where useful elements
  of the process are exposed as separate entities that can be reused in other
  applications. As a simple example of reuse, notice that the cube root of
  <math|x> is a fixed point of the function
  <math|y\<mapsto\>x<around*|/|y<rsup|2>|\<nobracket\>>>, so we can
  immediately generalize our square-root procedure to one that extracts cube
  roots:<\footnote>
    See <hlink|Exercise 1.45|#Exercise-1_002e45> for a further
    generalization.
  </footnote>

  <\scm-code>
    (define (cube-root x)

    \ \ (fixed-point (average-damp (lambda (y) (/ x (square y))))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 1.0))
  </scm-code>

  <paragraph*|Newton's method>

  When we first introduced the square-root procedure, in
  <hlink|1.1.7|1_002e1.xhtml#g_t1_002e1_002e7>, we mentioned that this was a
  special case of <em|Newton's method><index|Newton's method>. If
  <math|x\<mapsto\>g<around*|(|x|)>> is a differentiable function, then a
  solution of the equation <math|g<around*|(|x|)>=0> is a fixed point of the
  function <math|x\<mapsto\>f<around*|(|x|)>> where
  <math|f<around*|(|x|)>=x-<frac|g<around*|(|x|)>|Dg<around*|(|x|)>>> and
  <math|Dg<around*|(|x|)>> is the derivative of <math|g> evaluated at
  <math|x>. Newton's method is the use of the fixed-point method we saw above
  to approximate a solution of the equation by finding a fixed point of the
  function <math|f>.<\footnote>
    Elementary calculus books usually describe Newton's method in terms of
    the sequence of approximations <math|x<rsub|n+1>=x<rsub|n>-g<around*|(|x<rsub|n>|)><around*|/|Dg<around*|(|x<rsub|n>|)>|\<nobracket\>>>.
    Having language for talking about processes and using the idea of fixed
    points simplifies the description of the method.
  </footnote>

  For many functions <math|g> and for sufficiently good initial guesses for
  <math|x>, Newton's method converges very rapidly to a solution of
  <math|g<around*|(|x|)>=0>.<\footnote>
    Newton's method does not always converge to an answer, but it can be
    shown that in favorable cases each iteration doubles the number-of-digits
    accuracy of the approximation to the solution. In such cases, Newton's
    method will converge much more rapidly than the half-interval method.
  </footnote>

  In order to implement Newton's method as a procedure, we must first express
  the idea of derivative. Note that \Pderivative,\Q like average damping, is
  something that transforms a function into another function. For instance,
  the derivative of the function <math|x\<mapsto\>x<rsup|3>> is the function
  <math|x\<mapsto\>3*x<rsup|2>>. In general, if <math|g> is a function and
  <math|dx> is a small number, then the derivative <math|Dg> of <math|g> is
  the function whose value at any number <math|x> is given (in the limit of
  small <math|dx>) by <math|Dg<around*|(|x|)>=<frac|g<around*|(|x+dx|)>-g<around*|(|x|)>|dx>>.
  Thus, we can express the idea of derivative (taking <math|dx> to be, say,
  0.00001) as the procedure

  <\scm-code>
    (define (deriv g)

    \ \ (lambda (x)

    \ \ \ \ (/ (- (g (+ x dx)) (g x))

    \ \ \ \ \ \ \ dx)))
  </scm-code>

  along with the definition

  <\scm-code>
    (define dx 0.00001)
  </scm-code>

  Like <code*|average-damp>, <code*|deriv> is a procedure that takes a
  procedure as argument and returns a procedure as value. For example, to
  approximate the derivative of <math|x\<mapsto\>x<rsup|3>> at 5 (whose exact
  value is 75) we can evaluate

  <\scm-code>
    (define (cube x) (* x x x))

    ((deriv cube) 5)

    75.00014999664018
  </scm-code>

  With the aid of <code*|deriv>, we can express Newton's method as a
  fixed-point process:

  <\scm-code>
    (define (newton-transform g)

    \ \ (lambda (x)

    \ \ \ \ (- x (/ (g x) ((deriv g) x)))))

    (define (newtons-method g guess)

    \ \ (fixed-point (newton-transform g) guess))
  </scm-code>

  The <code*|newton-transform> procedure expresses the formula at the
  beginning of this section, and <code*|newtons-method> is readily defined in
  terms of this. It takes as arguments a procedure that computes the function
  for which we want to find a zero, together with an initial guess. For
  instance, to find the square root of <math|x>, we can use Newton's method
  to find a zero of the function <math|y\<mapsto\>y<rsup|2>-x> starting with
  an initial guess of 1.<\footnote>
    For finding square roots, Newton's method converges rapidly to the
    correct solution from any starting point.
  </footnote>

  This provides yet another form of the square-root procedure:

  <\scm-code>
    (define (sqrt x)

    \ \ (newtons-method (lambda (y) (- (square y) x))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 1.0))
  </scm-code>

  <paragraph*|Abstractions and first-class procedures>

  We've seen two ways to express the square-root computation as an instance
  of a more general method, once as a fixed-point search and once using
  Newton's method. Since Newton's method was itself expressed as a
  fixed-point process, we actually saw two ways to compute square roots as
  fixed points. Each method begins with a function and finds a fixed point of
  some transformation of the function. We can express this general idea
  itself as a procedure:

  <\scm-code>
    (define (fixed-point-of-transform g transform guess)

    \ \ (fixed-point (transform g) guess))
  </scm-code>

  This very general procedure takes as its arguments a procedure <code*|g>
  that computes some function, a procedure that transforms <code*|g>, and an
  initial guess. The returned result is a fixed point of the transformed
  function.

  Using this abstraction, we can recast the first square-root computation
  from this section (where we look for a fixed point of the average-damped
  version of <math|y\<mapsto\>x<around*|/|y|\<nobracket\>>>) as an instance
  of this general method:

  <\scm-code>
    (define (sqrt x)

    \ \ (fixed-point-of-transform (lambda (y) (/ x y))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ average-damp

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 1.0))
  </scm-code>

  Similarly, we can express the second square-root computation from this
  section (an instance of Newton's method that finds a fixed point of the
  Newton transform of <math|y\<mapsto\>y<rsup|2>-x>) as

  <\scm-code>
    (define (sqrt x)

    \ \ (fixed-point-of-transform (lambda (y) (- (square y) x))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ newton-transform

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 1.0))
  </scm-code>

  We began section <hlink|1.3|#g_t1_002e3> with the observation that compound
  procedures are a crucial abstraction mechanism, because they permit us to
  express general methods of computing as explicit elements in our
  programming language. Now we've seen how higher-order procedures permit us
  to manipulate these general methods to create further abstractions.

  As programmers, we should be alert to opportunities to identify the
  underlying abstractions in our programs and to build upon them and
  generalize them to create more powerful abstractions. This is not to say
  that one should always write programs in the most abstract way possible;
  expert programmers know how to choose the level of abstraction appropriate
  to their task. But it is important to be able to think in terms of these
  abstractions, so that we can be ready to apply them in new contexts. The
  significance of higher-order procedures is that they enable us to represent
  these abstractions explicitly as elements in our programming language, so
  that they can be handled just like other computational elements.

  In general, programming languages impose restrictions on the ways in which
  computational elements can be manipulated. Elements with the fewest
  restrictions are said to have <em|first-class><index|first-class> status.
  Some of the \Prights and privileges\Q of first-class elements
  are:<\footnote>
    The notion of first-class status of programming-language elements is due
    to the British computer scientist Christopher Strachey (1916-1975).
  </footnote>

  <\itemize>
    <item>They may be named by variables.

    <item>They may be passed as arguments to procedures.

    <item>They may be returned as the results of procedures.

    <item>They may be included in data structures.<\footnote>
      We'll see examples of this after we introduce data structures in
      <hlink|Chapter<nbsp>2|Chapter-2.xhtml#Chapter-2>.
    </footnote>
  </itemize>

  Lisp, unlike other common programming languages, awards procedures full
  first-class status. This poses challenges for efficient implementation, but
  the resulting gain in expressive power is enormous.<\footnote>
    The major implementation cost of first-class procedures is that allowing
    procedures to be returned as values requires reserving storage for a
    procedure's free variables even while the procedure is not executing. In
    the Scheme implementation we will study in
    <hlink|4.1|4_002e1.xhtml#g_t4_002e1>, these variables are stored in the
    procedure's environment.
  </footnote>

  <strong|<label|Exercise-1_002e40>Exercise 1.40:> Define a procedure
  <code*|cubic> that can be used together with the <code*|newtons-method>
  procedure in expressions of the form

  <code|(newtons-method (cubic a b c) 1)>

  to approximate zeros of the cubic <math|x<rsup|3>+ax<rsup|2>+bx+c>.

  <strong|<label|Exercise-1_002e41>Exercise 1.41:> Define a procedure
  <code*|double> that takes a procedure of one argument as argument and
  returns a procedure that applies the original procedure twice. For example,
  if <code*|inc> is a procedure that adds 1 to its argument, then
  <code*|(double inc)> should be a procedure that adds 2. What value is
  returned by

  <code|(((double (double double)) inc) 5)>

  <strong|<label|Exercise-1_002e42>Exercise 1.42:> Let <math|f> and <math|g>
  be two one-argument functions. The <em|composition><index|composition>
  <math|f> after <math|g> is defined to be the function
  <math|x\<mapsto\>f<around*|(|g<around*|(|x|)>|)>>. Define a procedure
  <code*|compose> that implements composition. For example, if <code*|inc> is
  a procedure that adds 1 to its argument,

  <\scm-code>
    ((compose square inc) 6)

    <with|font-shape|italic|49>
  </scm-code>

  <strong|<label|Exercise-1_002e43>Exercise 1.43:> If <math|f> is a numerical
  function and <math|n> is a positive integer, then we can form the
  <math|n<rsup|<with|mode|text|th>>> repeated application of <math|f>, which
  is defined to be the function whose value at <math|x> is
  <math|f<around*|(|f<around*|(|\<ldots\><around*|(|f<around*|(|x|)>|)>*\<ldots\>|)>|)>>.
  For example, if <math|f> is the function <math|x\<mapsto\>x+1>, then the
  <math|n<rsup|<with|mode|text|th>>> repeated application of <math|f> is the
  function <math|x\<mapsto\>x+n>. If <math|f> is the operation of squaring a
  number, then the <math|n<rsup|<with|mode|text|th>>> repeated application of
  <math|f> is the function that raises its argument to the
  <math|2<rsup|n><with|mode|text|-th>> power. Write a procedure that takes as
  inputs a procedure that computes <math|f> and a positive integer <math|n>
  and returns the procedure that computes the
  <math|n<rsup|<with|mode|text|th>>> repeated application of <math|f>. Your
  procedure should be able to be used as follows:

  <\scm-code>
    ((repeated square 2) 5)

    <with|font-shape|italic|625>
  </scm-code>

  Hint: You may find it convenient to use <code*|compose> from
  <hlink|Exercise 1.42|#Exercise-1_002e42>.

  <strong|<label|Exercise-1_002e44>Exercise 1.44:> The idea of
  <em|smoothing><index|smoothing> a function is an important concept in
  signal processing. If <math|f> is a function and <math|dx> is some small
  number, then the smoothed version of <math|f> is the function whose value
  at a point <math|x> is the average of <math|f<around*|(|x-dx|)>>,
  <math|f<around*|(|x|)>>, and <math|f<around*|(|x+dx|)>>. Write a procedure
  <code*|smooth> that takes as input a procedure that computes <math|f> and
  returns a procedure that computes the smoothed <math|f>. It is sometimes
  valuable to repeatedly smooth a function (that is, smooth the smoothed
  function, and so on) to obtain the <em|<with|font-shape|italic|n>-fold
  smoothed function><index|n-fold smoothed function>. Show how to generate
  the <with|font-shape|italic|n>-fold smoothed function of any given function
  using <code*|smooth> and <code*|repeated> from <hlink|Exercise
  1.43|#Exercise-1_002e43>.

  <strong|<label|Exercise-1_002e45>Exercise 1.45:> We saw in
  <hlink|1.3.3|#1.3.3> that attempting to compute square roots by naively
  finding a fixed point of <math|y\<mapsto\>x<around*|/|y|\<nobracket\>>>
  does not converge, and that this can be fixed by average damping. The same
  method works for finding cube roots as fixed points of the average-damped
  <math|y\<mapsto\>x<around*|/|y<rsup|2>|\<nobracket\>>>. Unfortunately, the
  process does not work for fourth roots\Va single average damp is not enough
  to make a fixed-point search for <math|y\<mapsto\>x<around*|/|y<rsup|3>|\<nobracket\>>>
  converge. On the other hand, if we average damp twice (i.e., use the
  average damp of the average damp of <math|y\<mapsto\>x<around*|/|y<rsup|3>|\<nobracket\>>>)
  the fixed-point search does converge. Do some experiments to determine how
  many average damps are required to compute
  <math|n<rsup|<with|mode|text|th>>> roots as a fixed-point search based upon
  repeated average damping of <math|y\<mapsto\>x<around*|/|y<rsup|n-1>|\<nobracket\>>>.
  Use this to implement a simple procedure for computing
  <math|n<rsup|<with|mode|text|th>>> roots using <code*|fixed-point>,
  <code*|average-damp>, and the <code*|repeated> procedure of <hlink|Exercise
  1.43|#Exercise-1_002e43>. Assume that any arithmetic operations you need
  are available as primitives.

  <strong|<label|Exercise-1_002e46>Exercise 1.46:> Several of the numerical
  methods described in this chapter are instances of an extremely general
  computational strategy known as <em|iterative improvement><index|iterative
  improvement>. Iterative improvement says that, to compute something, we
  start with an initial guess for the answer, test if the guess is good
  enough, and otherwise improve the guess and continue the process using the
  improved guess as the new guess. Write a procedure
  <code*|iterative-improve> that takes two procedures as arguments: a method
  for telling whether a guess is good enough and a method for improving a
  guess. <code*|Iterative-improve> should return as its value a procedure
  that takes a guess as argument and keeps improving the guess until it is
  good enough. Rewrite the <code*|sqrt> procedure of
  <hlink|1.1.7|1_002e1.xhtml#g_t1_002e1_002e7> and the <code*|fixed-point>
  procedure of <hlink|1.3.3|#1.3.3> in terms of <code*|iterative-improve>.
</body>

<\initial>
  <\collection>
    <associate|chapter-nr|0>
    <associate|page-first|3>
    <associate|page-medium|paper>
    <associate|par-first|0tab>
    <associate|par-par-sep|1fn>
    <associate|section-nr|0>
    <associate|subsection-nr|0>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|#1.2.6|<tuple|1.2.6|37>>
    <associate|%_idx_102|<tuple|1.3|6>>
    <associate|%_idx_104|<tuple|1.3|6>>
    <associate|%_idx_106|<tuple|1.3|6>>
    <associate|%_idx_32|<tuple|interpreter|6>>
    <associate|%_idx_34|<tuple|interpreter|6>>
    <associate|%_idx_36|<tuple|1.1|6>>
    <associate|%_idx_40|<tuple|1.1|6>>
    <associate|%_idx_42|<tuple|1.1|6>>
    <associate|%_idx_44|<tuple|1.1|6>>
    <associate|%_idx_46|<tuple|1.2|6>>
    <associate|%_idx_48|<tuple|1.2|6>>
    <associate|%_idx_50|<tuple|1.2|6>>
    <associate|%_idx_52|<tuple|1.2|6>>
    <associate|%_idx_54|<tuple|1.2|6>>
    <associate|%_idx_56|<tuple|1.2|6>>
    <associate|%_idx_58|<tuple|1.2|6>>
    <associate|%_idx_60|<tuple|1.2|6>>
    <associate|%_idx_62|<tuple|1.2|6>>
    <associate|%_idx_64|<tuple|1.2|6>>
    <associate|%_idx_66|<tuple|1.2|6>>
    <associate|%_idx_68|<tuple|1.2|6>>
    <associate|%_idx_70|<tuple|1.2|6>>
    <associate|%_idx_72|<tuple|1.2|6>>
    <associate|%_idx_74|<tuple|1.2|6>>
    <associate|%_idx_76|<tuple|1.2|6>>
    <associate|%_idx_78|<tuple|1.2|6>>
    <associate|%_idx_80|<tuple|1.2|6>>
    <associate|%_idx_82|<tuple|1.2|6>>
    <associate|%_idx_84|<tuple|1.2|6>>
    <associate|%_idx_86|<tuple|1.2|6>>
    <associate|%_idx_88|<tuple|1.2|6>>
    <associate|%_idx_90|<tuple|1.2|6>>
    <associate|%_idx_92|<tuple|1.2|6>>
    <associate|%_idx_94|<tuple|1.2|6>>
    <associate|1.1.3|<tuple|1.1.3|10>>
    <associate|1.1.4|<tuple|1.1.4|11>>
    <associate|1.1.7|<tuple|1.1.7|18>>
    <associate|1.1.8|<tuple|1.1.8|21>>
    <associate|1.2.1|<tuple|1.2.1|25>>
    <associate|1.2.2|<tuple|1.2.2|28>>
    <associate|1.2.4|<tuple|1.2.4|33>>
    <associate|1.3|<tuple|1.3|41>>
    <associate|1.3.1|<tuple|1.3.1|41>>
    <associate|1.3.3|<tuple|1.3.3|48>>
    <associate|DOCF58|<tuple|1.57|51>>
    <associate|Exercise-1_002e10|<tuple|1.31|28>>
    <associate|Exercise-1_002e11|<tuple|memoization|31>>
    <associate|Exercise-1_002e12|<tuple|memoization|31>>
    <associate|Exercise-1_002e13|<tuple|binomial coefficients|32>>
    <associate|Exercise-1_002e14|<tuple|1.36|33>>
    <associate|Exercise-1_002e15|<tuple|1.36|33>>
    <associate|Exercise-1_002e16|<tuple|1.39|34>>
    <associate|Exercise-1_002e17|<tuple|invariant quantity|34>>
    <associate|Exercise-1_002e18|<tuple|invariant quantity|35>>
    <associate|Exercise-1_002e19|<tuple|1.40|35>>
    <associate|Exercise-1_002e20|<tuple|1.43|37>>
    <associate|Exercise-1_002e21|<tuple|RSA algorithm|39>>
    <associate|Exercise-1_002e22|<tuple|RSA algorithm|39>>
    <associate|Exercise-1_002e23|<tuple|RSA algorithm|40>>
    <associate|Exercise-1_002e24|<tuple|RSA algorithm|40>>
    <associate|Exercise-1_002e25|<tuple|RSA algorithm|40>>
    <associate|Exercise-1_002e26|<tuple|RSA algorithm|40>>
    <associate|Exercise-1_002e27|<tuple|RSA algorithm|40>>
    <associate|Exercise-1_002e28|<tuple|RSA algorithm|41>>
    <associate|Exercise-1_002e29|<tuple|1.50|44>>
    <associate|Exercise-1_002e30|<tuple|1.50|44>>
    <associate|Exercise-1_002e31|<tuple|1.50|44>>
    <associate|Exercise-1_002e32|<tuple|b|44>>
    <associate|Exercise-1_002e33|<tuple|b|45>>
    <associate|Exercise-1_002e34|<tuple|1.54|48>>
    <associate|Exercise-1_002e35|<tuple|average damping|51>>
    <associate|Exercise-1_002e36|<tuple|average damping|51>>
    <associate|Exercise-1_002e37|<tuple|average damping|52>>
    <associate|Exercise-1_002e38|<tuple|2|52>>
    <associate|Exercise-1_002e39|<tuple|2|52>>
    <associate|Exercise-1_002e40|<tuple|1.66|56>>
    <associate|Exercise-1_002e41|<tuple|1.66|56>>
    <associate|Exercise-1_002e42|<tuple|1.66|56>>
    <associate|Exercise-1_002e43|<tuple|composition|56>>
    <associate|Exercise-1_002e44|<tuple|composition|56>>
    <associate|Exercise-1_002e45|<tuple|n-fold smoothed function|56>>
    <associate|Exercise-1_002e46|<tuple|n-fold smoothed function|56>>
    <associate|Exercise-1_002e9|<tuple|1.31|27>>
    <associate|Figure1.1|<tuple|1.1|11>>
    <associate|auto-1|<tuple|1|5>>
    <associate|auto-10|<tuple|recusion equations|5>>
    <associate|auto-100|<tuple|congruent modulo|38>>
    <associate|auto-101|<tuple|remainder of|38>>
    <associate|auto-102|<tuple|modulo|38>>
    <associate|auto-103|<tuple|1.46|38>>
    <associate|auto-104|<tuple|Carmichael numbers|39>>
    <associate|auto-105|<tuple|probabilistic algorithms|39>>
    <associate|auto-106|<tuple|RSA algorithm|39>>
    <associate|auto-107|<tuple|Miller-Rabin test|41>>
    <associate|auto-108|<tuple|1.3|41>>
    <associate|auto-109|<tuple|higher-order procedures|41>>
    <associate|auto-11|<tuple|interpreter|6>>
    <associate|auto-110|<tuple|1.3.1|41>>
    <associate|auto-111|<tuple|summation of a series|42>>
    <associate|auto-112|<tuple|sequences|44>>
    <associate|auto-113|<tuple|filter|45>>
    <associate|auto-114|<tuple|1.3.2|45>>
    <associate|auto-115|<tuple|1.53|46>>
    <associate|auto-116|<tuple|1.3.3|48>>
    <associate|auto-117|<tuple|1.3.3|49>>
    <associate|auto-118|<tuple|half interval method|49>>
    <associate|auto-119|<tuple|1.56|50>>
    <associate|auto-12|<tuple|procedures|6>>
    <associate|auto-120|<tuple|fixed point|50>>
    <associate|auto-121|<tuple|average damping|51>>
    <associate|auto-122|<tuple|continued fraction|52>>
    <associate|auto-123|<tuple|k-term finite continued fraction|52>>
    <associate|auto-124|<tuple|1.3.4|52>>
    <associate|auto-125|<tuple|1.60|53>>
    <associate|auto-126|<tuple|Newton's method|53>>
    <associate|auto-127|<tuple|1.63|54>>
    <associate|auto-128|<tuple|first-class|55>>
    <associate|auto-129|<tuple|composition|56>>
    <associate|auto-13|<tuple|1.1|7>>
    <associate|auto-130|<tuple|smoothing|56>>
    <associate|auto-131|<tuple|n-fold smoothed function|56>>
    <associate|auto-132|<tuple|iterative improvement|56>>
    <associate|auto-14|<tuple|integers|7>>
    <associate|auto-15|<tuple|real numbers|7>>
    <associate|auto-16|<tuple|1.1.1|7>>
    <associate|auto-17|<tuple|expression|7>>
    <associate|auto-18|<tuple|evaluating|7>>
    <associate|auto-19|<tuple|combinations|8>>
    <associate|auto-2|<tuple|computational process|5>>
    <associate|auto-20|<tuple|operator|8>>
    <associate|auto-21|<tuple|operands|8>>
    <associate|auto-22|<tuple|arguments|8>>
    <associate|auto-23|<tuple|prefix notation|8>>
    <associate|auto-24|<tuple|pretty-printing|9>>
    <associate|auto-25|<tuple|read-eval-print loop|9>>
    <associate|auto-26|<tuple|1.1.2|9>>
    <associate|auto-27|<tuple|variable|9>>
    <associate|auto-28|<tuple|value|9>>
    <associate|auto-29|<tuple|environment|10>>
    <associate|auto-3|<tuple|data|5>>
    <associate|auto-30|<tuple|global environment|10>>
    <associate|auto-31|<tuple|1.1.3|10>>
    <associate|auto-32|<tuple|recursive|10>>
    <associate|auto-33|<tuple|tree accumulation|10>>
    <associate|auto-34|<tuple|1.1|11>>
    <associate|auto-35|<tuple|special forms|11>>
    <associate|auto-36|<tuple|syntactic sugar|11>>
    <associate|auto-37|<tuple|1.1.4|11>>
    <associate|auto-38|<tuple|procedure definitions|12>>
    <associate|auto-39|<tuple|compound procedure|12>>
    <associate|auto-4|<tuple|program|5>>
    <associate|auto-40|<tuple|1.1.5|13>>
    <associate|auto-41|<tuple|substitution model|14>>
    <associate|auto-42|<tuple|substitution|14>>
    <associate|auto-43|<tuple|substitution|14>>
    <associate|auto-44|<tuple|normal order evaluation|15>>
    <associate|auto-45|<tuple|application-order evaluation|15>>
    <associate|auto-46|<tuple|stream processing|15>>
    <associate|auto-47|<tuple|1.1.6|15>>
    <associate|auto-48|<tuple|case analysis|15>>
    <associate|auto-49|<tuple|clauses|16>>
    <associate|auto-5|<tuple|programming languages|5>>
    <associate|auto-50|<tuple|predicate|16>>
    <associate|auto-51|<tuple|consequent expression|16>>
    <associate|auto-52|<tuple|predicate|16>>
    <associate|auto-53|<tuple|1.1.7|18>>
    <associate|auto-54|<tuple|1.1.8|21>>
    <associate|auto-55|<tuple|recursive|21>>
    <associate|auto-56|<tuple|1.2|21>>
    <associate|auto-57|<tuple|procedural abstraction|22>>
    <associate|auto-58|<tuple|1.25|22>>
    <associate|auto-59|<tuple|bound variable|23>>
    <associate|auto-6|<tuple|bugs|5>>
    <associate|auto-60|<tuple|binds|23>>
    <associate|auto-61|<tuple|free|23>>
    <associate|auto-62|<tuple|scope|23>>
    <associate|auto-63|<tuple|capturing|23>>
    <associate|auto-64|<tuple|capturing|23>>
    <associate|auto-65|<tuple|block structure|24>>
    <associate|auto-66|<tuple|lexical scoping|24>>
    <associate|auto-67|<tuple|1.2|24>>
    <associate|auto-68|<tuple|local evolution|25>>
    <associate|auto-69|<tuple|global|25>>
    <associate|auto-7|<tuple|glitches|5>>
    <associate|auto-70|<tuple|1.2.1|25>>
    <associate|auto-71|<tuple|1.3|25>>
    <associate|auto-72|<tuple|1.4|26>>
    <associate|auto-73|<tuple|deferred operations|26>>
    <associate|auto-74|<tuple|recursive process|26>>
    <associate|auto-75|<tuple|linear recursive process|26>>
    <associate|auto-76|<tuple|iterative process|27>>
    <associate|auto-77|<tuple|state variables|27>>
    <associate|auto-78|<tuple|linear iterative process|27>>
    <associate|auto-79|<tuple|process|27>>
    <associate|auto-8|<tuple|debug|5>>
    <associate|auto-80|<tuple|procedure|27>>
    <associate|auto-81|<tuple|tail-recursive|27>>
    <associate|auto-82|<tuple|1.2.2|28>>
    <associate|auto-83|<tuple|tree recursion|28>>
    <associate|auto-84|<tuple|1.5|29>>
    <associate|auto-85|<tuple|golden ratio|29>>
    <associate|auto-86|<tuple|1.32|30>>
    <associate|auto-87|<tuple|tabulation|31>>
    <associate|auto-88|<tuple|memoization|31>>
    <associate|auto-89|<tuple|Pascal's triangle|31>>
    <associate|auto-9|<tuple|1|5>>
    <associate|auto-90|<tuple|binomial coefficients|32>>
    <associate|auto-91|<tuple|1.2.3|32>>
    <associate|auto-92|<tuple|order of growth|32>>
    <associate|auto-93|<tuple|1.2.4|33>>
    <associate|auto-94|<tuple|invariant quantity|34>>
    <associate|auto-95|<tuple|1.2.5|35>>
    <associate|auto-96|<tuple|Euclid's Algorithm|36>>
    <associate|auto-97|<tuple|1.2.6|37>>
    <associate|auto-98|<tuple|1.2.6|37>>
    <associate|auto-99|<tuple|1.44|37>>
    <associate|define_fib|<tuple|tree recursion|28>>
    <associate|fig1.2|<tuple|1.2|21>>
    <associate|fig1.3|<tuple|1.3|25>>
    <associate|fig1.4|<tuple|1.4|26>>
    <associate|fig1.5|<tuple|1.5|29>>
    <associate|footnote-1.1|<tuple|1.1|6>>
    <associate|footnote-1.10|<tuple|1.10|10>>
    <associate|footnote-1.11|<tuple|1.11|11>>
    <associate|footnote-1.12|<tuple|1.12|12>>
    <associate|footnote-1.13|<tuple|1.13|12>>
    <associate|footnote-1.14|<tuple|1.14|12>>
    <associate|footnote-1.15|<tuple|1.15|14>>
    <associate|footnote-1.16|<tuple|1.16|15>>
    <associate|footnote-1.17|<tuple|1.17|16>>
    <associate|footnote-1.18|<tuple|1.18|16>>
    <associate|footnote-1.19|<tuple|1.19|17>>
    <associate|footnote-1.2|<tuple|1.2|6>>
    <associate|footnote-1.20|<tuple|1.20|19>>
    <associate|footnote-1.21|<tuple|1.21|19>>
    <associate|footnote-1.22|<tuple|1.22|20>>
    <associate|footnote-1.23|<tuple|1.23|20>>
    <associate|footnote-1.24|<tuple|1.24|20>>
    <associate|footnote-1.25|<tuple|1.25|22>>
    <associate|footnote-1.26|<tuple|1.26|23>>
    <associate|footnote-1.27|<tuple|1.27|24>>
    <associate|footnote-1.28|<tuple|1.28|24>>
    <associate|footnote-1.29|<tuple|1.29|26>>
    <associate|footnote-1.3|<tuple|1.3|6>>
    <associate|footnote-1.30|<tuple|1.30|27>>
    <associate|footnote-1.31|<tuple|1.31|27>>
    <associate|footnote-1.32|<tuple|1.32|30>>
    <associate|footnote-1.33|<tuple|1.33|30>>
    <associate|footnote-1.34|<tuple|1.34|31>>
    <associate|footnote-1.35|<tuple|1.35|32>>
    <associate|footnote-1.36|<tuple|1.36|32>>
    <associate|footnote-1.37|<tuple|1.37|34>>
    <associate|footnote-1.38|<tuple|1.38|34>>
    <associate|footnote-1.39|<tuple|1.39|34>>
    <associate|footnote-1.4|<tuple|1.4|7>>
    <associate|footnote-1.40|<tuple|1.40|35>>
    <associate|footnote-1.41|<tuple|1.41|35>>
    <associate|footnote-1.42|<tuple|1.42|36>>
    <associate|footnote-1.43|<tuple|1.43|36>>
    <associate|footnote-1.44|<tuple|1.44|37>>
    <associate|footnote-1.45|<tuple|1.45|37>>
    <associate|footnote-1.46|<tuple|1.46|38>>
    <associate|footnote-1.47|<tuple|1.47|39>>
    <associate|footnote-1.48|<tuple|1.48|39>>
    <associate|footnote-1.49|<tuple|1.49|42>>
    <associate|footnote-1.5|<tuple|1.5|7>>
    <associate|footnote-1.50|<tuple|1.50|43>>
    <associate|footnote-1.51|<tuple|1.51|44>>
    <associate|footnote-1.52|<tuple|1.52|44>>
    <associate|footnote-1.53|<tuple|1.53|46>>
    <associate|footnote-1.54|<tuple|1.54|48>>
    <associate|footnote-1.55|<tuple|1.55|49>>
    <associate|footnote-1.56|<tuple|1.56|49>>
    <associate|footnote-1.57|<tuple|1.57|50>>
    <associate|footnote-1.58|<tuple|1.58|51>>
    <associate|footnote-1.59|<tuple|1.59|53>>
    <associate|footnote-1.6|<tuple|1.6|9>>
    <associate|footnote-1.60|<tuple|1.60|53>>
    <associate|footnote-1.61|<tuple|1.61|53>>
    <associate|footnote-1.62|<tuple|1.62|53>>
    <associate|footnote-1.63|<tuple|1.63|54>>
    <associate|footnote-1.64|<tuple|1.64|55>>
    <associate|footnote-1.65|<tuple|1.65|55>>
    <associate|footnote-1.66|<tuple|1.66|55>>
    <associate|footnote-1.7|<tuple|1.7|9>>
    <associate|footnote-1.8|<tuple|1.8|9>>
    <associate|footnote-1.9|<tuple|1.9|10>>
    <associate|footnr-1.1|<tuple|1.1|6>>
    <associate|footnr-1.10|<tuple|1.10|10>>
    <associate|footnr-1.11|<tuple|syntactic sugar|11>>
    <associate|footnr-1.12|<tuple|1.12|12>>
    <associate|footnr-1.13|<tuple|1.13|12>>
    <associate|footnr-1.14|<tuple|1.14|12>>
    <associate|footnr-1.15|<tuple|substitution|14>>
    <associate|footnr-1.16|<tuple|stream processing|15>>
    <associate|footnr-1.17|<tuple|1.17|16>>
    <associate|footnr-1.18|<tuple|1.18|16>>
    <associate|footnr-1.19|<tuple|1.19|17>>
    <associate|footnr-1.2|<tuple|1.2|6>>
    <associate|footnr-1.20|<tuple|1.20|19>>
    <associate|footnr-1.21|<tuple|1.21|19>>
    <associate|footnr-1.22|<tuple|1.22|20>>
    <associate|footnr-1.23|<tuple|1.23|20>>
    <associate|footnr-1.24|<tuple|1.24|20>>
    <associate|footnr-1.25|<tuple|1.25|22>>
    <associate|footnr-1.26|<tuple|1.26|23>>
    <associate|footnr-1.27|<tuple|1.27|24>>
    <associate|footnr-1.28|<tuple|1.28|24>>
    <associate|footnr-1.29|<tuple|1.29|26>>
    <associate|footnr-1.3|<tuple|1.3|6>>
    <associate|footnr-1.30|<tuple|1.30|27>>
    <associate|footnr-1.31|<tuple|1.31|27>>
    <associate|footnr-1.32|<tuple|1.32|30>>
    <associate|footnr-1.33|<tuple|1.33|30>>
    <associate|footnr-1.34|<tuple|memoization|31>>
    <associate|footnr-1.35|<tuple|binomial coefficients|32>>
    <associate|footnr-1.36|<tuple|1.36|32>>
    <associate|footnr-1.37|<tuple|1.37|34>>
    <associate|footnr-1.38|<tuple|1.38|34>>
    <associate|footnr-1.39|<tuple|1.39|34>>
    <associate|footnr-1.4|<tuple|real numbers|7>>
    <associate|footnr-1.40|<tuple|1.40|35>>
    <associate|footnr-1.41|<tuple|1.41|35>>
    <associate|footnr-1.42|<tuple|1.42|36>>
    <associate|footnr-1.43|<tuple|1.43|36>>
    <associate|footnr-1.44|<tuple|1.44|37>>
    <associate|footnr-1.45|<tuple|1.45|37>>
    <associate|footnr-1.46|<tuple|1.46|38>>
    <associate|footnr-1.47|<tuple|Carmichael numbers|39>>
    <associate|footnr-1.48|<tuple|RSA algorithm|39>>
    <associate|footnr-1.49|<tuple|1.49|42>>
    <associate|footnr-1.5|<tuple|1.5|7>>
    <associate|footnr-1.50|<tuple|1.50|43>>
    <associate|footnr-1.51|<tuple|sequences|44>>
    <associate|footnr-1.52|<tuple|1.52|44>>
    <associate|footnr-1.53|<tuple|1.53|46>>
    <associate|footnr-1.54|<tuple|1.54|48>>
    <associate|footnr-1.55|<tuple|1.55|49>>
    <associate|footnr-1.56|<tuple|1.56|49>>
    <associate|footnr-1.57|<tuple|1.57|50>>
    <associate|footnr-1.58|<tuple|1.58|51>>
    <associate|footnr-1.59|<tuple|1.59|53>>
    <associate|footnr-1.6|<tuple|1.6|9>>
    <associate|footnr-1.60|<tuple|1.60|53>>
    <associate|footnr-1.61|<tuple|1.61|53>>
    <associate|footnr-1.62|<tuple|1.62|53>>
    <associate|footnr-1.63|<tuple|1.63|54>>
    <associate|footnr-1.64|<tuple|1.64|55>>
    <associate|footnr-1.65|<tuple|1.65|55>>
    <associate|footnr-1.66|<tuple|1.66|55>>
    <associate|footnr-1.7|<tuple|1.7|9>>
    <associate|footnr-1.8|<tuple|1.8|9>>
    <associate|footnr-1.9|<tuple|1.9|10>>
    <associate|index-invariant-quantity|<tuple|1.39|34>>
    <associate|index-stack|<tuple|1.30|27>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1.1>|>
        Tree representation, showing the value of each subcombination.
      </surround>|<pageref|auto-34>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|1.2>|>
        Procedural decomposition of the <with|mode|<quote|prog>|prog-language|<quote|scheme>|font-family|<quote|rm>|sqrt>
        program
      </surround>|<pageref|auto-56>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|1.3>|>
        A linear recursive process for computing 6!.
      </surround>|<pageref|auto-71>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|1.4>|>
        A linear iterative process for computing 6!.
      </surround>|<pageref|auto-72>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|1.5>|>
        The tree-recursive process generated in computing
        <with|font-family|<quote|tt>|(fib 5)>.
      </surround>|<pageref|auto-84>>
    </associate>
    <\associate|idx>
      <tuple|<tuple|computational process>|<pageref|auto-2>>

      <tuple|<tuple|data>|<pageref|auto-3>>

      <tuple|<tuple|program>|<pageref|auto-4>>

      <tuple|<tuple|programming languages>|<pageref|auto-5>>

      <tuple|<tuple|bugs>|<pageref|auto-6>>

      <tuple|<tuple|glitches>|<pageref|auto-7>>

      <tuple|<tuple|debug>|<pageref|auto-8>>

      <tuple|<tuple|recusion equations>|<pageref|auto-10>>

      <tuple|<tuple|interpreter>|<pageref|auto-11>>

      <tuple|<tuple|procedures>|<pageref|auto-12>>

      <tuple|<tuple|integers>|<pageref|auto-14>>

      <tuple|<tuple|real numbers>|<pageref|auto-15>>

      <tuple|<tuple|expression>|<pageref|auto-17>>

      <tuple|<tuple|evaluating>|<pageref|auto-18>>

      <tuple|<tuple|combinations>|<pageref|auto-19>>

      <tuple|<tuple|operator>|<pageref|auto-20>>

      <tuple|<tuple|operands>|<pageref|auto-21>>

      <tuple|<tuple|arguments>|<pageref|auto-22>>

      <tuple|<tuple|prefix notation>|<pageref|auto-23>>

      <tuple|<tuple|pretty-printing>|<pageref|auto-24>>

      <tuple|<tuple|read-eval-print loop>|<pageref|auto-25>>

      <tuple|<tuple|variable>|<pageref|auto-27>>

      <tuple|<tuple|value>|<pageref|auto-28>>

      <tuple|<tuple|environment>|<pageref|auto-29>>

      <tuple|<tuple|global environment>|<pageref|auto-30>>

      <tuple|<tuple|recursive>|<pageref|auto-32>>

      <tuple|<tuple|tree accumulation>|<pageref|auto-33>>

      <tuple|<tuple|special forms>|<pageref|auto-35>>

      <tuple|<tuple|syntactic sugar>|<pageref|auto-36>>

      <tuple|<tuple|procedure definitions>|<pageref|auto-38>>

      <tuple|<tuple|compound procedure>|<pageref|auto-39>>

      <tuple|<tuple|substitution model>|<pageref|auto-41>>

      <tuple|<tuple|substitution>|<pageref|auto-42>>

      <tuple|<tuple|normal order evaluation>|<pageref|auto-44>>

      <tuple|<tuple|application-order evaluation>|<pageref|auto-45>>

      <tuple|<tuple|stream processing>|<pageref|auto-46>>

      <tuple|<tuple|case analysis>|<pageref|auto-48>>

      <tuple|<tuple|clauses>|<pageref|auto-49>>

      <tuple|<tuple|predicate>|<pageref|auto-50>>

      <tuple|<tuple|consequent expression>|<pageref|auto-51>>

      <tuple|<tuple|predicate>|<pageref|auto-52>>

      <tuple|<tuple|recursive>|<pageref|auto-55>>

      <tuple|<tuple|procedural abstraction>|<pageref|auto-57>>

      <tuple|<tuple|bound variable>|<pageref|auto-59>>

      <tuple|<tuple|binds>|<pageref|auto-60>>

      <tuple|<tuple|free>|<pageref|auto-61>>

      <tuple|<tuple|scope>|<pageref|auto-62>>

      <tuple|<tuple|capturing>|<pageref|auto-63>>

      <tuple|<tuple|block structure>|<pageref|auto-65>>

      <tuple|<tuple|lexical scoping>|<pageref|auto-66>>

      <tuple|<tuple|local evolution>|<pageref|auto-68>>

      <tuple|<tuple|global>|<pageref|auto-69>>

      <tuple|<tuple|deferred operations>|<pageref|auto-73>>

      <tuple|<tuple|recursive process>|<pageref|auto-74>>

      <tuple|<tuple|linear recursive process>|<pageref|auto-75>>

      <tuple|<tuple|iterative process>|<pageref|auto-76>>

      <tuple|<tuple|state variables>|<pageref|auto-77>>

      <tuple|<tuple|linear iterative process>|<pageref|auto-78>>

      <tuple|<tuple|process>|<pageref|auto-79>>

      <tuple|<tuple|procedure>|<pageref|auto-80>>

      <tuple|<tuple|tail-recursive>|<pageref|auto-81>>

      <tuple|<tuple|tree recursion>|<pageref|auto-83>>

      <tuple|<tuple|golden ratio>|<pageref|auto-85>>

      <tuple|<tuple|tabulation>|<pageref|auto-87>>

      <tuple|<tuple|memoization>|<pageref|auto-88>>

      <tuple|<tuple|Pascal's triangle>|<pageref|auto-89>>

      <tuple|<tuple|binomial coefficients>|<pageref|auto-90>>

      <tuple|<tuple|order of growth>|<pageref|auto-92>>

      <tuple|<tuple|invariant quantity>|<pageref|auto-94>>

      <tuple|<tuple|Euclid's Algorithm>|<pageref|auto-96>>

      <tuple|<tuple|congruent modulo>|<pageref|auto-100>>

      <tuple|<tuple|remainder of>|<pageref|auto-101>>

      <tuple|<tuple|modulo>|<pageref|auto-102>>

      <tuple|<tuple|Carmichael numbers>|<pageref|auto-104>>

      <tuple|<tuple|probabilistic algorithms>|<pageref|auto-105>>

      <tuple|<tuple|RSA algorithm>|<pageref|auto-106>>

      <tuple|<tuple|Miller-Rabin test>|<pageref|auto-107>>

      <tuple|<tuple|higher-order procedures>|<pageref|auto-109>>

      <tuple|<tuple|summation of a series>|<pageref|auto-111>>

      <tuple|<tuple|sequences>|<pageref|auto-112>>

      <tuple|<tuple|filter>|<pageref|auto-113>>

      <tuple|<tuple|half interval method>|<pageref|auto-118>>

      <tuple|<tuple|fixed point>|<pageref|auto-120>>

      <tuple|<tuple|average damping>|<pageref|auto-121>>

      <tuple|<tuple|continued fraction>|<pageref|auto-122>>

      <tuple|<tuple|k-term finite continued fraction>|<pageref|auto-123>>

      <tuple|<tuple|Newton's method>|<pageref|auto-126>>

      <tuple|<tuple|first-class>|<pageref|auto-128>>

      <tuple|<tuple|composition>|<pageref|auto-129>>

      <tuple|<tuple|smoothing>|<pageref|auto-130>>

      <tuple|<tuple|n-fold smoothed function>|<pageref|auto-131>>

      <tuple|<tuple|iterative improvement>|<pageref|auto-132>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Building
      Abstractions with Procedures> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <with|par-left|<quote|4tab>|Programming in Lisp
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9><vspace|0.15fn>>

      1.1<space|2spc>The Elements of Programming
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13>

      <with|par-left|<quote|1tab>|1.1.1<space|2spc>Expressions
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-16>>

      <with|par-left|<quote|1tab>|1.1.2<space|2spc>Naming and the Environment
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-26>>

      <with|par-left|<quote|1tab>|1.1.3<space|2spc>Evaluating Combinations
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-31>>

      <with|par-left|<quote|1tab>|1.1.4<space|2spc>Compound Procedures
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-37>>

      <with|par-left|<quote|1tab>|1.1.5<space|2spc>The Substitution Model for
      Procedure Application <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-40>>

      <with|par-left|<quote|4tab>|Applicative order versus normal order
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-43><vspace|0.15fn>>

      <with|par-left|<quote|1tab>|1.1.6<space|2spc>Conditional Expressions
      and Predicates <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-47>>

      <with|par-left|<quote|1tab>|1.1.7<space|2spc>Example: Square Roots by
      Newton's Method <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-53>>

      <with|par-left|<quote|1tab>|1.1.8<space|2spc>Procedures as Black-Box
      Abstractions <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-54>>

      <with|par-left|<quote|4tab>|Local names
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-58><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|Internal definitions and block structure
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-64><vspace|0.15fn>>

      1.2<space|2spc>Procedures and the Processes They Generate
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-67>

      <with|par-left|<quote|1tab>|1.2.1<space|2spc>Linear Recursion and
      Iteration <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-70>>

      <with|par-left|<quote|1tab>|1.2.2<space|2spc>Tree Recursion
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-82>>

      <with|par-left|<quote|4tab>|Example: Counting change
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-86><vspace|0.15fn>>

      <with|par-left|<quote|1tab>|1.2.3<space|2spc>Orders of Growth
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-91>>

      <with|par-left|<quote|1tab>|1.2.4<space|2spc>Exponentiation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-93>>

      <with|par-left|<quote|1tab>|1.2.5<space|2spc>Greatest Common Divisors
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-95>>

      <with|par-left|<quote|1tab>|1.2.6<space|2spc>Example: Testing for
      Primality <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-97>>

      <with|par-left|<quote|4tab>|Searching for divisors
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-98><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|The Fermat test
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-99><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|Probabilistic methods
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-103><vspace|0.15fn>>

      1.3<space|2spc>Formulating Abstractions with Higher-Order Procedures
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-108>

      <with|par-left|<quote|1tab>|1.3.1<space|2spc>Procedures as Arguments
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-110>>

      <with|par-left|<quote|1tab>|1.3.2<space|2spc>Constructing Procedures
      Using <with|font-family|<quote|tt>|Lambda>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-114>>

      <with|par-left|<quote|4tab>|Using <with|font-family|<quote|tt>|let> to
      create local variables <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-115><vspace|0.15fn>>

      <with|par-left|<quote|1tab>|1.3.3<space|2spc>Procedures as General
      Methods <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-116>>

      <with|par-left|<quote|4tab>|Finding roots of equations by the
      half-interval method <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-117><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|Finding fixed points of functions
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-119><vspace|0.15fn>>

      <with|par-left|<quote|1tab>|1.3.4<space|2spc>Procedures as Returned
      Values <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-124>>

      <with|par-left|<quote|4tab>|Newton's method
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-125><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|Abstractions and first-class procedures
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-127><vspace|0.15fn>>
    </associate>
  </collection>
</auxiliary>