<TeXmacs|2.1.2>

<style|<tuple|book|no-page-numbers|british|smart-ref|preview-ref>>

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
  <em|expression><glossary-explain|expression|\<#8868\>\<#8FBE\>\<#5F0F\>\V\V\<#539F\>\<#8BED\>\<#6216\>\<#8005\>\<#7EC4\>\<#5408\>\<#5F0F\>>,
  and the interpreter responds by displaying the result of its
  <em|evaluating><index|evaluating> that expression.

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
  <em|combinations><glossary-explain|combinations|\<#7EC4\>\<#5408\>\<#5F0F\>>.
  The leftmost element in the list is called the
  <em|operator><glossary-explain|operator|\<#64CD\>\<#4F5C\>\<#7B26\>>, and
  the other elements are called <em|operands><glossary-explain|operands|\<#64CD\>\<#4F5C\>\<#6570\>>.
  The value of a combination is obtained by applying the procedure specified
  by the operator to the <em|arguments><glossary-explain|arguments|\<#53C2\>\<#6570\>>
  that are the values of the operands.

  The convention of placing the operator to the left of the operands is known
  as <em|prefix notation><glossary-explain|prefix
  notation|\<#524D\>\<#7F00\>\<#8868\>\<#793A\>\<#6CD5\>>, and it may be
  somewhat confusing at first because it departs significantly from the
  customary mathematical convention. Prefix notation has several advantages,
  however. One of them is that it can accommodate procedures that may take an
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
  identifies a <em|variable><glossary-explain|variable|\<#53D8\>\<#91CF\>>
  whose <em|value><glossary-explain|value|\<#503C\>> is the object.

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
    Chapter 3 will show that this notion of environment is crucial, both for
    understanding how the interpreter works and for implementing
    interpreters.
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
  shall see in Chapter 3, the general notion of the environment as providing
  a context in which evaluation takes place will play an important role in
  our understanding of program execution.

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
    sometimes called <em|syntactic sugar><glossary-explain|syntactic
    sugar|\<#8BED\>\<#6CD5\>\<#7CD6\>>, to use a phrase coined by Peter
    Landin. In comparison with users of other languages, Lisp programmers, as
    a rule, are less concerned with matters of syntax. (By contrast, examine
    any Pascal manual and notice how much of it is devoted to descriptions of
    syntax.) This disdain for syntax is due partly to the flexibility of
    Lisp, which makes it easy to change surface syntax, and partly to the
    observation that many \Pconvenient\Q syntactic constructs, which make the
    language less uniform, end up causing more trouble than they are worth
    when programs become large and complex. In the words of <name|Alan
    Perlis>, \PSyntactic sugar causes cancer of the semicolon.\Q
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

  We have here a <em|compound procedure><glossary-explain|compound
  procedure|\<#590D\>\<#5408\>\<#51FD\>\<#6570\>>, which has been given the
  name <code*|square>. The procedure represents the operation of multiplying
  something by itself. The thing to be multiplied is given a local name,
  <code*|x>, which plays the same role that a pronoun plays in natural
  language. Evaluating the definition creates this compound procedure and
  associates it with the name <code*|square>.<\footnote>
    Observe that there are two different operations being combined here: we
    are creating the procedure, and we are giving it the name <code*|square>.
    It is possible, indeed important, to be able to separate these two
    notions\Vto create procedures without naming them, and to give names to
    procedures that have already been created. We will see how to do this in
    <smart-ref|sec:1.3.2>.
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
  procedure is applied.<\footnote>
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
  model><glossary-explain|substitution model|\<#4EE3\>\<#6362\>\<#6A21\>\<#578B\>>
  for procedure application. It can be taken as a model that determines the
  \Pmeaning\Q of procedure application, insofar as the procedures in this
  chapter are concerned. However, there are two points that should be
  stressed:

  <\itemize>
    <item>The purpose of the substitution is to help us think about procedure
    application, not to provide a description of how the interpreter really
    works. Typical interpreters do not evaluate procedure applications by
    manipulating the text of a procedure to substitute values for the formal
    parameters. In practice, the \Psubstitution\Q is accomplished by using a
    local environment for the formal parameters. We will discuss this more
    fully in Chapter 3 and Chapter 4 when we examine the implementation of an
    interpreter in detail.

    <item>Over the course of this book, we will present a sequence of
    increasingly elaborate models of how interpreters work, culminating with
    a complete implementation of an interpreter and compiler in Chapter 5.
    The substitution model is only the first of these models\Va way to get
    started thinking formally about the evaluation process. In general, when
    modeling phenomena in science and engineering, we begin with simplified,
    incomplete models. As we examine things in greater detail, these simple
    models become inadequate and must be replaced by more refined models. The
    substitution model is no exception. In particular, when we address in
    Chapter 3 the use of procedures with \Pmutable data,\Q we will see that
    the substitution model breaks down and must be replaced by a more
    complicated model of procedure application.<\footnote>
      Despite the simplicity of the substitution idea, it turns out to be
      surprisingly complicated to give a rigorous mathematical definition of
      the substitution process. The problem arises from the possibility of
      confusion between the names used for the formal parameters of a
      procedure and the (possibly identical) names used in the expressions to
      which the procedure may be applied. Indeed, there is a long history of
      erroneous definitions of <em|substitution><index|substitution> in the
      literature of logic and programming semantics. See Stoy 1977 for a
      careful discussion of substitution.
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
  evaluation. If we used this method, the evaluation of <scm|(f 5)> would
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
  known as <em|normal-order evaluation><glossary-explain|normal-order
  evaluation|\<#6B63\>\<#5219\>\<#5E8F\>\<#6C42\>\<#503C\>>, in contrast to
  the \Pevaluate the arguments and then apply\Q method that the interpreter
  actually uses, which is called <em|applicative-order
  evaluation><glossary-explain|applicative-order
  evaluation|\<#5E94\>\<#7528\>\<#5E8F\>\<#6C42\>\<#503C\>>. It can be shown
  that, for procedure applications that can be modeled using substitution
  (including all the procedures in the first two chapters of this book) and
  that yield legitimate values, normal-order and applicative-order evaluation
  produce the same value. (See Exercise <reference|ex1.5> for an instance of
  an \Pillegitimate\Q value where normal-order and applicative-order
  evaluation do not give the same result.)

  Lisp uses applicative-order evaluation, partly because of the additional
  efficiency obtained from avoiding multiple evaluations of expressions such
  as those illustrated with <code*|(+ 5 1)> and <code*|(* 5 2)> above and,
  more significantly, because normal-order evaluation becomes much more
  complicated to deal with when we leave the realm of procedures that can be
  modeled by substitution. On the other hand, normal-order evaluation can be
  an extremely valuable tool, and we will investigate some of its
  implications in Chapter 3 and Chapter 4.<\footnote>
    In Chapter 3 we will introduce <em|stream processing><index|stream
    processing>, which is a way of handling apparently \Pinfinite\Q data
    structures by incorporating a limited form of normal-order evaluation. In
    4.2 we will modify the Scheme interpreter to produce a normal-order
    variant of Scheme.
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
  <em|predicate><glossary-explain|predicate|\<#8C13\>\<#8BCD\>\V\V\<#4E00\>\<#79CD\>\<#503C\>\<#4E3A\>\<#771F\>\<#6216\>\<#8005\>\<#5047\>\<#7684\>\<#8868\>\<#8FBE\>\<#5F0F\>>\Vthat
  is, an expression whose value is interpreted as either true or
  false.<\footnote>
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
    We shall revisit this idea in Chapter 4.
  </footnote>

  How does one compute square roots? The most common way is to use Newton's
  method of successive approximations, which says that whenever we have a
  guess <math|y> for the value of the square root of a number <math|x>, we
  can perform a simple manipulation to get a better guess (one closer to the
  actual square root) by averaging <math|y> with
  <math|x<around*|/|y|\<nobracket\>>>.<\footnote>
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
  for illustration, but it is not really a very good test. (See Exercise
  <reference|ex1.7>.) The idea is to improve the answer until it is close
  enough so that its square differs from the radicand by less than a
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
    on rational numbers in <smart-ref|sec:2.1.1>.) If we start with an
    initial guess of 1 in our square-root program, and <math|x> is an exact
    integer, all subsequent values produced in the square-root computation
    will be rational numbers rather than decimals. Mixed operations on
    rational numbers and decimals always yield decimals, so starting with an
    initial guess of 1.0 forces all subsequent values to be decimals.
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
    recursion\Q in <smart-ref|sec:1.2.1>.
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
  <smart-ref|sec:1.2>. But first let's consider some other important points
  illustrated by the <code*|sqrt> example.

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

  <section|Procedures and the Processes They Generate><label|sec:1.2>

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

  A procedure is a pattern for the <em|local
  evolution><glossary-explain|local evolution|\<#5C40\>\<#90E8\>\<#6F14\>\<#5316\>>
  of a computational process. It specifies how each stage of the process is
  built upon the previous stage. We would like to be able to make statements
  about the overall, or <em|global><index|global>, behavior of a process
  whose local evolution has been specified by a procedure. This is very
  difficult to do in general, but we can at least try to describe some
  typical patterns of process evolution.

  In this section we will examine some common \Pshapes\Q for processes
  generated by simple procedures. We will also investigate the rates at which
  these processes consume the important computational resources of time and
  space. The procedures we will consider are very simple. Their role is like
  that played by test patterns in photography: as oversimplified prototypical
  patterns, rather than practical examples in their own right.

  <subsection|Linear Recursion and Iteration><label|sec:1.2.1>

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

  We can use the substitution model of <smart-ref|sec:1.1.5> to watch this
  procedure in action computing 6!, as shown in <smart-ref|fig:1.3>.

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
    <label|fig:1.3>A linear recursive process for computing 6!.
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
  computing 6!, as shown in <smart-ref|fig:1.4>.

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
    <label|fig:1.4>A linear iterative process for computing 6!.
  </big-figure>

  Compare the two processes. From one point of view, they seem hardly
  different at all. Both compute the same mathematical function on the same
  domain, and each requires a number of steps proportional to <math|n> to
  compute <math|n>!. Indeed, both processes even carry out the same sequence
  of multiplications, obtaining the same sequence of partial products. On the
  other hand, when we consider the \Pshapes\Q of the two processes, we find
  that they evolve quite differently.

  Consider the first process. The substitution model reveals a shape of
  expansion followed by contraction, indicated by the arrow in
  <smart-ref|fig:1.3>. The expansion occurs as the process builds up a chain
  of <em|deferred operations><glossary-explain|deferred
  operations|\<#63A8\>\<#8FDF\>\<#8FDB\>\<#884C\>\<#7684\>\<#64CD\>\<#4F5C\>>
  (in this case, a chain of multiplications). The contraction occurs as the
  operations are actually performed. This type of process, characterized by a
  chain of deferred operations, is called a <em|recursive
  process><glossary-explain|recursive process|\<#9012\>\<#5F52\>\<#8BA1\>\<#7B97\>\<#8FC7\>\<#7A0B\>>.
  Carrying out this process requires that the interpreter keep track of the
  operations to be performed later on. In the computation of <math|n>!, the
  length of the chain of deferred multiplications, and hence the amount of
  information needed to keep track of it, grows linearly with <math|n> (is
  proportional to <math|n>), just like the number of steps. Such a process is
  called a <em|linear recursive process><glossary-explain|linear recursive
  process|\<#7EBF\>\<#6027\>\<#9012\>\<#5F52\>\<#8FC7\>\<#7A0B\>>.

  By contrast, the second process does not grow and shrink. At each step, all
  we need to keep track of, for any <math|n>, are the current values of the
  variables <code*|product>, <code*|counter>, and <code*|max-count>. We call
  this an <em|iterative process><glossary-explain|iterative
  process|\<#8FED\>\<#4EE3\>\<#8BA1\>\<#7B97\>\<#8FC7\>\<#7A0B\>>. In
  general, an iterative process is one whose state can be summarized by a
  fixed number of <em|state variables><glossary-explain|state
  variables|\<#72B6\>\<#6001\>\<#53D8\>\<#91CF\>>, together with a fixed rule
  that describes how the state variables should be updated as the process
  moves from state to state and an (optional) end test that specifies
  conditions under which the process should terminate. In computing
  <math|n>!, the number of steps required grows linearly with <math|n>. Such
  a process is called a <em|linear iterative process><glossary-explain|linear
  iterative process|\<#7EBF\>\<#6027\>\<#8FED\>\<#4EE3\>\<#8FC7\>\<#7A0B\>>.

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
    Chapter 5, we will see that any iterative process can be realized \Pin
    hardware\Q as a machine that has a fixed set of registers and no
    auxiliary memory. In contrast, realizing a recursive process requires a
    machine that uses an auxiliary data structure known as a
    <label|index-stack> <em|stack>.
  </footnote>

  In contrasting iteration and recursion, we must be careful not to confuse
  the notion of a <em|recursive process><glossary-dup|recursive process> with
  the notion of a <em|recursive procedure><glossary-explain|recursive
  procedure|\<#9012\>\<#5F52\>\<#8FC7\>\<#7A0B\>>. When we describe a
  procedure as recursive, we are referring to the syntactic fact that the
  procedure definition refers (either directly or indirectly) to the
  procedure itself. But when we describe a process as following a pattern
  that is, say, linearly recursive, we are speaking about how the process
  evolves, not about the syntax of how a procedure is written. It may seem
  disturbing that we refer to a recursive procedure such as <code*|fact-iter>
  as generating an iterative process. However, the process really is
  iterative: Its state is captured completely by its three state variables,
  and an interpreter need keep track of only three variables in order to
  execute the process.

  One reason that the distinction between process and procedure may be
  confusing is that most implementations of common languages (including Ada,
  Pascal, and C) are designed in such a way that the interpretation of any
  recursive procedure consumes an amount of memory that grows with the number
  of procedure calls, even when the process described is, in principle,
  iterative. As a consequence, these languages can describe iterative
  processes only by resorting to special-purpose \Plooping constructs\Q such
  as <code*|do>, <code*|repeat>, <code*|until>, <code*|for>, and
  <code*|while>. The implementation of Scheme we shall consider in Chapter 5
  does not share this defect. It will execute an iterative process in
  constant space, even if the iterative process is described by a recursive
  procedure. An implementation with this property is called
  <em|tail-recursive><glossary-explain|tail-recursive|\<#5C3E\>\<#9012\>\<#5F52\>>.
  With a tail-recursive implementation, iteration can be expressed using the
  ordinary procedure call mechanism, so that special iteration constructs are
  useful only as <em|syntactic sugar><glossary-explain|syntactic
  sugar|\<#8BED\>\<#6CD5\>\<#7CD6\>\<#8863\>>.<\footnote>
    Tail recursion has long been known as a compiler optimization trick. A
    coherent semantic basis for tail recursion was provided by Carl Hewitt
    (1977), who explained it in terms of the \Pmessage-passing\Q model of
    computation that we shall discuss in Chapter 3. Inspired by this, Gerald
    Jay Sussman and Guy Lewis Steele Jr. (see Steele and Sussman 1975)
    constructed a tail-recursive interpreter for Scheme. Steele later showed
    how tail recursion is a consequence of the natural way to compile
    procedure calls (Steele 1977). The <abbr|IEEE> standard for Scheme
    requires that Scheme implementations be tail-recursive.
  </footnote>

  <\exercise>
    Each of the following two procedures defines a method for adding two
    positive integers in terms of the procedures <code*|inc>, which
    increments its argument by 1, and <code*|dec>, which decrements its
    argument by 1.

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
  </exercise>

  <\exercise>
    The following procedure computes a mathematical function called
    Ackermann's function.

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

      (A 2 4)

      (A 3 3)
    </scm-code>

    Consider the following procedures, where <code*|A> is the procedure
    defined above:

    <\scm-code>
      (define (f n) (A 0 n))

      (define (g n) (A 1 n))

      (define (h n) (A 2 n))

      (define (k n) (* 5 n n))
    </scm-code>

    Give concise mathematical definitions for the functions computed by the
    procedures <code*|f>, <code*|g>, and <code*|h> for positive integer
    values of <math|n>. For example, <code*|(k n)> computes
    <math|5*n<rsup|2>>.
  </exercise>

  <subsection|Tree Recursion><label|sec:1.2.2>

  Another common pattern of computation is called <em|tree
  recursion><glossary-explain|tree recursion|\<#6811\>\<#5F62\>\<#9012\>\<#5F52\>>.
  As an example, consider computing the sequence of Fibonacci
  numbers<glossary-explain|Fibonacci numbers|\<#6590\>\<#6CE2\>\<#90A3\>\<#5951\>\<#6570\>>,
  in which each number is the sum of the preceding two:

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
  1|1>|<tree|fib 0|0>>|<tree|fib 1|1>>|<tree|fib 2|<tree|fib 1|1>|<tree|fib
  0|0>>>|<tree|fib 3|<tree|fib 2|<tree|fib 1|1>|<tree|fib 0|0>>|<tree|fib
  1|1>>>>
    <label|fig:1.5>The tree-recursive process generated in computing
    <scm|(fib 5)>.
  </big-figure>

  Consider the pattern of this computation. To compute <code*|(fib 5)>, we
  compute <code*|(fib 4)> and <code*|(fib 3)>. To compute <code*|(fib 4)>, we
  compute <code*|(fib 3)> and <code*|(fib 2)>. In general, the evolved
  process looks like a tree, as shown in <smart-ref|fig:1.5>. Notice that the
  branches split into two at each level (except at the bottom); this reflects
  the fact that the <code*|fib> procedure calls itself twice each time it is
  invoked.

  This procedure is instructive as a prototypical tree recursion, but it is a
  terrible way to compute Fibonacci numbers because it does so much redundant
  computation. Notice in <smart-ref|fig:1.5> that the entire computation of
  <scm|(fib 3)>\Valmost half the work\Vis duplicated. In fact, it is not hard
  to show that the number of times the procedure will compute <scm|(fib 1)>
  or <scm|(fib 0)> (the number of leaves in the above tree, in general) is
  precisely <math|<with|mode|text|Fib><around*|(|n+1|)>>. To get an idea of
  how bad this is, one can show that the value of
  <math|<with|mode|text|Fib><around*|(|n|)>> grows exponentially with
  <math|n>. More precisely (see Exercise <reference|ex1.13>),
  <math|<with|mode|text|Fib><around*|(|n|)>> is the closest integer to
  <math|\<varphi\><rsup|n><around*|/|<sqrt|5>|\<nobracket\>>>, where
  <math|\<varphi\>=<frac|1+<sqrt|5>|2>\<approx\>1.6180> is the <em|golden
  ratio><glossary-explain|golden ratio|\<#9EC4\>\<#91D1\>\<#6BD4\>\<#4F8B\>>,
  which satisfies the equation <math|\<varphi\><rsup|2>=\<varphi\>+1>. Thus,
  the process uses a number of steps that grows exponentially with the input.
  On the other hand, the space required grows only linearly with the input,
  because we need keep track only of which nodes are above us in the tree at
  any point in the computation. In general, the number of steps required by a
  tree-recursive process will be proportional to the number of nodes in the
  tree, while the space required will be proportional to the maximum depth of
  the tree.

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
  natural and powerful tool.<\footnote>
    An example of this was hinted at in <smart-ref|sec:1.1.3>. The
    interpreter itself evaluates expressions using a tree-recursive process.
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

  <scm|Count-change> generates a tree-recursive process with redundancies
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
    known as <em|tabulation><glossary-explain|tabulation|\<#8868\>\<#683C\>\<#6280\>\<#672F\>>
    or <em|memoization><glossary-explain|memoization|\<#8BB0\>\<#5FC6\>\<#6280\>\<#672F\>>,
    can be implemented in a straightforward way. Tabulation can sometimes be
    used to transform processes that require an exponential number of steps
    (such as <code*|count-change>) into processes whose space and time
    requirements grow linearly with the input. See Exercise 3.27.
  </footnote>

  <\exercise>
    A function <math|f> is defined by the rule that <math|f<around*|(|n|)>=n>
    if <math|n\<less\>3> and <math|f<around*|(|n|)>=f<around*|(|n-1|)>+2*f<around*|(|n-2|)>+3*f<around*|(|n-3|)>>
    if <math|n\<geq\>3>. Write a procedure that computes <math|f> by means of
    a recursive process. Write a procedure that computes <math|f> by means of
    an iterative process.
  </exercise>

  <\exercise>
    The following pattern of numbers is called <em|Pascal's
    triangle><glossary-explain|Pascal's triangle|\<#5E15\>\<#65AF\>\<#5361\>\<#4E09\>\<#89D2\>\<#5F62\>>.

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
      coefficients><glossary-explain|binomial
      coefficients|\<#4E8C\>\<#9879\>\<#5F0F\>\<#7CFB\>\<#6570\>>, because
      the <math|n<rsup|<with|mode|text|th>>> row consists of the coefficients
      of the terms in the expansion of <math|<around*|(|x+y|)><rsup|n>>. This
      pattern for computing the coefficients appeared in Blaise Pascal's 1653
      seminal work on probability theory, <em|Traité du triangle
      arithmétique>. According to Knuth (1973), the same pattern appears in
      the <em|Szu-yuen Yü-chien> (\PThe Precious Mirror of the Four
      Elements\Q), published by the Chinese mathematician Chu Shih-chieh in
      1303, in the works of the twelfth-century Persian poet and
      mathematician Omar Khayyam, and in the works of the twelfth-century
      Hindu mathematician Bháscara Áchárya.
    </footnote> Write a procedure that computes elements of Pascal's triangle
    by means of a recursive process.
  </exercise>

  <\exercise>
    <label|ex1.13>Prove that <math|<with|mode|text|Fib><around*|(|n|)>> is
    the closest integer to <math|\<varphi\><rsup|n><around*|/|<sqrt|5>|\<nobracket\>>>,
    where <math|\<varphi\>=<around*|(|1+<sqrt|5>|)><around*|/|2|\<nobracket\>>>.
    Hint: Let <math|\<psi\>=<around*|(|1-<sqrt|5>|)><around*|/|2|\<nobracket\>>>.
    Use induction and the definition of the Fibonacci numbers (see
    <smart-ref|sec:1.2.2>) to prove that <math|<with|mode|text|Fib><around*|(|n|)>=<around*|(|\<varphi\><rsup|n>-\<psi\><rsup|n>|)><around*|/|<sqrt|5>|\<nobracket\>>>.
  </exercise>

  <subsection|Orders of Growth>

  The previous examples illustrate that processes can differ considerably in
  the rates at which they consume computational resources. One convenient way
  to describe this difference is to use the notion of <em|order of
  growth><glossary-explain|order of growth|\<#589E\>\<#957F\>\<#7684\>\<#9636\>>
  to obtain a gross measure of the resources required by a process as the
  inputs become larger.

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
  described in <smart-ref|sec:1.2.1> the number of steps grows proportionally
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
  ratio described in <smart-ref|sec:1.2.2>.

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
  constant factor. In the remainder of <smart-ref|%_idx_90> we will examine
  two algorithms whose order of growth is logarithmic, so that doubling the
  problem size increases the resource requirement by a constant amount.

  <\exercise>
    Draw the tree illustrating the process generated by the
    <code*|count-change> procedure of <smart-ref|sec:1.2.2> in making change
    for 11 cents. What are the orders of growth of the space and number of
    steps used by this process as the amount to be changed increases?
  </exercise>

  <\exercise>
    The sine of an angle (specified in radians) can be computed by making use
    of the approximation <math|sin\<nospace\>x\<approx\>x> if <math|x> is
    sufficiently small, and the trigonometric identity
    <math|sin\<nospace\>x=3 sin\<nospace\><frac|x|3>-4
    sin<rsup|3>\<nospace\><frac|x|3>> to reduce the size of the argument of
    sin. (For purposes of this exercise an angle is considered \Psufficiently
    small\Q if its magnitude is not greater than 0.1 radians.) These ideas
    are incorporated in the following procedures:

    <\scm-code>
      (define (cube x) (* x x x))

      (define (p x) (- (* 3 x) (* 4 (cube x))))

      (define (sine angle)

      \ \ \ (if (not (\<gtr\> (abs angle) 0.1))

      \ \ \ \ \ \ \ angle

      \ \ \ \ \ \ \ (p (sine (/ angle 3.0)))))
    </scm-code>

    <\enumerate-alpha>
      <item>How many times is the procedure <code*|p> applied when
      <code*|(sine 12.15)> is evaluated?

      <item>What is the order of growth in space and number of steps (as a
      function of <math|a>) used by the process generated by the <code*|sine>
      procedure when <code*|(sine a)> is evaluated?
    </enumerate-alpha>
  </exercise>

  <subsection|Exponentiation><label|sec:1.2.4>

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
    You may wonder wh anyone would care about raising numbers to the 1000th
    power. See <smart-ref|sec:1.2.6>.
  </footnote> It is also possible to use the idea of successive squaring to
  devise an iterative algorithm that computes exponentials with a logarithmic
  number of steps (see Exercise <reference|ex1.16>), although, as is often
  the case with iterative algorithms, this is not written down so
  straightforwardly as the recursive algorithm.<\footnote>
    This iterative algorithm is ancient. It appears in the <em|Chandah-sutra>
    by <name|Áchárya Pingala><index|Áchárya Pingala>, written before 200
    <abbr|B.C.> See Knuth 1981, section 4.6.3, for a full discussion and
    analysis of this and other methods of exponentiation.
  </footnote>

  <\exercise>
    <label|ex1.16>Design a procedure that evolves an iterative exponentiation
    process that uses successive squaring and uses a logarithmic number of
    steps, as does <code*|fast-expt>. (Hint: Using the observation that
    <math|<around*|(|b<rsup|n<around*|/|2|\<nobracket\>>>|)><rsup|2>=<around*|(|b<rsup|2>|)><rsup|n<around*|/|2|\<nobracket\>>>>,
    keep, along with the exponent <math|n> and the base <math|b>, an
    additional state variable <math|a>, and define the state transformation
    in such a way that the product <math|ab<rsup|n>> is unchanged from state
    to state. At the beginning of the process <math|a> is taken to be 1, and
    the answer is given by the value of <math|a> at the end of the process.
    In general, the technique of defining an <label|index-invariant-quantity>
    <em|invariant quantity><index|invariant quantity> that remains unchanged
    from state to state is a powerful way to think about the design of
    iterative algorithms.)
  </exercise>

  <\exercise>
    <label|ex1.17>The exponentiation algorithms in this section are based on
    performing exponentiation by means of repeated multiplication. In a
    similar way, one can perform integer multiplication by means of repeated
    addition. The following multiplication procedure (in which it is assumed
    that our language can only add, not multiply) is analogous to the
    <code*|expt> procedure:

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
  </exercise>

  <\exercise>
    <label|ex1.18>Using the results of Exercise <reference|ex1.16> and
    Exercise <reference|ex1.17>, devise a procedure that generates an
    iterative process for multiplying two integers in terms of adding,
    doubling, and halving and uses a logarithmic number of steps.<\footnote>
      This algorithm, which is sometimes known as the \PRussian peasant
      method\Q of multiplication, is ancient. Examples of its use are found
      in the Rhind Papyrus, one of the two oldest mathematical documents in
      existence, written about 1700 <abbr|B.C.> (and copied from an even
      older document) by an Egyptian scribe named A'h-mose.
    </footnote>
  </exercise>

  <\exercise>
    There is a clever algorithm for computing the Fibonacci numbers in a
    logarithmic number of steps. Recall the transformation of the state
    variables <math|a> and <math|b> in the <code*|fib-iter> process of
    <smart-ref|sec:1.2.2>: <math|a\<leftarrow\>a+b> and
    <math|b\<leftarrow\>a>. Call this transformation <math|T>, and observe
    that applying <math|T> over and over again <math|n> times, starting with
    1 and 0, produces the pair <math|<with|mode|text|Fib><around*|(|n+1|)>>
    and <math|<with|mode|text|Fib><around*|(|n|)>>. In other words, the
    Fibonacci numbers are produced by applying <math|T<rsup|n>>, the
    <math|n<rsup|<with|mode|text|th>>> power of the transformation <math|T>,
    starting with the pair (1, 0). Now consider <math|T> to be the special
    case of <math|p=0> and <math|q=1> in a family of transformations
    <math|T<rsub|pq>>, where <math|T<rsub|pq>> transforms the pair
    <math|<around*|(|a,b|)>> according to <math|a\<leftarrow\>bq+aq+ap> and
    <math|b\<leftarrow\>bp+aq>. Show that if we apply such a transformation
    <math|T<rsub|pq>> twice, the effect is the same as using a single
    transformation <math|T<rsub|p<rsup|\<prime\>>*q<rsup|\<prime\>>>> of the
    same form, and compute <math|p<rsup|\<prime\>>> and
    <math|q<rsup|\<prime\>>> in terms of <math|p> and <math|q>. This gives us
    an explicit way to square these transformations, and thus we can compute
    <math|T<rsup|n>> using successive squaring, as in the <code*|fast-expt>
    procedure. Put this all together to complete the following procedure,
    which runs in a logarithmic number of steps:<\footnote>
      This exercise was suggested to us by Joe Stoy, based on an example in
      Kaldewaij 1990.
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
  </exercise>

  <subsection|Greatest Common Divisors>

  The greatest common divisor (<abbr|GCD>) of two integers <math|a> and
  <math|b> is defined to be the largest integer that divides both <math|a>
  and <math|b> with no remainder. For example, the <abbr|GCD> of 16 and 28 is
  4. In Chapter 2, when we investigate how to implement rational-number
  arithmetic, we will need to be able to compute <abbr|GCD>s in order to
  reduce rational numbers to lowest terms. (To reduce a rational number to
  lowest terms, we must divide both the numerator and the denominator by
  their <abbr|GCD>. For example, 16/28 reduces to 4/7.) One way to find the
  <abbr|GCD> of two integers is to factor them and search for common factors,
  but there is a famous algorithm that is much more efficient.

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
  Algorithm><glossary-explain|Euclid's Algorithm|\<#6B27\>\<#51E0\>\<#91CC\>\<#5F97\>\<#7B97\>\<#6CD5\>>.<\footnote>
    Euclid's Algorithm is so called because it appears in Euclid's
    <cite*|Elements> (Book 7, ca. 300 <abbr|B.C.>). According to Knuth
    (1973), it can be considered the oldest known nontrivial algorithm. The
    ancient Egyptian method of multiplication (Exercise <reference|ex1.18>)
    is surely older, but, as Knuth explains, Euclid's algorithm is the oldest
    known to have been presented as a general algorithm, rather than as a set
    of illustrative examples.
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
      This theorem was proved in 1845 by <name|Gabriel Lamé><index|Gabriel
      Lamé>, a French mathematician and engineer known chiefly for his
      contributions to mathematical physics. To prove the theorem, we
      consider pairs <math|<around*|(|a<rsub|k>,b<rsub|k>|)>>, where
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

  <\exercise>
    The process that a procedure generates is of course dependent on the
    rules used by the interpreter. As an example, consider the iterative
    <code*|gcd> procedure given above. Suppose we were to interpret this
    procedure using normal-order evaluation, as discussed in
    <smart-ref|sec:1.1.5>. (The normal-order-evaluation rule for <code*|if>
    is described in Exercise <reference|ex1.5>.) Using the substitution
    method (for normal order), illustrate the process generated in evaluating
    <code*|(gcd 206 40)> and indicate the <code*|remainder> operations that
    are actually performed. How many <code*|remainder> operations are
    actually performed in the normal-order evaluation of <code*|(gcd 206
    40)>? In the applicative-order evaluation?
  </exercise>
</body>

<\initial>
  <\collection>
    <associate|page-screen-margin|false>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|1.1|<tuple|1|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|1.1.8|<tuple|1.8|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-1|<tuple|1|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-10|<tuple|arguments|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-11|<tuple|prefix notation|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-12|<tuple|pretty-printing|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-13|<tuple|read-eval-print
    loop|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-14|<tuple|Alan Perlis|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-15|<tuple|1.2|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-16|<tuple|variable|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-17|<tuple|value|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-18|<tuple|environment|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-19|<tuple|global environment|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-2|<tuple|integers|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-20|<tuple|1.3|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-21|<tuple|recursive|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-22|<tuple|tree accumulation|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-23|<tuple|1|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-24|<tuple|special forms|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-25|<tuple|syntactic sugar|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-26|<tuple|1.4|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-27|<tuple|procedure definitions|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-28|<tuple|compound procedure|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-29|<tuple|1.5|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-3|<tuple|real numbers|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-30|<tuple|substitution
    model|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-31|<tuple|substitution|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-32|<tuple|substitution|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-33|<tuple|normal-order
    evaluation|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-34|<tuple|applicative-order
    evaluation|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-35|<tuple|stream processing|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-36|<tuple|1.6|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-37|<tuple|case analysis|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-38|<tuple|clauses|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-39|<tuple|predicate|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-4|<tuple|1.1|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-40|<tuple|consequent expression|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-41|<tuple|predicate|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-42|<tuple|1.7|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-43|<tuple|1.8|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-44|<tuple|recursive|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-45|<tuple|2|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-46|<tuple|procedural abstraction|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-47|<tuple|22|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-48|<tuple|bound variable|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-49|<tuple|binds|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-5|<tuple|expression|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-50|<tuple|free|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-51|<tuple|scope|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-52|<tuple|capturing|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-53|<tuple|capturing|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-54|<tuple|block structure|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-55|<tuple|lexical scoping|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-56|<tuple|2|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-57|<tuple|local evolution|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-58|<tuple|global|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-59|<tuple|2.1|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-6|<tuple|evaluating|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-60|<tuple|3|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-61|<tuple|4|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-62|<tuple|deferred operations|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-63|<tuple|recursive process|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-64|<tuple|linear recursive
    process|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-65|<tuple|iterative process|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-66|<tuple|state variables|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-67|<tuple|linear iterative
    process|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-68|<tuple|recursive process|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-69|<tuple|recursive procedure|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-7|<tuple|combinations|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-70|<tuple|tail-recursive|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-71|<tuple|syntactic sugar|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-72|<tuple|2.2|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-73|<tuple|tree recursion|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-74|<tuple|Fibonacci numbers|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-75|<tuple|5|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-76|<tuple|golden ratio|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-77|<tuple|29|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-78|<tuple|tabulation|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-79|<tuple|memoization|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-8|<tuple|operator|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-80|<tuple|Pascal's triangle|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-81|<tuple|binomial coefficients|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-82|<tuple|2.3|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-83|<tuple|order of growth|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-84|<tuple|2.4|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-85|<tuple|Áchárya Pingala|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-86|<tuple|invariant quantity|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-87|<tuple|2.5|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-88|<tuple|Euclid's Algorithm|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-89|<tuple|Gabriel Lamé|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|auto-9|<tuple|operands|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|define_fib|<tuple|Fibonacci
    numbers|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|define_square|<tuple|procedure
    definitions|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|ex1.13|<tuple|13|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|ex1.16|<tuple|16|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|ex1.17|<tuple|17|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|ex1.18|<tuple|18|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|ex1.5|<tuple|5|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|ex1.7|<tuple|7|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|fig:1.1|<tuple|1|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|fig:1.2|<tuple|2|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|fig:1.3|<tuple|3|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|fig:1.4|<tuple|4|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|fig:1.5|<tuple|5|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-1|<tuple|1|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-10|<tuple|10|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-11|<tuple|11|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-12|<tuple|12|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-13|<tuple|13|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-14|<tuple|14|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-15|<tuple|15|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-16|<tuple|16|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-17|<tuple|17|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-18|<tuple|18|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-19|<tuple|19|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-2|<tuple|2|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-20|<tuple|20|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-21|<tuple|21|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-22|<tuple|22|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-23|<tuple|23|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-24|<tuple|24|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-25|<tuple|25|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-26|<tuple|26|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-27|<tuple|27|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-28|<tuple|28|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-29|<tuple|29|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-3|<tuple|3|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-30|<tuple|30|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-31|<tuple|31|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-32|<tuple|32|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-33|<tuple|33|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-34|<tuple|34|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-35|<tuple|35|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-36|<tuple|36|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-37|<tuple|37|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-38|<tuple|38|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-39|<tuple|39|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-4|<tuple|4|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-40|<tuple|40|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-5|<tuple|5|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-6|<tuple|6|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-7|<tuple|7|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-8|<tuple|8|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnote-9|<tuple|9|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-1|<tuple|real numbers|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-10|<tuple|10|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-11|<tuple|11|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-12|<tuple|substitution|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-13|<tuple|stream processing|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-14|<tuple|14|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-15|<tuple|15|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-16|<tuple|16|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-17|<tuple|17|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-18|<tuple|18|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-19|<tuple|19|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-2|<tuple|2|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-20|<tuple|20|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-21|<tuple|21|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-22|<tuple|22|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-23|<tuple|23|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-24|<tuple|24|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-25|<tuple|25|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-26|<tuple|26|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-27|<tuple|27|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-28|<tuple|28|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-29|<tuple|29|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-3|<tuple|3|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-30|<tuple|30|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-31|<tuple|memoization|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-32|<tuple|binomial coefficients|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-33|<tuple|33|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-34|<tuple|34|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-35|<tuple|35|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-36|<tuple|Áchárya Pingala|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-37|<tuple|37|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-38|<tuple|38|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-39|<tuple|39|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-4|<tuple|Alan Perlis|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-40|<tuple|Gabriel Lamé|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-5|<tuple|5|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-6|<tuple|6|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-7|<tuple|7|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-8|<tuple|syntactic sugar|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|footnr-9|<tuple|9|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|index-invariant-quantity|<tuple|16|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|index-stack|<tuple|27|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|sec:1.1.3|<tuple|1.3|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|sec:1.1.4|<tuple|1.4|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|sec:1.1.5|<tuple|1.5|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|sec:1.1.7|<tuple|1.7|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|sec:1.2|<tuple|2|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|sec:1.2.1|<tuple|2.1|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|sec:1.2.2|<tuple|2.2|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
    <associate|sec:1.2.4|<tuple|2.4|?|../../.local/share/XmacsLabs/texts/scratch/no_name_7.tm>>
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

      <tuple|normal|<\surround|<hidden-binding|<tuple>|3>|>
        A linear recursive process for computing 6!.
      </surround>|<pageref|auto-60>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|4>|>
        A linear iterative process for computing 6!.
      </surround>|<pageref|auto-61>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|5>|>
        The tree-recursive process generated in computing
        <with|mode|<quote|prog>|prog-language|<quote|scheme>|font-family|<quote|rm>|(fib
        5)>.
      </surround>|<pageref|auto-75>>
    </associate>
    <\associate|gly>
      <tuple|normal|expression|\<#8868\>\<#8FBE\>\<#5F0F\>\V\V\<#539F\>\<#8BED\>\<#6216\>\<#8005\>\<#7EC4\>\<#5408\>\<#5F0F\>|<pageref|auto-5>>

      <tuple|normal|combinations|\<#7EC4\>\<#5408\>\<#5F0F\>|<pageref|auto-7>>

      <tuple|normal|operator|\<#64CD\>\<#4F5C\>\<#7B26\>|<pageref|auto-8>>

      <tuple|normal|operands|\<#64CD\>\<#4F5C\>\<#6570\>|<pageref|auto-9>>

      <tuple|normal|arguments|\<#53C2\>\<#6570\>|<pageref|auto-10>>

      <tuple|normal|prefix notation|\<#524D\>\<#7F00\>\<#8868\>\<#793A\>\<#6CD5\>|<pageref|auto-11>>

      <tuple|normal|variable|\<#53D8\>\<#91CF\>|<pageref|auto-16>>

      <tuple|normal|value|\<#503C\>|<pageref|auto-17>>

      <tuple|normal|syntactic sugar|\<#8BED\>\<#6CD5\>\<#7CD6\>|<pageref|auto-25>>

      <tuple|normal|compound procedure|\<#590D\>\<#5408\>\<#51FD\>\<#6570\>|<pageref|auto-28>>

      <tuple|normal|substitution model|\<#4EE3\>\<#6362\>\<#6A21\>\<#578B\>|<pageref|auto-30>>

      <tuple|normal|normal-order evaluation|\<#6B63\>\<#5219\>\<#5E8F\>\<#6C42\>\<#503C\>|<pageref|auto-33>>

      <tuple|normal|applicative-order evaluation|\<#5E94\>\<#7528\>\<#5E8F\>\<#6C42\>\<#503C\>|<pageref|auto-34>>

      <tuple|normal|predicate|\<#8C13\>\<#8BCD\>\V\V\<#4E00\>\<#79CD\>\<#503C\>\<#4E3A\>\<#771F\>\<#6216\>\<#8005\>\<#5047\>\<#7684\>\<#8868\>\<#8FBE\>\<#5F0F\>|<pageref|auto-39>>

      <tuple|normal|local evolution|\<#5C40\>\<#90E8\>\<#6F14\>\<#5316\>|<pageref|auto-57>>

      <tuple|normal|deferred operations|\<#63A8\>\<#8FDF\>\<#8FDB\>\<#884C\>\<#7684\>\<#64CD\>\<#4F5C\>|<pageref|auto-62>>

      <tuple|normal|recursive process|\<#9012\>\<#5F52\>\<#8BA1\>\<#7B97\>\<#8FC7\>\<#7A0B\>|<pageref|auto-63>>

      <tuple|normal|linear recursive process|\<#7EBF\>\<#6027\>\<#9012\>\<#5F52\>\<#8FC7\>\<#7A0B\>|<pageref|auto-64>>

      <tuple|normal|iterative process|\<#8FED\>\<#4EE3\>\<#8BA1\>\<#7B97\>\<#8FC7\>\<#7A0B\>|<pageref|auto-65>>

      <tuple|normal|state variables|\<#72B6\>\<#6001\>\<#53D8\>\<#91CF\>|<pageref|auto-66>>

      <tuple|normal|linear iterative process|\<#7EBF\>\<#6027\>\<#8FED\>\<#4EE3\>\<#8FC7\>\<#7A0B\>|<pageref|auto-67>>

      <tuple|dup|recursive process|<pageref|auto-68>>

      <tuple|normal|recursive procedure|\<#9012\>\<#5F52\>\<#8FC7\>\<#7A0B\>|<pageref|auto-69>>

      <tuple|normal|tail-recursive|\<#5C3E\>\<#9012\>\<#5F52\>|<pageref|auto-70>>

      <tuple|normal|syntactic sugar|\<#8BED\>\<#6CD5\>\<#7CD6\>\<#8863\>|<pageref|auto-71>>

      <tuple|normal|tree recursion|\<#6811\>\<#5F62\>\<#9012\>\<#5F52\>|<pageref|auto-73>>

      <tuple|normal|Fibonacci numbers|\<#6590\>\<#6CE2\>\<#90A3\>\<#5951\>\<#6570\>|<pageref|auto-74>>

      <tuple|normal|golden ratio|\<#9EC4\>\<#91D1\>\<#6BD4\>\<#4F8B\>|<pageref|auto-76>>

      <tuple|normal|tabulation|\<#8868\>\<#683C\>\<#6280\>\<#672F\>|<pageref|auto-78>>

      <tuple|normal|memoization|\<#8BB0\>\<#5FC6\>\<#6280\>\<#672F\>|<pageref|auto-79>>

      <tuple|normal|Pascal's triangle|\<#5E15\>\<#65AF\>\<#5361\>\<#4E09\>\<#89D2\>\<#5F62\>|<pageref|auto-80>>

      <tuple|normal|binomial coefficients|\<#4E8C\>\<#9879\>\<#5F0F\>\<#7CFB\>\<#6570\>|<pageref|auto-81>>

      <tuple|normal|order of growth|\<#589E\>\<#957F\>\<#7684\>\<#9636\>|<pageref|auto-83>>

      <tuple|normal|Euclid's Algorithm|\<#6B27\>\<#51E0\>\<#91CC\>\<#5F97\>\<#7B97\>\<#6CD5\>|<pageref|auto-88>>
    </associate>
    <\associate|idx>
      <tuple|<tuple|integers>|<pageref|auto-2>>

      <tuple|<tuple|real numbers>|<pageref|auto-3>>

      <tuple|<tuple|evaluating>|<pageref|auto-6>>

      <tuple|<tuple|pretty-printing>|<pageref|auto-12>>

      <tuple|<tuple|read-eval-print loop>|<pageref|auto-13>>

      <tuple|<tuple|Alan Perlis>|<pageref|auto-14>>

      <tuple|<tuple|environment>|<pageref|auto-18>>

      <tuple|<tuple|global environment>|<pageref|auto-19>>

      <tuple|<tuple|recursive>|<pageref|auto-21>>

      <tuple|<tuple|tree accumulation>|<pageref|auto-22>>

      <tuple|<tuple|special forms>|<pageref|auto-24>>

      <tuple|<tuple|procedure definitions>|<pageref|auto-27>>

      <tuple|<tuple|substitution>|<pageref|auto-31>>

      <tuple|<tuple|stream processing>|<pageref|auto-35>>

      <tuple|<tuple|case analysis>|<pageref|auto-37>>

      <tuple|<tuple|clauses>|<pageref|auto-38>>

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

      <tuple|<tuple|global>|<pageref|auto-58>>

      <tuple|<tuple|Áchárya Pingala>|<pageref|auto-85>>

      <tuple|<tuple|invariant quantity>|<pageref|auto-86>>

      <tuple|<tuple|Gabriel Lamé>|<pageref|auto-89>>
    </associate>
    <\associate|toc>
      1<space|2spc>The Elements of Programming
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1>

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

      2<space|2spc>Procedures and the Processes They Generate
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-56>

      <with|par-left|<quote|1tab>|2.1<space|2spc>Linear Recursion and
      Iteration <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-59>>

      <with|par-left|<quote|1tab>|2.2<space|2spc>Tree Recursion
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-72>>

      <with|par-left|<quote|3tab>|Example: Counting change
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-77>>

      <with|par-left|<quote|1tab>|2.3<space|2spc>Orders of Growth
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-82>>

      <with|par-left|<quote|1tab>|2.4<space|2spc>Exponentiation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-84>>

      <with|par-left|<quote|1tab>|2.5<space|2spc>Greatest Common Divisors
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-87>>
    </associate>
  </collection>
</auxiliary>