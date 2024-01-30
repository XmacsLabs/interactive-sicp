<TeXmacs|2.1.2>

<style|<tuple|generic|no-page-numbers|british>>

<\body>
  <section|The Elements of Programming><label|1.1>

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
  representing a primitive procedure (such as <scm|+> or <scm|*>) to form a
  compound expression that represents the application of the procedure to
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

  <\scm-code>
    (+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))
  </scm-code>

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
    language, is the source of the quip by <name|Alan Perlis><index|Alan
    Perlis> (paraphrasing Oscar Wilde) that \PLisp programmers know the value
    of everything but the cost of nothing.\Q
  </footnote>

  <subsection|Naming and the Environment>

  A critical aspect of a programming language is the means it provides for
  using names to refer to computational objects. We say that the name
  identifies a <em|variable><index|variable> whose <em|value><index|value> is
  the object.

  In the Scheme dialect of Lisp, we name things with <scm|define>. Typing

  <\session|scheme|default>
    <\input|Scheme] >
      (define size 2)
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  causes the interpreter to associate the value 2 with the name
  <scm|size>.<\footnote>
    In this book, we do not show the interpreter's response to evaluating
    definitions, since this is highly implementation-dependent.
  </footnote> Once the name <scm|size> has been associated with the number 2,
  we can refer to the value 2 by name:

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

  <scm|Define> is our language's simplest means of abstraction, for it allows
  us to use simple names to refer to the results of compound operations, such
  as the <scm|circumference> computed above. In general, computational
  objects may have very complex structures, and it would be extremely
  inconvenient to have to remember and repeat their details each time we want
  to use them. Indeed, complex programs are constructed by building, step by
  step, computational objects of increasing complexity. The interpreter makes
  this step-by-step program construction particularly convenient because
  name-object associations can be created incrementally in successive
  interactions. This feature encourages the incremental development and
  testing of programs and is largely responsible for the fact that a Lisp
  program usually consists of a large number of relatively simple procedures.

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

  <subsection|Evaluating Combinations><label|sec:1.1.3>

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
  combination in the form of a tree, as shown in <smart-ref|fig:1.1>. Each
  combination is represented by a node with branches corresponding to the
  operator and the operands of the combination stemming from it. The terminal
  nodes (that is, nodes with no branches stemming from them) represent either
  operators or numbers. Viewing evaluation in terms of the tree, we can
  imagine that the values of the operands percolate upward, starting from the
  terminal nodes and then combining at higher and higher levels. In general,
  we shall see that recursion is a very powerful technique for dealing with
  hierarchical, treelike objects. In fact, the \Ppercolate values upward\Q
  form of the evaluation rule is an example of a general kind of process
  known as <em|tree accumulation><index|tree accumulation>.

  <\big-figure|<tree|390|*|<tree|26|+|2|<tree|24|*|4|6>>|<tree|15|+|3|5|7>>>
    <label|fig:1.1>Tree representation, showing the value of each
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
  For instance, evaluating <scm|(define x 3)> does not apply <code*|define>
  to two arguments, one of which is the value of the symbol <code*|x> and the
  other of which is 3, since the purpose of the <code*|define> is precisely
  to associate <code*|x> with a value. (That is, <scm|(define x 3)> is not a
  combination.)

  Such exceptions to the general evaluation rule are called <em|special
  forms><index|special forms>. <scm|Define> is the only example of a special
  form that we have seen so far, but we will meet others shortly. Each
  special form has its own evaluation rule. The various kinds of expressions
  (each with its associated evaluation rule) constitute the syntax of the
  programming language. In comparison with most other programming languages,
  Lisp has a very simple syntax; that is, the evaluation rule for expressions
  can be described by a simple general rule together with specialized rules
  for a small number of special forms.<\footnote>
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
    the words of <name|Alan Perlis>, \PSyntactic sugar causes cancer of the
    semicolon.\Q
  </footnote>

  <subsection|Compound Procedures><label|sec:1.1.4>

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
      <label|define_square>(define (square x) (* x x))
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

  The \<langle\><var|name>\<rangle\> is a symbol to be associated with the
  procedure definition in the environment.<\footnote>
    Throughout this book, we will describe the general syntax of expressions
    by using italic symbols delimited by angle brackets\Ve.g.,
    \<langle\><var|name>\<rangle\>\Vto denote the \Pslots\Q in the expression
    to be filled in when such an expression is actually used.
  </footnote> The \<langle\><var|formal parameters>\<rangle\> are the names
  used within the body of the procedure to refer to the corresponding
  arguments of the procedure. The \<langle\><var|body>\<rangle\> is an
  expression that will yield the value of the procedure application when the
  formal parameters are replaced by the actual arguments to which the
  procedure is applied.<hlink||#FOOT14><\footnote>
    More generally, the body of the procedure can be a sequence of
    expressions. In this case, the interpreter evaluates each expression in
    the sequence in turn and returns the value of the final expression as the
    value of the procedure application.
  </footnote> The \<langle\><var|name>\<rangle\> and the
  \<langle\><var|formal parameters>\<rangle\> are grouped within parentheses,
  just as they would be in an actual call to the procedure being defined.

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

  <subsection|The Substitution Model for Procedure
  Application><label|sec:1.1.5>

  To evaluate a combination whose operator names a compound procedure, the
  interpreter follows much the same process as for combinations whose
  operators name primitive procedures, which we described in
  <smart-ref|sec:1.1.3>. That is, the interpreter evaluates the elements of
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

  where <code*|f> is the procedure defined in <smart-ref|sec:1.1.4>. We begin
  by retrieving the body of <code*|f>:

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
  the arguments. Now <scm|(+ 5 1)> produces 6 and <scm|(* 5 2)> produces 10,
  so we must apply the <code*|sum-of-squares> procedure to 6 and 10. These
  values are substituted for the formal parameters <code*|x> and <code*|y> in
  the body of <scm|sum-of-squares>, reducing the expression to

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

  According to the description of evaluation given in <smart-ref|sec:1.1.3>,
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
  process is different. In particular, the evaluations of <scm|(+ 5 1)> and
  <scm|(* 5 2)> are each performed twice here, corresponding to the reduction
  of the expression <code*|(* x x)> with <code*|x> replaced respectively by
  <code*|(+ 5 1)> and <code*|(* 5 2)>.

  This alternative \Pfully expand and then reduce\Q evaluation method is
  known as <em|normal-order evaluation><index|normal order evaluation>, in
  contrast to the \Pevaluate the arguments and then apply\Q method that the
  interpreter actually uses, which is called <em|applicative-order
  evaluation><index|application-order evaluation>. It can be shown that, for
  procedure applications that can be modeled using substitution (including
  all the procedures in the first two chapters of this book) and that yield
  legitimate values, normal-order and applicative-order evaluation produce
  the same value. (See <hlink|Exercise 1.5|#ex1.5> for an instance of an
  \Pillegitimate\Q value where normal-order and applicative-order evaluation
  do not give the same result.)

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

  \;

  <\scm-code>
    (cond (\<langle\><var|p<rsub|1>>\<rangle\>
    \<langle\><var|e<rsub|1>>\<rangle\>)

    \ \ \ \ \ \ (\<langle\><var|p<rsub|2>>\<rangle\>
    \<langle\><var|e<rsub|2>>\<rangle\>)

    \ \ \ \ \ \ ...

    \ \ \ \ \ \ (\<langle\><var|p<rsub| >>\<rangle\> \<langle\><var|e<rsub|
    >>\<rangle\>))
  </scm-code>

  consisting of the symbol <code*|cond> followed by parenthesized pairs of
  expressions

  <code|(\<langle\><var|p>\<rangle\> \<langle\><var|e>\<rangle\>)>

  called <em|clauses><index|clauses>. The first expression in each pair is a
  <em|predicate><index|predicate>\Vthat is, an expression whose value is
  interpreted as either true or false.<\footnote>
    \PInterpreted as either true or false\Q means this: In Scheme, there are
    two distinguished values that are denoted by the constants <scm|#t> and
    <scm|#f>. When the interpreter checks a predicate's value, it interprets
    <scm|#f> as false. Any other value is treated as true. (Thus, providing
    <scm|#t> is logically unnecessary, but it is convenient.) In this book we
    will use names <code*|true> and <code*|false>, which are associated with
    the values <scm|#t> and <scm|#f> respectively.
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
  the \<langle\><var|predicate>\<rangle\> part of the expression. If the
  \<langle\><var|predicate>\<rangle\> evaluates to a true value, the
  interpreter then evaluates the \<langle\><var|consequent>\<rangle\> and
  returns its value. Otherwise it evaluates the
  \<langle\><var|alternative>\<rangle\> and returns its value.<\footnote>
    A minor difference between <code*|if> and <code*|cond> is that the
    \<langle\><var|e>\<rangle\> part of each <code*|cond> clause may be a
    sequence of expressions. If the corresponding \<langle\><var|p>\<rangle\>
    is found to be true, the expressions \<langle\><var|e>\<rangle\> are
    evaluated in sequence and the value of the final expression in the
    sequence is returned as the value of the <code*|cond>. In an <code*|if>
    expression, however, the \<langle\><var|consequent>\<rangle\> and
    \<langle\><var|alternative>\<rangle\> must be single expressions.
  </footnote>

  In addition to primitive predicates such as <code*|\<less\>>, <code*|=>,
  and <code*|\<gtr\>>, there are logical composition operations, which enable
  us to construct compound predicates. The three most frequently used are
  these:

  <\description>
    <item*|(and \<langle\>e<rsub|1>\<rangle\> \<ldots\>
    \<langle\>e<rsub|n>\<rangle\>)>

    The interpreter evaluates the expressions \<langle\><var|e>\<rangle\> one
    at a time, in left-to-right order. If any \<langle\><var|e>\<rangle\>
    evaluates to false, the value of the <code*|and> expression is false, and
    the rest of the \<langle\><var|e>\<rangle\>'s are not evaluated. If all
    \<langle\><var|e>\<rangle\>'s evaluate to true values, the value of the
    <code*|and> expression is the value of the last one.

    <item*|(or \<langle\>e<rsub|1>\<rangle\> \<ldots\>
    \<langle\>e<rsub|n>\<rangle\>)>

    The interpreter evaluates the expressions \<langle\><var|e>\<rangle\> one
    at a time, in left-to-right order. If any \<langle\><var|e>\<rangle\>
    evaluates to a true value, that value is returned as the value of the
    <code*|or> expression, and the rest of the \<langle\><var|e>\<rangle\>'s
    are not evaluated. If all \<langle\><var|e>\<rangle\>'s evaluate to
    false, the value of the <code*|or> expression is false.

    <item*|(not \<langle\>e\<rangle\>)>

    The value of a <code*|not> expression is true when the expression
    \<langle\><var|e>\<rangle\> evaluates to false, and false otherwise.
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
    <label|ex1.5>Ben Bitdiddle has invented a test to determine whether the
    interpreter he is faced with is using applicative-order evaluation or
    normal-order evaluation. He defines the following two procedures:

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

  <subsection|Example: Square Roots by Newton's Method><label|sec:1.1.7>

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
    method as a Lisp procedure in <smart-ref|sec:1.3.4>.
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

  <\session|scheme|default>
    <\input|Scheme] >
      (define (sqrt-iter guess x)

      \ \ (if (good-enough? guess x)

      \ \ \ \ \ \ guess

      \ \ \ \ \ \ (sqrt-iter (improve guess x)

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ x)))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  A guess is improved by averaging it with the quotient of the radicand and
  the old guess:

  <\session|scheme|default>
    <\input|Scheme] >
      (define (improve guess x)

      \ \ (average guess (/ x guess)))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  where

  <\session|scheme|default>
    <\input|Scheme] >
      (define (average x y)

      \ \ (/ (+ x y) 2))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  We also have to say what we mean by \Pgood enough.\Q The following will do
  for illustration, but it is not really a very good test. (See
  <hlink|Exercise 1.7|#ex1.7>.) The idea is to improve the answer until it is
  close enough so that its square differs from the radicand by less than a
  predetermined tolerance (here 0.001):<\footnote>
    We will usually give predicates names ending with question marks, to help
    us remember that they are predicates. This is just a stylistic
    convention. As far as the interpreter is concerned, the question mark is
    just an ordinary character.
  </footnote>

  <\session|scheme|default>
    <\input|Scheme] >
      (define (good-enough? guess x)

      \ \ (\<less\> (abs (- (<hlink|square|#define_square> guess) x)) 0.001))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

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

  <\session|scheme|default>
    <\input|Scheme] >
      (define (sqrt x)

      \ \ (sqrt-iter 1.0 x))
    </input>

    <\input|Scheme] >
      \;
    </input>
  </session>

  If we type these definitions to the interpreter, we can use <code*|sqrt>
  just as we can use any procedure:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (sqrt 9)
    <|unfolded-io>
      3.00009155413138
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (sqrt (+ 100 37))
    <|unfolded-io>
      11.704699917758145
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (sqrt (+ (sqrt 2) (sqrt 3)))
    <|unfolded-io>
      1.7739279023207892
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (square (sqrt 1000))
    <|unfolded-io>
      1000.000369924366
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

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
    <label|ex1.7>The <code*|good-enough?> test used in computing square roots
    will not be very effective for finding the square roots of very small
    numbers. Also, in real computers, arithmetic operations are almost always
    performed with limited precision. This makes our test inadequate for very
    large numbers. Explain these statements, with examples showing how the
    test fails for small and large numbers. An alternative strategy for
    implementing <code*|good-enough?> is to watch how <code*|guess> changes
    from one iteration to the next and to stop when the change is a very
    small fraction of the guess. Design a square-root procedure that uses
    this kind of end test. Does this work better for small and large numbers?
  </exercise>

  <\exercise>
    Newton's method for cube roots is based on the fact that if <math|y> is
    an approximation to the cube root of <math|x>, then a better
    approximation is given by the value <math|<frac|x<around*|/|y<rsup|2>+2*y|\<nobracket\>>|3>>.
    Use this formula to implement a cube-root procedure analogous to the
    square-root procedure. (In <smart-ref|sec:1.3.4> we will see how to
    implement Newton's method in general as an abstraction of these
    square-root and cube-root procedures.)
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
  cluster of procedures (shown in <smart-ref|fig:1.2>) that mirrors the
  decomposition of the problem into subproblems.

  <\big-figure|<tree|sqrt|<tree|sqrt-iter|<tree|good-enough|square|abs>|<tree|improve|average>>>>
    <label|fig:1.2>Procedural decomposition of the <scm|sqrt> program
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
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
    <associate|page-screen-margin|false>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|1.1|<tuple|1|1>>
    <associate|1.1.8|<tuple|1.8|14>>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-10|<tuple|arguments|2>>
    <associate|auto-11|<tuple|prefix notation|2>>
    <associate|auto-12|<tuple|pretty-printing|3>>
    <associate|auto-13|<tuple|read-eval-print loop|3>>
    <associate|auto-14|<tuple|Alan Perlis|3>>
    <associate|auto-15|<tuple|1.2|3>>
    <associate|auto-16|<tuple|variable|3>>
    <associate|auto-17|<tuple|value|3>>
    <associate|auto-18|<tuple|environment|4>>
    <associate|auto-19|<tuple|global environment|4>>
    <associate|auto-2|<tuple|integers|1>>
    <associate|auto-20|<tuple|1.3|4>>
    <associate|auto-21|<tuple|recursive|4>>
    <associate|auto-22|<tuple|tree accumulation|4>>
    <associate|auto-23|<tuple|1|4>>
    <associate|auto-24|<tuple|special forms|5>>
    <associate|auto-25|<tuple|syntactic sugar|5>>
    <associate|auto-26|<tuple|1.4|5>>
    <associate|auto-27|<tuple|procedure definitions|5>>
    <associate|auto-28|<tuple|compound procedure|6>>
    <associate|auto-29|<tuple|1.5|7>>
    <associate|auto-3|<tuple|real numbers|1>>
    <associate|auto-30|<tuple|substitution model|8>>
    <associate|auto-31|<tuple|substitution|8>>
    <associate|auto-32|<tuple|substitution|8>>
    <associate|auto-33|<tuple|normal order evaluation|8>>
    <associate|auto-34|<tuple|application-order evaluation|8>>
    <associate|auto-35|<tuple|stream processing|9>>
    <associate|auto-36|<tuple|1.6|9>>
    <associate|auto-37|<tuple|case analysis|9>>
    <associate|auto-38|<tuple|clauses|9>>
    <associate|auto-39|<tuple|predicate|9>>
    <associate|auto-4|<tuple|1.1|1>>
    <associate|auto-40|<tuple|consequent expression|9>>
    <associate|auto-41|<tuple|predicate|10>>
    <associate|auto-42|<tuple|1.7|12>>
    <associate|auto-43|<tuple|1.8|14>>
    <associate|auto-44|<tuple|recursive|14>>
    <associate|auto-45|<tuple|2|15>>
    <associate|auto-46|<tuple|procedural abstraction|15>>
    <associate|auto-47|<tuple|22|15>>
    <associate|auto-48|<tuple|bound variable|16>>
    <associate|auto-49|<tuple|binds|16>>
    <associate|auto-5|<tuple|expression|1>>
    <associate|auto-50|<tuple|free|16>>
    <associate|auto-51|<tuple|scope|16>>
    <associate|auto-52|<tuple|capturing|16>>
    <associate|auto-53|<tuple|capturing|16>>
    <associate|auto-54|<tuple|block structure|17>>
    <associate|auto-55|<tuple|lexical scoping|17>>
    <associate|auto-6|<tuple|evaluating|1>>
    <associate|auto-7|<tuple|combinations|2>>
    <associate|auto-8|<tuple|operator|2>>
    <associate|auto-9|<tuple|operands|2>>
    <associate|define_square|<tuple|procedure definitions|6>>
    <associate|ex1.5|<tuple|5|11>>
    <associate|ex1.7|<tuple|7|14>>
    <associate|fig:1.1|<tuple|1|4>>
    <associate|fig:1.2|<tuple|2|15>>
    <associate|footnote-1|<tuple|1|1>>
    <associate|footnote-10|<tuple|10|6>>
    <associate|footnote-11|<tuple|11|6>>
    <associate|footnote-12|<tuple|12|8>>
    <associate|footnote-13|<tuple|13|9>>
    <associate|footnote-14|<tuple|14|9>>
    <associate|footnote-15|<tuple|15|10>>
    <associate|footnote-16|<tuple|16|10>>
    <associate|footnote-17|<tuple|17|12>>
    <associate|footnote-18|<tuple|18|12>>
    <associate|footnote-19|<tuple|19|13>>
    <associate|footnote-2|<tuple|2|1>>
    <associate|footnote-20|<tuple|20|13>>
    <associate|footnote-21|<tuple|21|14>>
    <associate|footnote-22|<tuple|22|15>>
    <associate|footnote-23|<tuple|23|16>>
    <associate|footnote-24|<tuple|24|17>>
    <associate|footnote-25|<tuple|25|17>>
    <associate|footnote-3|<tuple|3|3>>
    <associate|footnote-4|<tuple|4|3>>
    <associate|footnote-5|<tuple|5|3>>
    <associate|footnote-6|<tuple|6|4>>
    <associate|footnote-7|<tuple|7|4>>
    <associate|footnote-8|<tuple|8|5>>
    <associate|footnote-9|<tuple|9|6>>
    <associate|footnr-1|<tuple|real numbers|1>>
    <associate|footnr-10|<tuple|10|6>>
    <associate|footnr-11|<tuple|11|6>>
    <associate|footnr-12|<tuple|substitution|8>>
    <associate|footnr-13|<tuple|stream processing|9>>
    <associate|footnr-14|<tuple|14|9>>
    <associate|footnr-15|<tuple|15|10>>
    <associate|footnr-16|<tuple|16|10>>
    <associate|footnr-17|<tuple|17|12>>
    <associate|footnr-18|<tuple|18|12>>
    <associate|footnr-19|<tuple|19|13>>
    <associate|footnr-2|<tuple|2|1>>
    <associate|footnr-20|<tuple|20|13>>
    <associate|footnr-21|<tuple|21|14>>
    <associate|footnr-22|<tuple|22|15>>
    <associate|footnr-23|<tuple|23|16>>
    <associate|footnr-24|<tuple|24|17>>
    <associate|footnr-25|<tuple|25|17>>
    <associate|footnr-3|<tuple|3|3>>
    <associate|footnr-4|<tuple|Alan Perlis|3>>
    <associate|footnr-5|<tuple|5|3>>
    <associate|footnr-6|<tuple|6|4>>
    <associate|footnr-7|<tuple|7|4>>
    <associate|footnr-8|<tuple|syntactic sugar|5>>
    <associate|footnr-9|<tuple|9|6>>
    <associate|sec:1.1.3|<tuple|1.3|4>>
    <associate|sec:1.1.4|<tuple|1.4|5>>
    <associate|sec:1.1.5|<tuple|1.5|7>>
    <associate|sec:1.1.7|<tuple|1.7|12>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1>|>
        Tree representation, showing the value of each subcombination.
      </surround>|<pageref|auto-23>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2>|>
        Procedural decomposition of the <with|mode|<quote|prog>|prog-language|<quote|scheme>|font-family|<quote|rm>|sqrt>
        program
      </surround>|<pageref|auto-45>>
    </associate>
    <\associate|idx>
      <tuple|<tuple|integers>|<pageref|auto-2>>

      <tuple|<tuple|real numbers>|<pageref|auto-3>>

      <tuple|<tuple|expression>|<pageref|auto-5>>

      <tuple|<tuple|evaluating>|<pageref|auto-6>>

      <tuple|<tuple|combinations>|<pageref|auto-7>>

      <tuple|<tuple|operator>|<pageref|auto-8>>

      <tuple|<tuple|operands>|<pageref|auto-9>>

      <tuple|<tuple|arguments>|<pageref|auto-10>>

      <tuple|<tuple|prefix notation>|<pageref|auto-11>>

      <tuple|<tuple|pretty-printing>|<pageref|auto-12>>

      <tuple|<tuple|read-eval-print loop>|<pageref|auto-13>>

      <tuple|<tuple|Alan Perlis>|<pageref|auto-14>>

      <tuple|<tuple|variable>|<pageref|auto-16>>

      <tuple|<tuple|value>|<pageref|auto-17>>

      <tuple|<tuple|environment>|<pageref|auto-18>>

      <tuple|<tuple|global environment>|<pageref|auto-19>>

      <tuple|<tuple|recursive>|<pageref|auto-21>>

      <tuple|<tuple|tree accumulation>|<pageref|auto-22>>

      <tuple|<tuple|special forms>|<pageref|auto-24>>

      <tuple|<tuple|syntactic sugar>|<pageref|auto-25>>

      <tuple|<tuple|procedure definitions>|<pageref|auto-27>>

      <tuple|<tuple|compound procedure>|<pageref|auto-28>>

      <tuple|<tuple|substitution model>|<pageref|auto-30>>

      <tuple|<tuple|substitution>|<pageref|auto-31>>

      <tuple|<tuple|normal order evaluation>|<pageref|auto-33>>

      <tuple|<tuple|application-order evaluation>|<pageref|auto-34>>

      <tuple|<tuple|stream processing>|<pageref|auto-35>>

      <tuple|<tuple|case analysis>|<pageref|auto-37>>

      <tuple|<tuple|clauses>|<pageref|auto-38>>

      <tuple|<tuple|predicate>|<pageref|auto-39>>

      <tuple|<tuple|consequent expression>|<pageref|auto-40>>

      <tuple|<tuple|predicate>|<pageref|auto-41>>

      <tuple|<tuple|recursive>|<pageref|auto-44>>

      <tuple|<tuple|procedural abstraction>|<pageref|auto-46>>

      <tuple|<tuple|bound variable>|<pageref|auto-48>>

      <tuple|<tuple|binds>|<pageref|auto-49>>

      <tuple|<tuple|free>|<pageref|auto-50>>

      <tuple|<tuple|scope>|<pageref|auto-51>>

      <tuple|<tuple|capturing>|<pageref|auto-52>>

      <tuple|<tuple|block structure>|<pageref|auto-54>>

      <tuple|<tuple|lexical scoping>|<pageref|auto-55>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>The
      Elements of Programming> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <with|par-left|<quote|1tab>|1.1<space|2spc>Expressions
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>>

      <with|par-left|<quote|1tab>|1.2<space|2spc>Naming and the Environment
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-15>>

      <with|par-left|<quote|1tab>|1.3<space|2spc>Evaluating Combinations
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-20>>

      <with|par-left|<quote|1tab>|1.4<space|2spc>Compound Procedures
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-26>>

      <with|par-left|<quote|1tab>|1.5<space|2spc>The Substitution Model for
      Procedure Application <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-29>>

      <with|par-left|<quote|3tab>|Applicative order versus normal order
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-32>>

      <with|par-left|<quote|1tab>|1.6<space|2spc>Conditional Expressions and
      Predicates <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-36>>

      <with|par-left|<quote|1tab>|1.7<space|2spc>Example: Square Roots by
      Newton's Method <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-42>>

      <with|par-left|<quote|1tab>|1.8<space|2spc>Procedures as Black-Box
      Abstractions <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-43>>

      <with|par-left|<quote|3tab>|Local names
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-47>>

      <with|par-left|<quote|3tab>|Internal definitions and block structure
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-53>>
    </associate>
  </collection>
</auxiliary>