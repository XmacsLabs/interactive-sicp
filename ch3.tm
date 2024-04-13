<TeXmacs|2.1.2>

<project|sicp.tm>

<style|<tuple|book|smart-ref|preview-ref>>

<\body>
  <chapter|Modularity, Objects and State>

  The preceding chapters introduced the basic elements from which programs
  are made. We saw how<next-line>primitive procedures and primitive data are
  combined to construct compound entities, and we learned that abstraction is
  vital in helping us to cope with the complexity of large systems. But these
  tools are not sufficient for designing programs. Effective program
  synthesis also requires organizational principles that can guide us in
  formulating the overall design of a program. In particular, we need
  strategies to help us structure large systems so that they will be
  <em|modular><index|modular>, that is, so that they can be divided
  ``naturally'' into coherent parts that can be separately developed and
  maintained.

  One powerful design strategy, which is particularly appropriate to the
  construction of programs for modeling physical systems, is to base the
  structure of our programs on the structure of the system being modeled. For
  each object in the system, we construct a corresponding computational
  object. For each system action, we define a symbolic operation in our
  computational model. Our hope in using this strategy is that extending the
  model to accommodate new objects or new actions will require no strategic
  changes to the program, only the addition of the new symbolic analogs of
  those objects or actions. If we have been successful in our system
  organization, then to add a new feature or debug an old one we will have to
  work on only a localized part of the system.

  To a large extent, then, the way we organize a large program is dictated by
  our perception of the system to be modeled. In this chapter we will
  investigate two prominent organizational strategies arising from two rather
  different ``world views'' of the structure of systems. The first
  organizational strategy concentrates on <em|objects><index|object>, viewing
  a large system as a collection of distinct objects whose behaviors may
  change over time. An alternative organizational strategy concentrates on
  the <em|streams><index|stream> of information that flow in the system, much
  as an electrical engineer views a signal-processing system.

  Both the object-based approach and the stream-processing approach raise
  significant linguistic issues inprogramming. With objects, we must be
  concerned with how a computational object can change and yet maintain its
  identity. This will force us to abandon our old substitution model of
  computation (<smart-ref|sec:1.1.5>) in favor of a more mechanistic but less
  theoretically tractable <em|environment model><index|environment model> of
  computation. The difficulties of dealing with objects, change, and identity
  are a fundamental consequence of the need to grapple with time in our
  computational models. These difficulties become even greater when we allow
  the possibility of concurrent execution of programs. The stream approach
  can be most fully exploited when we decouple simulated time in our model
  from the order of the events that take place in the computer during
  evaluation. We will accomplish this using a technique known as <em|delayed
  evaluation><index|delayed evaluation>.

  <section|Assignment and Local State>

  We ordinarily view the world as populated by independent objects, each of
  which has a state that changes over time. An object is said to ``have
  state'' if its behavior is influenced by its history. A bank account, for
  example, has state in that the answer to the question ``Can I withdraw
  $100?'' depends upon the history of deposit and withdrawal transactions. We
  can characterize an object's state by one or more <em|state
  variables><index|state variable>, which among them maintain enough
  information about history to determine the object's current behavior. In a
  simple banking system, we could characterize the state of an account by a
  current balance rather than by remembering the entire history of account
  transactions.

  In a system composed of many objects, the objects are rarely completely
  independent. Each may influence the states of others through interactions,
  which serve to couple the state variables of one object to those of other
  objects. Indeed, the view that a system is composed of separate objects is
  most useful when the state variables of the system can be grouped into
  closely coupled subsystems that are only loosely coupled to other
  subsystems.

  This view of a system can be a powerful framework for organizing
  computational models of the system. For such a model to be modular, it
  should be decomposed into computational objects that model the actual
  objects in the system. Each computational object must have its own
  <em|local state variables><index|local state variable> describing the
  actual object's state. Since the states of objects in the system being
  modeled change over time, the state variables of the corresponding
  computational objects must also change. If we choose to model the flow of
  time in the system by the elapsed time in the computer, then we must have a
  way to construct computational objects whose behaviors change as our
  programs run. In particular, if we wish to model state variables by
  ordinary symbolic names in the programming language, then the language must
  provide an <em|assignment operator><index|assignment operator> to enable us
  to change the value associated with a name.

  <subsection|Local State Variables><label|sec:3.1.1>

  To illustrate what we mean by having a computational object with
  time-varying state, let us model the situation of withdrawing money from a
  bank account. We will do this using a procedure <scm|withdraw>, which takes
  as argument an <verbatim|amount> to be withdrawn. If there is enough money
  in the account to accommodate the withdrawal, then <verbatim|withdraw>
  should return the balance remaining after the withdrawal. Otherwise,
  <verbatim|withdraw> should return the message <em|Insufficient funds>. For
  example, if we begin with $100 in the account, we should obtain the
  following sequence of responses using withdraw:

  <\scm-code>
    (withdraw 25)

    75

    (withdraw 25)

    50

    (withdraw 60)

    "Insufficient funds"

    (withdraw 15)

    35
  </scm-code>

  Observe that the expression <scm|(withdraw 25)>, evaluated twice, yields
  different values. This is a new kind of behavior for a procedure. Until
  now, all our procedures could be viewed as specifications for computing
  mathematical functions. A call to a procedure computed the value of the
  function applied to the given arguments, and two calls to the same
  procedure with the same arguments always produced the same
  result.<\footnote>
    Actually, this is not quite true. One exception was the random-number
    generator in <smart-ref|sec:1.2.6>. Another exception involved the
    operation/type tables we introduced in <smart-ref|sec:2.4.3>, where the
    values of two calls to get with the same arguments depended on
    intervening calls to put. On the other hand, until we introduce
    assignment, we have no way to create such procedures ourselves.
  </footnote>

  To implement <scm|withdraw>, we can use a variable <scm|balance> to
  indicate the balance of money in the account and define <scm|withdraw> as a
  procedure that accesses <verbatim|balance>. The <verbatim|withdraw>
  procedure checks to see if <verbatim|balance> is at least as large as the
  requested <verbatim|amount>. If so, withdraw decrements balance by
  <verbatim|amount> and returns the new value of <verbatim|balance>.
  Otherwise, withdraw returns the <em|Insufficient funds> message. Here are
  the definitions of <verbatim|balance> and <verbatim|withdraw>:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define balance 100)

      \ \ (define (withdraw amount)

      \ \ \ \ (if (\<gtr\>= balance amount)

      \ \ \ \ \ \ (begin

      \ \ \ \ \ \ \ \ (set! balance (- balance amount))

      \ \ \ \ \ \ \ \ balance)

      \ \ \ \ \ \ "Insufficient funds"))<next-line>
    <|unfolded-io>
      100
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Decrementing balance is accomplished by the expression

  <\scm-code>
    (set! balance (- balance amount))
  </scm-code>

  This uses the <scm|set!> special form, whose syntax is

  <\scm-code>
    (set! \<less\>name\<gtr\> \<less\>new-value\<gtr\>)
  </scm-code>

  Here <em|\<less\>name\<gtr\>> is a symbol and <em|\<less\>new-value\<gtr\>>
  is any expression. <scm|set!> changes <em|\<less\>name\<gtr\>> so that its
  value is the result obtained by evaluating <em|\<less\>new-value\<gtr\>>.
  In the case at hand, we are changing <verbatim|balance> so that its new
  value will be the result of subtracting <verbatim|amount> from the previous
  value of <verbatim|balance>.<\footnote>
    The value of a <scm|set!> expression is implementation-dependent.
    <scm|set!> should be used only for its effect, not for its value.

    The name <scm|set!> reflects a naming convention used in Scheme:
    Operations that change the values of variables (or that change data
    structures, as we will see in <smart-ref|sec:3.3>) are given names that
    end with an exclamation point. This is similar to the convention of
    designating predicates by names that end with a question mark.
  </footnote>

  <verbatim|Withdraw> also uses the <scm|begin> special form to cause two
  expressions to be evaluated in the case where the <scm|if> test is true:
  first decrementing <verbatim|balance> and then returning the value of
  <verbatim|balance>. In general, evaluating the expression

  <\scm-code>
    (begin \<less\>exp1\<gtr\> \<less\>exp2\<gtr\> ... \<less\>expk\<gtr\>)
  </scm-code>

  causes the expressions <verbatim|\<less\>exp1\<gtr\>> through
  <verbatim|\<less\>expk\<gtr\>> to be evaluated in sequence and the value of
  the final expression <verbatim|\<less\>expk\<gtr\>> to be returned as the
  value of the entire <scm|begin> form.<\footnote>
    We have already used <scm|begin> implicitly in our programs, because in
    Scheme the body of a procedure can be a sequence of expressions. Also,
    the <verbatim|\<less\>consequent\<gtr\>> part of each clause in a
    <scm|cond> expression can be a sequence of expressions rather than a
    single expression
  </footnote>

  Although <verbatim|withdraw> works as desired, the variable
  <verbatim|balance> presents a problem. As specified above,
  <verbatim|balance> is a name defined in the global environment and is
  freely accessible to be examined or modified by any procedure. It would be
  much better if we could somehow make <verbatim|balance> internal to
  <verbatim|withdraw>, so that <verbatim|withdraw> would be the only
  procedure that could access <verbatim|balance> directly and any other
  procedure could access <verbatim|balance> only indirectly (through calls to
  <verbatim|withdraw>). This would more accurately model the notion that
  <verbatim|balance> is a local state variable used by <verbatim|withdraw> to
  keep track of the state of the account.

  We can make <verbatim|balance> internal to <verbatim|withdraw> by rewriting
  the definition as follow:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define new-withdraw

      \ \ (let ((balance 100))

      \ \ \ \ (lambda (amount)

      \ \ \ \ \ \ (if (\<gtr\>= balance amount)

      \ \ \ \ \ \ \ \ (begin (set! balance (- balance amount)) balance)

      \ \ \ \ \ \ \ \ "Insufficient funds"))))
    <|unfolded-io>
      new-withdraw
    </unfolded-io>
  </session>

  What we have done here is use <scm|let> to establish an environment with a
  local variable <verbatim|balance>, bound to the initial value <scm|100>.
  Within this local environment, we use <scm|lambda> to create a procedure
  that takes <verbatim|amount> as an argument and behaves like our previous
  <verbatim|withdraw> procedure. This procedure -- returned as the result of
  evaluating the <scm|let> expression -- is <verbatim|new-withdraw>, which
  behaves in precisely the same way as <verbatim|withdraw> but whose variable
  <verbatim|balance> is not accessible by any other procedure.<\footnote>
    In programming-language jargon, the variable <verbatim|balance> is said
    to be <em|encapsulated><index|encapsulated> within the
    <verbatim|new-withdraw> procedure. Encapsulation reflects the general
    system-design principle known as the <em|hiding principle><index|hiding
    principle>: One can make a system more modular and robust by protecting
    parts of the system from each other; that is, by providing information
    access only to those parts of the system that have a ``need to know.''
  </footnote>

  Combining <scm|set!> with local variables is the general programming
  technique we will use for constructing computational objects with local
  state. Unfortunately, using this technique raises a serious problem: When
  we first introduced procedures, we also introduced the substitution model
  of evaluation (<smart-ref|sec:1.1.5>) to provide an interpretation of what
  procedure application means. We said that applying a procedure should be
  interpreted as evaluating the body of the procedure with the formal
  parameters replaced by their values. The trouble is that, as soon as we
  introduce assignment into our language, substitution is no longer an
  adequate model of procedure application. (We will see why this is so in
  <smart-ref|sec:3.1.3>.) As a consequence, we technically have at this point
  no way to understand why the <verbatim|new-withdraw> procedure behaves as
  claimed above. In order to really understand a procedure such as
  <verbatim|new-withdraw>, we will need to develop a new model of procedure
  application. In <smart-ref|sec:3.2> we will introduce such a model,
  together with an explanation of <scm|set!> and local variables. First,
  however, we examine some variations on the theme established <verbatim|by
  new-withdraw>.

  The following procedure, <verbatim|make-withdraw>, creates ``withdrawal
  processors.'' The formal parameter <verbatim|balance> in
  <verbatim|make-withdraw> specifies the initial amount of money in the
  account.<\footnote>
    In contrast with new-withdraw above, we do not have to use let to make
    balance a local variable, since formal parameters are already local. This
    will be clearer after the discussion of the environment model of
    evaluation in <smart-ref|sec:3.2>. (See also exercise 3.10.)
  </footnote>

  <\session|scheme|default>
    <\folded-io|Scheme] >
      (define (make-withdraw balance)

      \ \ (lambda (amount)

      \ \ \ \ (if (\<gtr\>= balance amount)

      \ \ \ \ \ \ (begin\ 

      \ \ \ \ \ \ \ \ (set! balance (- balance amount))

      \ \ \ \ \ \ \ \ balance)

      \ \ \ \ \ \ "Insufficient funds")))
    <|folded-io>
      make-withdraw
    </folded-io>
  </session>

  <verbatim|make-withdraw> can be used as follows to create two objects
  <verbatim|W1> and <verbatim|W2>:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define W1 (make-withdraw 100))
    <|unfolded-io>
      W1
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (define W2 (make-withdraw 100))
    <|unfolded-io>
      W2
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (W1 50)
    <|unfolded-io>
      50
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (W2 70)
    <|unfolded-io>
      30
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (W1 40)
    <|unfolded-io>
      10
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (W2 40)
    <|unfolded-io>
      "Insufficient funds"
    </unfolded-io>
  </session>

  Observe that <verbatim|W1> and <verbatim|W2> are completely independent
  objects, each with its own local state variable <verbatim|balance>.
  Withdrawals from one do not affect the other.

  We can also create objects that handle deposits as well as withdrawals, and
  thus we can represent simple bank accounts. Here is a procedure that
  returns a ``bank-account object'' with a specified initial balance:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define (make-account balance)

      \ \ (define (withdraw amount)

      \ \ \ \ (if (\<gtr\>= balance amount)

      \ \ \ \ \ \ (begin (set! balance (- balance amount))

      \ \ \ \ \ \ \ \ balance)

      \ \ \ \ \ \ "Insufficient funds"))

      \ \ (define (deposit amount)

      \ \ \ \ (set! balance (+ balance amount))

      \ \ \ \ balance)

      (define (dispatch m)

      \ \ (cond ((eq? m 'withdraw) withdraw)

      \ \ \ \ \ \ \ \ ((eq? m 'deposit) deposit)

      \ \ \ \ \ \ \ \ (else (error "Unknown request -- MAKE-ACCOUNT"))))

      dispatch)
    <|unfolded-io>
      make-account
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Each call to <verbatim|make-account> sets up an environment with a local
  state variable <verbatim|balance>. Within this environment,
  <verbatim|make-account> defines procedures <verbatim|deposit> and
  <verbatim|withdraw> that access <verbatim|balance> and an additional
  procedure <verbatim|dispatch> that takes a ``message'' as input and returns
  one of the two local procedures. The <verbatim|dispatch> procedure itself
  is returned as the value that represents the bank-account object. This is
  precisely the <em|message-passing> style of programming that we saw in
  <smart-ref|sec:2.4.3>, although here we are using it in conjunction with
  the ability to modify local variables.

  <verbatim|make-account> can be used as follows:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define acc (make-account 100))
    <|unfolded-io>
      dispatch
    </unfolded-io>

    <\unfolded-io|Scheme] >
      ((acc 'withdraw) 50)
    <|unfolded-io>
      50
    </unfolded-io>

    <\unfolded-io|Scheme] >
      ((acc 'withdraw) 60)
    <|unfolded-io>
      "Insufficient funds"
    </unfolded-io>

    <\unfolded-io|Scheme] >
      ((acc 'deposit) 40)
    <|unfolded-io>
      90
    </unfolded-io>

    <\unfolded-io|Scheme] >
      ((acc 'withdraw) 60)
    <|unfolded-io>
      30
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Each call to <verbatim|acc> returns the locally defined <verbatim|deposit>
  or <verbatim|withdraw> procedure, which is then applied to the specified
  amount. As was the case with <verbatim|make-withdraw>, another call to
  <verbatim|make-account>

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define acc2 (make-account 100))
    </input>
  </session>

  will produce a completely separate account object, which maintains its own
  local <verbatim|balance>.

  <\exercise>
    An <em|accumulator><index|accumulator> is a procedure that is called
    repeatedly with a single numeric argument and accumulates its arguments
    into a sum. Each time it is called, it returns the currently accumulated
    sum. Write a procedure <verbatim|make-accumulator> that generates
    accumulators, each maintaining an independent sum. The input to
    <verbatim|make-accumulator> should specify the initial value of the sum;
    for example

    <\scm-code>
      (define A (make-accumulator 5))

      (A 10)

      15

      (A 10)

      25
    </scm-code>
  </exercise>

  <\exercise>
    In software-testing applications, it is useful to be able to count the
    number of times a given procedure is called during the course of a
    computation. Write a procedure <verbatim|make-monitored> that takes as
    input a procedure, <verbatim|f>, that itself takes one input. The result
    returned by <verbatim|make-monitored> is a third procedure, say
    <verbatim|mf>, that keeps track of the number of times it has been called
    by maintaining an internal counter. If the input to mf is the special
    symbol <verbatim|how-many-calls?>, then <verbatim|mf> returns the value
    of the counter. If the input is the special symbol
    <verbatim|reset-count>, then <verbatim|mf> resets the counter to zero.
    For any other input, mf returns the result of calling <verbatim|f> on
    that input and increments the counter. For instance, we could make a
    monitored version of the <verbatim|sqrt> procedure:

    <\scm-code>
      (define s (make-monitored sqrt))

      (s 100)

      10

      (s 'how-many-calls?)

      1
    </scm-code>
  </exercise>

  <\exercise>
    Modify the <verbatim|make-account> procedure so that it creates
    password-protected accounts. That is, <verbatim|make-account> should take
    a symbol as an additional argument, as in

    <\scm-code>
      (define acc (make-account 100 'secret-password))
    </scm-code>

    The resulting account object should process a request only if it is
    accompanied by the password with which the account was created, and
    should otherwise return a complaint:

    <\scm-code>
      ((acc 'secret-password 'withdraw) 40)

      60

      ((acc 'some-other-password 'deposit) 50)

      "Incorrect password"
    </scm-code>
  </exercise>

  <\exercise>
    Modify the <verbatim|make-account> procedure of exercise 3.3 by adding
    another local state variable so that, if an account is accessed more than
    seven consecutive times with an incorrect password, it invokes the
    procedure <verbatim|call-the-cops>.
  </exercise>

  <subsection|The Benefits of Introducing Assignment>

  As we shall see, introducing assignment into our programming language leads
  us into a thicket of difficult conceptual issues. Nevertheless, viewing
  systems as collections of objects with local state is a powerful technique
  for maintaining a modular design. As a simple example, consider the design
  of a procedure <verbatim|rand> that, whenever it is called, returns an
  integer chosen at random.

  It is not at all clear what is meant by ``chosen at random.'' What we
  presumably want is for successive calls to rand to produce a sequence of
  numbers that has statistical properties of uniform distribution. We will
  not discuss methods for generating suitable sequences here. Rather, let us
  assume that we have a procedure <verbatim|rand-update> that has the
  property that if we start with a given number <math|x<rsub|1>> and form:

  <\verbatim-code>
    <math|x<rsub|2>> = (rand-update <math|x<rsub|1>> )

    <math|x<rsub|3>> = (rand-update <math|x<rsub|2>> )
  </verbatim-code>

  then the sequence of values <math|x<rsub|1>>, <math|x<rsub|3>>,
  <math|x<rsub|3>>, ..., will have the desired statistical
  properties.<\footnote>
    One common way to implement <verbatim|rand-update> is to use the rule
    that <math|x> is updated to <math|a*x + b modulo m>, where <math|a>,
    <math|b>, and <math|m> are appropriately chosen integers. Chapter 3 of
    Knuth 1981 includes an extensive discussion of techniques for generating
    sequences of random numbers and establishing their statistical
    properties. Notice that the <verbatim|rand-update> procedure computes a
    mathematical function: Given the same input twice, it produces the same
    output. Therefore, the number sequence produced by <verbatim|rand-update>
    certainly is not ``random,'' if by ``random'' we insist that each number
    in the sequence is unrelated to the preceding number. The relation
    between ``real randomness'' and so-called
    <em|pseudo-random><index|pseudo-random> sequences, which are produced by
    well-determined computations and yet have suitable statistical
    properties, is a complex question involving difficult issues in
    mathematics and philosophy. Kolmogorov, Solomonoff, and Chaitin have made
    great progress in clarifying these issues; a discussion can be found in
    Chaitin 1975
  </footnote>

  We can implement <verbatim|rand> as a procedure with a local state variable
  <verbatim|x> that is initialized to some fixed value
  <verbatim|random-init>. Each call to <verbatim|rand> computes
  <verbatim|rand-update> of the current value of <verbatim|x>, returns this
  as the random number, and also stores this as the new value of
  <verbatim|x>.

  <\scm-code>
    (define rand

    \ \ (let ((x random-init))

    \ \ \ \ (lambda ()

    \ \ \ \ \ \ (set! x (rand-update x))

    \ \ \ \ \ \ x)))
  </scm-code>

  Of course, we could generate the same sequence of random numbers without
  using assignment by simply calling <verbatim|rand-update> directly.
  However, this would mean that any part of our program that used random
  numbers would have to explicitly remember the current value of <verbatim|x>
  to be passed as an argument to <verbatim|rand-update>. To realize what an
  annoyance this would be, consider using random numbers to implement a
  technique called <em|Monte Carlo simulation><index|Monte Carlo simulation>.

  The Monte Carlo method consists of choosing sample experiments at random
  from a large set and then making deductions on the basis of the
  probabilities estimated from tabulating the results of those experiments.
  For example, we can approximate <math|\<pi\>> using the fact that
  <math|<frac*|6|\<pi\><rsup|2>>> is the probability that two integers chosen
  at random will have no factors in common; that is, that their greatest
  common divisor will be 1.<\footnote>
    This theorem is due to E. Cesàro. See section 4.5.2 of Knuth 1981 for a
    discussion and a proof.
  </footnote> To obtain the approximation to <math|\<pi\>>, we perform a
  large number of experiments. In each experiment we choose two integers at
  random and perform a test to see if their GCD is 1. The fraction of times
  that the test is passed gives us our estimate of
  <math|<frac*|6|\<pi\><rsup|2>>>, and from this we obtain our approximation
  to <math|\<pi\>>.

  The heart of our program is a procedure <verbatim|monte-carlo>, which takes
  as arguments the number of times to try an experiment, together with the
  experiment, represented as a no-argument procedure that will return either
  true or false each time it is run. <verbatim|monte-carlo> runs the
  experiment for the designated number of trials and returns a number telling
  the fraction of the trials in which the experiment was found to be true.

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define (estimate-pi trials)

      \ \ (sqrt (/ 6 (monte-carlo trials cesaro-test))))

      (define (cesaro-test)

      \ \ (= (gcd (rand) (rand)) 1))

      (define (monte-carlo trials experiment)

      \ \ (define (iter trials-remaining trials-passed)

      \ \ \ \ (cond\ 

      \ \ \ \ \ \ ((= trials-remaining 0)

      \ \ \ \ \ \ \ \ (/ trials-passed trials))

      \ \ \ \ \ \ ((experiment)

      \ \ \ \ \ \ \ \ (iter (- trials-remaining 1) (+ trials-passed 1)))

      \ \ \ \ \ \ (else

      \ \ \ \ \ \ \ \ (iter (- trials-remaining 1) trials-passed))))

      \ \ (iter trials 0))
    <|unfolded-io>
      estimate-pi
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Now let us try the same computation using <verbatim|rand-update> directly
  rather than <verbatim|rand>, the way we would be forced to proceed if we
  did not use assignment to model local state:

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define (estimate-pi trials)

      \ \ (sqrt (/ 6 (random-gcd-test trials random-init))))

      (define (random-gcd-test trials initial-x)

      \ \ (define (iter trials-remaining trials-passed x)

      \ \ \ \ (let ((x1 (rand-update x)))

      \ \ \ \ \ \ (let ((x2 (rand-update x1)))

      \ \ \ \ \ \ \ \ (cond\ 

      \ \ \ \ \ \ \ \ \ \ ((= trials-remaining 0)

      \ \ \ \ \ \ \ \ \ \ \ \ (/ trials-passed trials))

      \ \ \ \ \ \ \ \ \ \ ((= (gcd x1 x2) 1)

      \ \ \ \ \ \ \ \ \ \ \ \ (iter (- trials-remaining 1) (+ trials-passed
      1) x2))

      \ \ \ \ \ \ \ \ \ \ <hlink||file:///C:/TJUPT/%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A8%8B%E5%BA%8F%E7%9A%84%E6%9E%84%E9%80%A0%E5%92%8C%E8%A7%A3%E9%87%8A%C2%B7%E7%AC%AC2%E7%89%88%EF%BC%88%E4%B8%AD%E8%8B%B1%E5%8F%8C%E7%89%88%EF%BC%89/Structure%20and%20Interpretation%20of%20Computer%20Programs_2nd%20Edition%20by%20Harold%20Abelson,%20Gerald%20Jay%20Sussman.pdf#%E1%D6%CD4%F4%EB%BE%EF%u2014%03yB%DF%FD%C2%28footnote_Temp_331>(else

      \ \ \ \ \ \ \ \ \ \ \ \ (iter (- trials-remaining 1) trials-passed
      x2))))))

      \ \ (iter trials 0 initial-x))
    </input>
  </session>

  While the program is still simple, it betrays some painful breaches of
  modularity. In our first version of the program, using <verbatim|rand>, we
  can express the Monte Carlo method directly as a general<verbatim|
  monte-carlo> procedure that takes as an argument an arbitrary experiment
  procedure. In our second version of the program, with no local state for
  the random-number generator, <verbatim|random-gcd-test> must explicitly
  manipulate the random numbers <verbatim|x1> and <verbatim|x2> and recycle
  <verbatim|x2> through the iterative loop as the new input to
  <verbatim|rand-update>. This explicit handling of the random numbers
  intertwines the structure of accumulating test results with the fact that
  our particular experiment uses two random numbers, whereas other Monte
  Carlo experiments might use one random number or three. Even the top-level
  procedure <verbatim|estimate-pi> has to be concerned with supplying an
  initial random number. The fact that the random-number generator's insides
  are leaking out into other parts of the program makes it difficult for us
  to isolate the Monte Carlo idea so that it can be applied to other tasks.
  In the first version of the program, assignment encapsulates the state of
  the random-number generator within the <verbatim|rand> procedure, so that
  the details of random-number generation remain independent of the rest of
  the program.

  The general phenomenon illustrated by the Monte Carlo example is this: From
  the point of view of one part of a complex process, the other parts appear
  to change with time. They have hidden time-varying local state. If we wish
  to write computer programs whose structure reflects this decomposition, we
  make computational objects (such as bank accounts and random-number
  generators) whose behavior changes with time. We model state with local
  state variables, and we model the changes of state with assignments to
  those variables.

  It is tempting to conclude this discussion by saying that, by introducing
  assignment and the technique of hiding state in local variables, we are
  able to structure systems in a more modular fashion than if all state had
  to be manipulated explicitly, by passing additional parameters.
  Unfortunately, as we shall see, the story is not so simple.

  <\exercise>
    <em|Monte Carlo integration><index|Monte Carlo integration> is a method
    of estimating definite integrals by means of Monte Carlo simulation.
    Consider computing the area of a region of space described by a predicate
    <math|P(x, y)> that is true for points <math|(x, y)> in the region and
    false for points not in the region. For example, the region contained
    within a circle of radius <math|3> centered at <math|(5, 7)> is described
    by the predicate that tests whether <math|(x - 5) <rsup|2> + (y -
    7)<rsup|2>\<less\> 3<rsup|2>>. To estimate the area of the region
    described by such a predicate, begin by choosing a rectangle that
    contains the region. For example, a rectangle with diagonally opposite
    corners at <math|(2, 4)> and <math|(8, 10)> contains the circle above.
    The desired integral is the area of that portion of the rectangle that
    lies in the region. We can estimate the integral by picking, at random,
    points <math|(x,y)> that lie in the rectangle, and testing <math|P(x, y)>
    for each point to determine whether the point lies in the region. If we
    try this with many points, then the fraction of points that fall in the
    region should give an estimate of the proportion of the rectangle that
    lies in the region. Hence, multiplying this fraction by the area of the
    entire rectangle should produce an estimate of the integral.

    Implement Monte Carlo integration as a procedure
    <verbatim|estimate-integral> that takes as arguments a predicate
    <verbatim|P>, upper and lower bounds <verbatim|x1>, <verbatim|x2>,
    <verbatim|y1>, and <verbatim|y2> for the rectangle, and the number of
    trials to

    \;

    perform in order to produce the estimate. Your procedure should use the
    same monte-carlo procedure that was used above to estimate <math|\<pi\>>.
    Use your <verbatim|estimate-integral> to produce an estimate of by
    measuring the area of a unit circle.

    You will find it useful to have a procedure that returns a number chosen
    at random from a given range. The following <verbatim|random-in-range>
    procedure implements this in terms of the random procedure used in
    <smart-ref|sec:1.2.6>, which returns a nonnegative number less than its
    input.<\footnote>
      MIT Scheme provides such a procedure. If random is given an exact
      integer (as in <smart-ref|sec:1.2.6>) it returns an exact integer, but
      if it is given a decimal value (as in this exercise) it returns a
      decimal value.
    </footnote>

    <\session|scheme|default>
      <\input>
        Scheme]\ 
      <|input>
        (define (random-in-range low high)

        \ \ (let ((range (- high low)))

        \ \ \ \ (+ low (random range))))
      </input>
    </session>
  </exercise>

  <\exercise>
    It is useful to be able to reset a random-number generator to produce a
    sequence starting from a given value. Design a new <verbatim|rand>
    procedure that is called with an argument that is either the symbol
    <verbatim|generate> or the symbol <verbatim|reset> and behaves as
    follows: <scm|(rand 'generate)> produces a new random number; <scm|((rand
    'reset) \<less\>new-value\<gtr\>)> resets the internal state variable to
    the designated <verbatim|\<less\>new-value\<gtr\>>. Thus, by resetting
    the state, one can generate repeatable sequences. These are very handy to
    have when testing and debugging programs that use random numbers.
  </exercise>

  <subsection|The Cost of Introducing Assignment><label|sec:3.1.3>

  As we have seen, the <scm|set!> operation enables us to model objects that
  have local state. However, this advantage comes at a price. Our programming
  language can no longer be interpreted in terms of the substitution model of
  procedure application that we introduced in <smart-ref|sec:1.1.5>.
  Moreover, no simple model with ``nice'' mathematical properties can be an
  adequate framework for dealing with objects and assignment in programming
  languages.

  So long as we do not use assignments, two evaluations of the same procedure
  with the same arguments will produce the same result, so that procedures
  can be viewed as computing mathematical functions. Programming without any
  use of assignments, as we did throughout the first two chapters of this
  book, is accordingly known as <em|functional programming><index|functional
  programming>.

  To understand how assignment complicates matters, consider a simplified
  version of the <verbatim|make-withdraw> procedure of <smart-ref|sec:3.1.1>
  that does not bother to check for an insufficient amount:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define (make-simplified-withdraw balance)

      \ \ (lambda (amount)

      \ \ \ \ (set! balance (- balance amount))

      \ \ \ \ balance))
    <|unfolded-io>
      make-simplified-withdraw
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (define W (make-simplified-withdraw 25))
    <|unfolded-io>
      W
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (W 20)
    <|unfolded-io>
      5
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (W 10)
    <|unfolded-io>
      -5
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Compare this procedure with the following <verbatim|make-decrementer>
  procedure, which does not use <scm|set!>:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define (make-decrementer balance)

      \ \ (lambda (amount)

      \ \ \ \ (- balance amount)))
    <|unfolded-io>
      make-decrementer
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  <verbatim|make-decrementer> returns a procedure that subtracts its input
  from a designated amount balance, but there is no accumulated effect over
  successive calls, as with <verbatim|make-simplified-withdraw>:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define D (make-decrementer 25))
    <|unfolded-io>
      D
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (D 20)
    <|unfolded-io>
      5
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (D 10)
    <|unfolded-io>
      15
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  We can use the substitution model to explain how
  <verbatim|make-decrementer> works. For instance, let us analyze the
  evaluation of the expression

  <\scm-code>
    ((make-decrementer 25) 20)
  </scm-code>

  We first simplify the operator of the combination by substituting 25 for
  <verbatim|balance> in the body of \ <verbatim|make-decrementer>. This
  reduces the expression to

  <\scm-code>
    ((lambda (amount) (- 25 amount)) 20)
  </scm-code>

  Now we apply the operator by substituting 20 for amount in the body of the
  <scm|lambda> expression:

  <\scm-code>
    (- 25 20)
  </scm-code>

  The final answer is 5.

  Observe, however, what happens if we attempt a similar substitution
  analysis with <verbatim|make-simplified-withdraw>:

  <\scm-code>
    ((make-simplified-withdraw 25) 20)
  </scm-code>

  We first simplify the operator by substituting 25 for <verbatim|balance> in
  the body of <verbatim|make-simplified-withdraw>. This reduces the
  expression to:<\footnote>
    We don't substitute for the occurrence of <verbatim|balance> in the
    <scm|set!> expression because the <verbatim|\<less\>name\<gtr\>> in a
    <scm|set!> is not evaluated. If we did substitute for it, we would get
    <scm|(set! 25 (- 25 amount))>, which makes no sense.
  </footnote>

  <\scm-code>
    ((lambda (amount) (set! balance (- 25 amount)) 25) 20)
  </scm-code>

  Now we apply the operator by substituting 20 for <verbatim|amount> in the
  body of the <scm|lambda> expression:

  <\scm-code>
    (set! balance (- 25 20)) 25
  </scm-code>

  If we adhered to the substitution model, we would have to say that the
  meaning of the procedure application is to first set <verbatim|balance> to
  5 and then return 25 as the value of the expression. This gets the wrong
  answer. In order to get the correct answer, we would have to somehow
  distinguish the first occurrence of <verbatim|balance> (before the effect
  of the <scm|set!>) from the second occurrence of <verbatim|balance> (after
  the effect of the <scm|set!>), and the substitution model cannot do this.

  The trouble here is that substitution is based ultimately on the notion
  that the symbols in our language are essentially names for values. But as
  soon as we introduce <scm|set!> and the idea that the value of a variable
  can change, a variable can no longer be simply a name. Now a variable
  somehow refers to a place where a value can be stored, and the value stored
  at this place can change. In <smart-ref|sec:3.2> we will see how
  environments play this role of ``place'' in our computational model.

  <subsubsection*|Sameness and Change>

  The issue surfacing here is more profound than the mere breakdown of a
  particular model of computation. As soon as we introduce change into our
  computational models, many notions that were previously straightforward
  become problematical. Consider the concept of two things being ``the
  same.''

  Suppose we call <verbatim|make-decrementer> twice with the same argument to
  create two procedures:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define D1 (make-decrementer 25))
    <|unfolded-io>
      D1
    </unfolded-io>

    <\input|Scheme] >
      (define D2 (make-decrementer 25))
    </input>
  </session>

  Are <verbatim|D1> and <verbatim|D2> the same? An acceptable answer is yes,
  because <verbatim|D1> and <verbatim|D2> have the same computational
  behavior -- each is a procedure that subtracts its input from 25. In fact,
  <verbatim|D1> could be substituted for <verbatim|D2> in any computation
  without changing the result.

  Contrast this with making two calls to <verbatim|make-simplified-withdraw>:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define W1 (make-simplified-withdraw 25))
    <|unfolded-io>
      W1
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (define W2 (make-simplified-withdraw 25))
    <|unfolded-io>
      W2
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Are <verbatim|W1> and <verbatim|W2> the same? Surely not, because calls to
  <verbatim|W1> and <verbatim|W2> have distinct effects, as shown by the
  following sequence of interactions:

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (W1 20)
    <|unfolded-io>
      5
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (W1 20)
    <|unfolded-io>
      -15
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (W2 20)
    <|unfolded-io>
      5
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Even though <verbatim|W1> and <verbatim|W2> are ``equal'' in the sense that
  they are both created by evaluating the same expression,
  <scm|(make-simplified-withdraw 25)>, it is not true that <verbatim|W1>
  could be substituted for <verbatim|W2> in any expression without changing
  the result of evaluating the expression.

  A language that supports the concept that ``equals can be substituted for
  equals'' in an expresssion without changing the value of the expression is
  said to be <em|referentially transparent><index|referentially transparent>.
  Referential transparency is violated when we include <scm|set!> in our
  computer language. This makes it tricky to determine when we can simplify
  expressions by substituting equivalent expressions. Consequently, reasoning
  about programs that use assignment becomes drastically more difficult.

  Once we forgo referential transparency, the notion of what it means for
  computational objects to be ``the same'' becomes difficult to capture in a
  formal way. Indeed, the meaning of ``same'' in the real world that our
  programs model is hardly clear in itself. In general, we can determine that
  two apparently identical objects are indeed ``the same one'' only by
  modifying one object and then observing whether the other object has
  changed in the same way. But how can we tell if an object has ``changed''
  other than by observing the ``same'' object twice and seeing whether some
  property of the object differs from one observation to the next? Thus, we
  cannot determine ``change'' without some a <em|priori> notion of
  ``sameness,'' and we cannot determine sameness without observing the
  effects of change.

  As an example of how this issue arises in programming, consider the
  situation where Peter and Paul have a bank account with $100 in it. There
  is a substantial difference between modeling this as

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define peter-acc (make-account 100))
    <|unfolded-io>
      dispatch
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (define paul-acc (make-account 100))
    <|unfolded-io>
      dispatch
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  and modeling it as

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define peter-acc (make-account 100))
    <|unfolded-io>
      dispatch
    </unfolded-io>

    <\folded-io|Scheme] >
      (define paul-acc peter-acc)
    <|folded-io>
      dispatch
    </folded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  In the first situation, the two bank accounts are distinct. Transactions
  made by Peter will not affect Paul's account, and vice versa. In the second
  situation, however, we have defined <verbatim|paul-acc> to be <em|the same
  thing> as <verbatim|peter-acc>. In effect, Peter and Paul now have a joint
  bank account, and if Peter makes a withdrawal from <verbatim|peter-acc>
  Paul will observe less money in <verbatim|paul-acc>. These two similar but
  distinct situations can cause confusion in building computational models.
  With the shared account, in particular, it can be especially confusing that
  there is one object (the bank account) that has two different names
  (<verbatim|peter-acc> and <verbatim|paul-acc>); if we are searching for all
  the places in our program where <verbatim|paul-acc> can be changed, we must
  remember to look also at things that change
  <verbatim|peter-acc>.<\footnote>
    The phenomenon of a single computational object being accessed by more
    than one name is known as <em|aliasing><index|aliasing>. The joint bank
    account situation illustrates a very simple example of an alias. In
    <smart-ref|sec:3.3> we will see much more complex examples, such as
    ``distinct'' compound data structures that share parts. Bugs can occur in
    our programs if we forget that a change to an object may also, as a
    ``side effect,'' change a ``different'' object because the two
    ``different'' objects are actually a single object appearing under
    different aliases. These so-called <em|side-effect
    bugs><index|side-effect bugs> are so difficult to locate and to analyze
    that some people have proposed that programming languages be designed in
    such a way as to not allow side effects or aliasing (Lampson et al. 1981;
    Morris, Schmidt, and Wadler 1980).
  </footnote>

  With reference to the above remarks on ``sameness'' and ``change,'' observe
  that if Peter and Paul could only examine their bank balances, and could
  not perform operations that changed the balance, then the issue of whether
  the two accounts are distinct would be moot. In general, so long as we
  never modify data objects, we can regard a compound data object to be
  precisely the totality of its pieces. For example, a rational number is
  determined by giving its numerator and its denominator. But this view is no
  longer valid in the presence of change, where a compound data object has an
  ``identity'' that is something different from the pieces of which it is
  composed. A bank account is still ``the same'' bank account even if we
  change the balance by making a withdrawal; conversely, we could have two
  different bank accounts with the same state information. This complication
  is a consequence, not of our programming language, but of our perception of
  a bank account as an object. We do not, for example, ordinarily regard a
  rational number as a changeable object with identity, such that we could
  change the numerator and still have ``the same'' rational number.

  <subsubsection*|Pitfalls of imperactive programming>

  In contrast to functional programming, programming that makes extensive use
  of assignment is known as <em|imperative programming><index|imperative
  programming>. In addition to raising complications about computational
  models, programs written in imperative style are susceptible to bugs that
  cannot occur in functional programs. For example, recall the iterative
  factorial program from <smart-ref|sec:1.2.1>:

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define (factorial n)

      \ \ (define (iter product counter)

      \ \ \ \ (if (\<gtr\> counter n)

      \ \ \ \ \ \ \ \ product

      \ \ \ \ \ \ \ \ (iter (* counter product)(+ counter 1))))

      \ \ (iter 1 1))
    </input>
  </session>

  Instead of passing arguments in the internal iterative loop, we could adopt
  a more imperative style by using explicit assignment to update the values
  of the variables product and counter:

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define (factorial n)

      \ \ (let ((product 1)

      \ \ \ \ \ \ \ \ (counter 1))

      \ \ \ \ (define (iter)

      \ \ \ \ \ \ (if (\<gtr\> counter n)

      \ \ \ \ \ \ \ \ \ \ product

      \ \ \ \ \ \ \ \ \ \ (begin

      \ \ \ \ \ \ \ \ \ \ \ \ (set! product (* counter product))

      \ \ \ \ \ \ \ \ \ \ \ \ (set! counter (+ counter 1))

      \ \ \ \ \ \ \ \ \ \ \ \ (iter))))

      \ \ \ \ (iter)))
    </input>
  </session>

  This does not change the results produced by the program, but it does
  introduce a subtle trap. How do we decide the order of the assignments? As
  it happens, the program is correct as written. But writing the assignments
  in the opposite order

  <\scm-code>
    (set! counter (+ counter 1))

    (set! product (* counter product))
  </scm-code>

  would have produced a different, incorrect result. In general, programming
  with assignment forces us to carefully consider the relative orders of the
  assignments to make sure that each statement is using the correct version
  of the variables that have been changed. This issue simply does not arise
  in functional programs.<\footnote>
    In view of this, it is ironic that introductory programming is most often
    taught in a highly imperative style. This may be a vestige of a belief,
    common throughout the 1960s and 1970s, that programs that call procedures
    must inherently be less efficient than programs that perform assignments.
    (Steele (1977) debunks this argument.) Alternatively it may reflect a
    view that step-by-step assignment is easier for beginners to visualize
    than procedure call. Whatever the reason, it often saddles beginning
    programmers with ``should I set this variable before or after that one''
    concerns that can complicate programming and obscure the important ideas.
  </footnote> The complexity of imperative programs becomes even worse if we
  consider applications in which several processes execute concurrently. We
  will return to this in <smart-ref|sec:3.4>. First, however, we will address
  the issue of providing a computational model for expressions that involve
  assignment, and explore the uses of objects with local state in designing
  simulations.

  <\exercise>
    Consider the bank account objects created by <verbatim|make-account>,
    with the password modification described in exercise 3.3. Suppose that
    our banking system requires the ability to make joint accounts. Define a
    procedure <verbatim|make-joint> that accomplishes this.
    <verbatim|make-joint> should take three .arguments. The first is a
    password-protected account. The second argument must match the password
    with which the account was defined in order for the <verbatim|make-joint>
    operation to proceed. The third argument is a new password.
    <verbatim|make-joint> is to create an additional access to the original
    account using the new password. For example, if <verbatim|peter-acc> is a
    bank account with password <verbatim|open-sesame>, then

    <\scm-code>
      (define paul-acc

      \ \ (make-joint peter-acc 'open-sesame 'rosebud))
    </scm-code>

    Will allow ne to make transactions on <verbatim|peter-acc> using the name
    <verbatim|paul-acc> and the password <verbatim|rosebud>. You may wish to
    modify your solution to exercise 3.3 to accommodate this new feature
  </exercise>

  <\exercise>
    When we defined the evaluation model in <smart-ref|sec:1.1.3>, we said
    that the first step in evaluating an expression is to evaluate its
    subexpressions. But we never specified the order in which the
    subexpressions should be evaluated (e.g., left to right or right to
    left). When we introduce assignment, the order in which the arguments to
    a procedure are evaluated can make a difference to the result. Define a
    simple procedure <verbatim|f> such that evaluating <scm|(+ (f 0) (f 1))>
    will return 0 if the arguments to <verbatim|+> are evaluated from left to
    right but will return 1 if the arguments are evaluated from right to
    left.
  </exercise>

  <section|The Environment Model of Evaluation><label|sec:3.2>

  When we introduced compound procedures in chapter 1, we used the
  substitution model of evaluation (<smart-ref|sec:1.1.5>) to define what is
  meant by applying a procedure to arguments:

  <\quote-env>
    To apply a compound procedure to arguments, evaluate the body of the
    procedure with each formal parameter replaced by the corresponding
    argument.
  </quote-env>

  Once we admit assignment into our programming language, such a definition
  is no longer adequate. In particular, <smart-ref|sec:3.1.3> argued that, in
  the presence of assignment, a variable can no longer be considered to be
  merely a name for a value. Rather, a variable must somehow designate a
  ``place'' in which values can be stored. In our new model of evaluation,
  these places will be maintained in structures called
  <em|environments><index|environments>.

  An environment is a sequence of <em|frames><index|frames>. Each frame is a
  table (possibly empty) of <em|bindings><index|bindings>, which associate
  variable names with their corresponding values. (A single frame may contain
  at most one binding for any variable.) Each frame also has a pointer to its
  <em|enclosing environment><index|enclosing environment>, unless, for the
  purposes of discussion, the frame is considered to be
  <em|global><index|global>. The <em|value of a variable><index|value of a
  variable> with respect to an environment is the value given by the binding
  of the variable in the first frame in the environment that contains a
  binding for that variable. If no frame in the sequence specifies a binding
  for the variable, then the variable is said to be
  <em|unbound><index|unbound> in the environment.

  <\big-figure>
    <with|gr-mode|<tuple|group-edit|group-ungroup>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-grid|<tuple|empty>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|empty>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-arrow-end|\<gtr\>|gr-snap|<tuple|control
    point|grid point|curve-grid intersection|curve point|curve-curve
    intersection|text border point|text border>|gr-auto-crop|true|<graphics||<line|<point|-1|2.5>|<point|-1.0|1.0>|<point|1.0|1.0>|<point|1.0|2.5>|<point|-1.0|2.5>>|<\document-at>
      III
    </document-at|<point|2.200000000000004|-1.3>>|<\document-at>
      x:3

      y:5
    </document-at|<point|-0.7000000000000004|2.2>>|<\document-at>
      z:6

      x:7
    </document-at|<point|-2.4000000000001283|-1.3>>|<\document-at>
      m:5

      y:2
    </document-at|<point|1.0000000000000329|-1.3>>|<\document-at>
      I
    </document-at|<point|0.5|2.2>>|<\document-at>
      II
    </document-at|<point|-1.2000000000000746|-1.3>>|<line|<point|0.7000000000000296|-1.0>|<point|0.7000000000000296|-2.5>|<point|2.7|-2.5>|<point|2.7|-1.0>|<point|0.7000000000000296|-1.0>>|<line|<point|-2.700000000000041|-1.0>|<point|-2.700000000000041|-2.5>|<point|-0.7000000000001285|-2.5>|<point|-0.7000000000001285|-1.0>|<point|-2.700000000000041|-1.0>>|<with|arrow-end|\<gtr\>|<line|<point|-0.7000000000001284|-1.8000000000000003>|<point|-0.2999999999999996|-1.8>|<point|-0.2999999999999996|1.0>>>|<with|arrow-end|\<gtr\>|<line|<point|0.7000000000000004|-1.8>|<point|0.2999999999999996|-1.8>|<point|0.2999999999999996|1.0>>>|<text-at|D|<point|0.5|0.3>>|<with|text-at-halign|right|<text-at|C|<point|-0.5|0.3>>>|<with|arrow-end|\<gtr\>|<line|<point|-1.7|-3.3>|<point|-1.7000000000000004|-2.5>>>|<with|arrow-end|\<gtr\>|<line|<point|1.7|-3.3>|<point|1.7000000000000004|-2.5>>>|<with|text-at-halign|right|<text-at|A|<point|-1.9|-3>>>|<text-at|B|<point|1.9|-3>>>>
  <|big-figure>
    The simple environment structure
  </big-figure>

  \;

  The environment is crucial to the evaluation process, because it determines
  the context in which an expression should be evaluated. Indeed, one could
  say that expressions in a programming language do not, in themselves, have
  any meaning. Rather, an expression acquires a meaning only with respect to
  some environment in which it is evaluated. Even the interpretation of an
  expression as straightforward as <scm|(+ 1 1)> depends on an understanding
  that one is operating in a context in which <scm|+> is the symbol for
  addition. Thus, in our model of evaluation we will always speak of
  evaluating an expression with respect to some environment. To describe
  interactions with the interpreter, we will suppose that there is a global
  environment, consisting of a single frame (with no enclosing environment)
  that includes values for the symbols associated with the primitive
  procedures. For example, the idea that <scm|+> is the symbol for addition
  is captured by saying that the symbol <scm|+> is bound in the global
  environment to the primitive addition procedure.

  <subsection|The Rules for Evaluation>

  The overall specification of how the interpreter evaluates a combination
  remains the same as when we first introduced it in <smart-ref|sec:1.1.3>:

  <\quote-env>
    To evaluate a combination:

    <\enumerate>
      <item>Evaluate the subexpressions of the combination.<\footnote>
        Assignment introduces a subtlety into step 1 of the evaluation rule.
        As shown in exercise 3.8, the presence of assignment allows us to
        write expressions that will produce different values depending on the
        order in which the subexpressions in a combination are evaluated.
        Thus, to be precise, we should specify an evaluation order in step 1
        (e.g., left to right or right to left). However, this order should
        always be considered to be an implementation detail, and one should
        never write programs that depend on some particular order. For
        instance, a sophisticated compiler might optimize a program by
        varying the order in which subexpressions are evaluated.
      </footnote>

      <item>Apply the value of the operator subexpression to the values of
      the operand subexpressions.
    </enumerate>
  </quote-env>

  The environment model of evaluation replaces the substitution model in
  specifying what it means to apply a compound procedure to arguments.

  In the environment model of evaluation, a procedure is always a pair
  consisting of some code and a pointer to an environment. Procedures are
  created in one way only: by evaluating a <scm|lambda> expression. This
  produces a procedure whose code is obtained from the text of the
  <scm|lambda> expression and whose environment is the environment in which
  the <scm|lambda> expression was evaluated to produce the procedure.For
  example, consider the procedure definition

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define (square x)

      \ \ (* x x))
    </input>
  </session>

  evaluated in the global environment. The procedure definition syntax is
  just syntactic sugar for an underlying implicit <scm|lambda> expression. It
  would have been equivalent to have used

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define square

      \ \ (lambda (x) (* x x)))
    </input>
  </session>

  which evaluates <scm|(lambda (x) (* x x))> and binds <scm|square> to the
  resulting value, all in the global environment.

  <smart-ref|fig:3.2> shows the result of evaluating this <scm|define>
  expression. The procedure object is a pair whose code specifies that the
  procedure has one formal parameter, namely <scm|x>, and a procedure
  body<scm| (* x x)>. The environment part of the procedure is a pointer to
  the global environment, since that is the environment in which the
  <scm|lambda> expression was evaluated to produce the procedure. A new
  binding, which associates the procedure object with the symbol
  <scm|square>, has been added to the global frame. In general, <scm|define>
  creates definitions by adding bindings to frames.

  <\big-figure|<with|gr-mode|<tuple|edit|line>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-grid|<tuple|empty>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|empty>|gr-point-size|5ln|gr-snap|<tuple|control
  point|grid point|grid curve point|curve-grid intersection|curve
  point|curve-curve intersection>|gr-arrow-end|\<gtr\>|gr-auto-crop|true|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|<graphics|||<line|<point|-2.200000000000056|1.4>|<point|-2.200000000000028|3.0>|<point|2.00000000000006|3.0>|<point|2.00000000000006|1.4>|<point|-2.200000000000028|1.4>>|<text-at|<verbatim|square>:|<point|-1.8000000000000664|1.8>>|<\document-at>
    <\scm-code>
      (define (square x)

      \ \ (* x x))
    </scm-code>
  </document-at|<point|-4.0|1.0>>|<carc|<point|-0.200000000000007|-0.6000000000000488>|<point|1.0000000000000102|-0.6000000000000488>|<point|0.40000000000004665|6.938893903907843e-17>>|<carc|<point|-0.200000000000007|-0.6000000000000488>|<point|-1.4|-0.6000000000000488>|<point|-0.8000000000000551|6.938893903907843e-17>>|<\document-at>
    parameters:<scm|x>

    body:<scm|(* x x)>
  </document-at|<point|-1.8000000000000487|-1.8000000000000576>>|<with|arrow-end|\<gtr\>|<line|<point|-0.8000000000000506|-0.6000000000000488>|<point|-0.8000000000000551|-1.8000000000000576>>>|<with|point-size|5ln|<point|-0.8000000000000506|-0.6000000000000488>>|<text-at|<em|other
  variables>|<point|-1.8000000000000664|2.4>>|<with|point-size|5ln|<point|0.40000000000003627|-0.6000000000000488>>|<with|arrow-end|\<gtr\>|<line|<point|0.4000000000000364|-0.6000000000000488>|<point|1.5999999999999992|-0.6>|<point|1.5999999999999992|1.4>>>|<\document-at>
    global

    env
  </document-at|<point|-4.0|2.6>>|<with|arrow-end|\<gtr\>|<line|<point|-3|2.3>|<point|-2.2|2.3>>>|<with|arrow-end|\<gtr\>|<line|<point|-0.6000000000000002|1.9>|<point|-0.20000000000000037|1.9>|<point|-0.20000000000000037|0.0>>>>>>
    <label|fig:3.2>Environment structure produced by evaluating <scm|(define
    (square x) (* x x))> in the global environment.
  </big-figure>

  Now that we have seen how procedures are created, we can describe how
  procedures are applied. The environment model specifies: To apply a
  procedure to arguments, create a new environment containing a frame that
  binds the parameters to the values of the arguments. The enclosing
  environment of this frame is the environment specified by the procedure.
  Now, within this new environment, evaluate the procedure body.

  To show how this rule is followed, figure<nbsp><hlink|3.3|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_fig_3.3>
  illustrates the environment structure created by evaluating the expression
  <with|font-family|tt|(square 5)> in the global environment, where
  <with|font-family|tt|square> is the procedure generated in
  figure<nbsp><hlink|3.2|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_fig_3.2>.
  Applying the procedure results in the creation of a new environment,
  labeled E1 in the figure, that begins with a frame in which
  <with|font-family|tt|x>, the formal parameter for the procedure, is bound
  to the argument 5. The pointer leading upward from this frame shows that
  the frame's enclosing environment is the global environment. The global
  environment is chosen here, because this is the environment that is
  indicated as part of the <with|font-family|tt|square> procedure object.
  Within E1, we evaluate the body of the procedure, <with|font-family|tt|(* x
  x)>. Since the value of <with|font-family|tt|x> in E1 is 5, the result is
  <with|font-family|tt|(*<nbsp>5<nbsp>5)>, or<nbsp>25.

  <\big-figure|<image|<tuple|<#89504E470D0A1A0A0000000D4948445200000136000000A90806000000A1FB118B000000097048597300000EC400000EC401952B0E1B0000084849444154789CEDDDE192A3281406D064ABDFFF95B37F363D2E03828A0AD773AA76933146EDA89F880AEF175F9FBB1700A037C106317CFEB97B09007A136C4038820D0847B001E10836201CC1068423D88070041B108E603BD72C37FDE696F353180EC3136CF1ED0DA777D7A5800B09B6FE462BE5D4026AB4E585C37EEE5E80892D03E19D19F6495EDF99CFBEC3D37049C77D17DEAFCD3F37BDDC77D265CACDABB6CC4A770C45896D9FEF4E9FDBA1D361B900290541699AA5F9972CA7530AAA2DF32D7DB77579E152826DBB5AA82C954A45B9525CCB29E3FBD5166AA5EFEE515AE65C491386503B15CDED803DC63DF29D919476ECDC29E9D79EBFB556DADAAA74EABC751E2D410B97AB05DB96A3F29E23F8AC47FD96FAADD2CE5EAB5FDB3AFFD2B0DABFF77E57FD1AC35BAB74AED5CDD42AC54BD3DF52E774A551960338E6F3D79B57DB91BE347EFA7E4FC9E22EA32C0770CC5F2DE8F6DCB9732533E1019CEE9FD7FA95BA237215D34EF580D3D52ABE6B378E9686D5A6F3FDACC715C35ED4B1410C9FDFFFE53E789827FECD10D16F1DDBDAC50380A9FCBCFE9C1246BE3729F2DF0624BE37E83E6967177210DC535AF7285DE098FD912E2063E460BBB2AE4FBD22043272B09D558A6ABDF50498D4C8C1D653AD01462090A704DB923083E09E126CC20C1EE41B6CB9479B6A7551E97B80212C5BF7481F527F5786A7EF0186B03C15DDDB92AB700386B20CB65A176E4B6E8F683B7DAF9DBA6FED42AFB59B3E78B4E52355A5966D5B3BFC78A265189542AB146ECB71BFE32F4FFB4BF5975BFB5880C7C995D84AFF4E3D7D47CA05D6DE1EA8D6E6B165FCADD32FCD03A6F694DB3DCEB00CB24F66D8DE69D4EC1DBF347F0847B01D93EB96AEB5AFD152DF9EE977D2ABD06BD357FA02FEA777E96586D2D00CCB085BFDD54B15C0F404DB39725794818BA8633B87BA2EB891121B108E6003C2116C4038820D0847B001E10836201CC1068423D88070041B108E6003C2F1E8CF1F9EEB0408E0CE305F6BBB8E714DB1DE9C8A72B7E177127EAD358A3A14C1C61D86DE29989F60035A4C7530126C5C2DB7834CB5D3B0B943A1CB0936EEE28A3CA7116C8C62D8A33FD9CEBB872EB50936AEB4B68330AEB57564FD319CBB8FB677CF9FEDA658674A6C4038820D0847B001E10836201CC1068423D88070041B108E6003C2116C4038820D0867196C533C2AB162F6E5073AF9F9EFF5F39AE761D634C0DE8BD799FE0EE0243FAF394B3A6BE125DCE0E1BE25B634084AA5A2DCF04FE17D3A7EADFDA677E6B35240E59ABF294D0378A05A53CD9FC56BA9979A96DE6BD2E1B96EBCB64E4733D3C7DCFD5BDD3D7FB69B629DFD1486E74A5FE9FB566B3F446E7AB51FCE6926B0AA74BBC7B79E2A3DB5DB9AD6CBE9B4AA8DBFB60C531C4D8073FDBCCA57134BF569ADA788B93AB5DCA9675A226C09A7521D5B6918F0507B4A6323196D796670F76F76F7FCD96E8A75B63C159DBDA433FBF25FA574C1658A0D165AEC7DA4EA93BC3217EB8DD04A57456B948E80617908FEB9D252B783156108B6E711608427D878BD841DC108B66712648426D8807004DB73BD93570843B03D9B502324C1068423D88070041B10CEDE47AA1843EB339FBD1B083D3A6D80BF6C698D634FCB1DADDF39DA2A8887F1E7639D718ABD1BD69620DC33EDBDDF632ED619DD1DDDA86ACDAA9F39FD1EE373BF29D6998B07F3E8D15F6AADE975F565C0A57A1E29D7BA3DEC3DED5EE3328629D69923F41C7AF76E9F7672DD7B3B689DE619F37E9A2982A6834DDB89DB3D9EA9B53730E610FDE0B0795B156CE3DB52FA593AA38477C6B4A13B170F6228F53CD5F2BD5A48ED99B61221B7126CF3BB2B400417C3722A1ADBD995F3B570137EDC42B0C576765DD8DAF45DF1E4364E45E7775778082D8625D862C8854C4BF0B454F2EF99B6D21A5075C603EC6987C93DA95BBBCE137EEBCD7FA312DB332D4B546ECD201CC1368799C2C76928B0498FDB2B4AE3F408CE59C2379227FCE61EA90AEEE843EB6BDF3D73DA332BED54EF649C2BEE17BCEAF7F5081DB7D85AEADADA94F856D14B0DA5669E3EAF6DBFEDDE79A7FFAD2D5BAF798E4489ED2196756EB59B646BE3EC9DF6DEE9CFEC5B325B5E78F90E3F4B5A32DC3ABFB489AADC3473EB6FEA752BD8E655DAA93E99717A4DBB34DE13CCDA694DBA2ED375B65635F1FDDE74EB59B0CDEFCCBA9EE936E8131DF92DCE6C42EA0CD3AF77B77BC0765797C04AF56BAD01F4B84E7694D860DD5ABDD627797F4649E7E815CAB48E2D5DCE90756CC432FD9196CD9EB0CE3D520520D88070041B108E6003C2116C4038820D0847B001E10836201CC136BF5253364FB87113B2041B108E608B43090DFE23D8E6973EA4ECE1651E4FB001E138AAC7D1A3E55CE6F3942A884DDBB4F6D8606E0E62194E45010000000000805F57DD2EF294DB5298840D32AE3BFA47BD84DB3DE0994A217376F85C126E6EEE1B4B6EA5BF339FE58695AC8D5BFAEC9D19B667FCD2672D1DF62EE7F37E7906B6B7DCEF5EEB9CB9657DD4C639AB63690697F62E5EEB817C6DBCDCF472E397DEE7FEDD32FEDA34F61CB1B52FD7DFDAF652FBAD8F8C73C97AF448D5D8D2D2CEDA46513BFAD6F41C3F5D1625AE39A4DBDAB4EB4A1DDBD8721B5ACBC6B665DCAFDAF8B9D394D6E92F97E7ECC065BF77E1FD52CBFAB8ABFEEED7B4891C58A99EE3687DDA96EFA475222DC36BF5686B9FA963BBC7D652D9D13AB6A94B811CA384C295DCC7C6256C00709062E15834160900000000B15C7921C3451308EAC8A343BD1F3BBA2368841B5D78F2602C47AE84F6BC8A7AE79DE3C28DC3DC52309E963BF8D7EEEA2FD972F7F75D2D3FB42E1F309952EB1E5B5AE9E8D19A4669F8992D3FACCD1B9A39151D5B4BC965ED39CB9EA59FA3610997116C63DBDB92C219A77267B7FCD0FA7DA85297319E1E756C3DEAB0AE6EF961CF3C8187E951FA711F1B3084DC050480A9E91F80C7FB17CD90419AB44BC15B0000000049454E44AE426082>|png>|310pt|169pt||>>
    Environment created by evaluating <with|font-family|tt|(square 5)> in the
    global environment.
  </big-figure>

  The environment model of procedure application can be summarized by two
  rules:

  \;

  <\itemize>
    <item>A procedure object is applied to a set of arguments by constructing
    a frame, binding the formal parameters of the procedure to the arguments
    of the call, and then evaluating the body of the procedure in the context
    of the new environment constructed. The new frame has as its enclosing
    environment the environment part of the procedure object being applied.

    <label|%_idx_3074><label|%_idx_3076><item>A procedure is created by
    evaluating a <with|font-family|tt|lambda> expression relative to a given
    environment. The resulting procedure object is a pair consisting of the
    text of the <with|font-family|tt|lambda> expression and a pointer to the
    environment in which the procedure was created.
  </itemize>

  \;

  <label|%_idx_3078>We also specify that defining a symbol using
  <with|font-family|tt|define> creates a binding in the current environment
  frame and assigns to the symbol the indicated
  value.<hlink|<label|call_footnote_Temp_343><rsup|<with|font-size|0.83|13>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#footnote_Temp_343>
  Finally, we specify the behavior of <with|font-family|tt|set!>, the
  operation that forced us to introduce the environment model in the first
  place. Evaluating the expression <with|font-family|tt|(set!
  \<less\><em|variable>\<gtr\> \<less\><em|value>\<gtr\>)> in some
  environment locates the binding of the variable in the environment and
  changes that binding to indicate the new value. That is, one finds the
  first frame in the environment that contains a binding for the variable and
  modifies that frame. If the variable is unbound in the environment, then
  <with|font-family|tt|set!> signals an error.

  These evaluation rules, though considerably more complex than the
  substitution model, are still reasonably straightforward. Moreover, the
  evaluation model, though abstract, provides a correct description of how
  the interpreter evaluates expressions. In chapter<nbsp>4 we shall see how
  this model can serve as a blueprint for implementing a working interpreter.
  The following sections elaborate the details of the model by analyzing some
  illustrative programs.

  <subsection|Applying Simple Procedures>

  When we introduced the substitution model in
  section<nbsp><hlink|1.1.5|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-10.html#%_sec_1.1.5>
  we showed how the combination <with|font-family|tt|(f 5)> evaluates to 136,
  given the following procedure definitions:

  <\scm-code>
    (define (square x)

    \ \ (* x x))

    (define (sum-of-squares x y)

    \ \ (+ (square x) (square y)))

    (define (f a)

    \ \ (sum-of-squares (+ a 1) (* a 2)))
  </scm-code>

  We can analyze the same example using the environment model.
  Figure<nbsp><hlink|3.4|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_fig_3.4>
  shows the three procedure objects created by evaluating the definitions of
  <with|font-family|tt|f>, <with|font-family|tt|square>, and
  <with|font-family|tt|sum-of-squares> in the global environment. Each
  procedure object consists of some code, together with a pointer to the
  global environment.

  <\big-figure|<image|<tuple|<#4749463839618201C800800000000000FFFFFF21F90401000001002C000000008201C8000002FE8C8FA9CBED1F809CB4DA8BB3DEBCFB0F86E24896E68976D0CAB6EE01BCF24CD7F68DE7FACEF750EC0B3E80C2A2F1884C2A973922D3E77C4AA7D4AAD51ABDD6B2DAAEF70B0E1BB8E25FF98C4EAB75E475A2ED8ECBE760B8DC4ECFEBF746BCDBCF172838E802A8664898A8988888D6B808197947F8286979195629A6B92581F9092AC359F7341A7ABA68EA05471111E359D1E03936C1D0EA0AFB0A548B5B7B7B1B812ACCA4DAC53A861C1C9CCBBB0B03F38B3CEBACFC4C6B4D5D3CBCDDA27D6537ABEC1CFE965C6D4B2D6ECE7B0E4CAE90122F3F4F4F8F45E9909DAC6BBB9E2FAD4F5D352701BD71DB746F10AB661AD0D162F786E1B4561910482462F0A096FE8C2F384EF10845A3C86E090581EC717224A3928152B279A732A6352A7E60421B92D2A5CC9D4274FE5B716C481F9E442755E112EB9C2B6813090E2D0A358D4F590BD23915480EE3D3A85C33B17C16EEAAD58733834CED8A16E8D75E16DB627DE5AFC8D9B474FB1DAD7AF1E6C35D1421F2985B3770592959AE1E128C7809E07211AF7DB1B93871DAC883F76602A654B2E6BF6BD758C86C316F2EB2BD9869DD2C93B239C2F140635B8A95316C81A879AA767D8822CEB856C386B6B9B79EF0E1C0A3DEBE2D2A296E75D3F6395F9DCEB8E0E373FC2EFF7551D785DF956322A7435DE18CEF9FC81BA589D734BFE2A5C6D73613383CE382AB3BE3346F09FF9FCED1FE983F7E6FD674FC3D87117EFAED74E06177A5571A5FFF018892800B9A046184F1D9075E859C5D38614B1AEE90A0541856F7211B12A2275E3EEC95B85C51F279F8138B31D2F5221F0BF926A35B75D5B8073839CE38D988E7D9258B095C85E8889071F8D8D391277E840F3AEC7883A4314F12162594D2718822855DBA78657B296A09559565F0A8876A667E1326315962B9E58E4AEEF725516B7AD5A18DC4EDC9679F7EFE0968A024D4E6D18A74FE75270D1C190AE1A28C2A8868A2A24021E998203E2A224A98921869A5305E6A5D869D4A92116639966A6A1EA886EAE54BA996B8EA6C69228A4B2406F9E2698FB4F263E3AEACF60AAAAC32DE0AD7A6085DBAFE4CAEF0350197B0B00668E90DCD19EB59483FEAB861ABD942B2E8B5D882F826B8A45AEB6D8B8A866BE2B816965B28BA4DE447AEB7ED469BAEADF15E3BAFB6E2DABBAEBCD0EA5B2FB7F7FE98EFA7DBA632F0A9FF1ABCAFC0FDE2BB30B00F2BD26DB9E6BA47EFBBEA1E4C70C4BA26ECAEB4165F3C69C63828CB42C5EC7A3C2BC826DB80F2C713B73C73C8308F5CB0C41CAF54338B39CBBCB3CD5BE0CCB2AA45BF3CB4C53FD31C34D2E72A7D34A73D037C32D12E4BDD34D522437DF5900D233C75A3CD524B959EE250C96DB168CB3BDAD7E0E19A759A6ABBED73DB01CBCDEBDD94D85D35DBAF26ADE7DF4FA72238C67E97AAD0AF83535C78C98787FD87E28613FE4E76D9ECAA1C78D73D566E39DB9A47FEB9DC908FBCB89D5CA2F659478DC32355EADD2897F2DBB00335BB50A81766A85F9277670C52B9E30E48A590D5847BEC9AAD1854E7CAAFB22C3C4CDA5EAD8A454A0F3D62C11349FDF21B192F5BF5D827A916EBE16B1F2449DD372FFE83DCD7E77DFAE0AF4F32FBDFD2E878FCF2F35EE7F88F247F462386995F95C454223A00741F9B1C3740F2310F81F53B5FF94A96C0EFCD29809A68839922584109A2C582C5614F0735983FCB50B04864B0E0FB9C079C66E1857C31CB13535258C2DAB9C63C317C950A23C2AA129EF037A182A10D41E82414DAD07732D4A195D2334424F61088DB13620F6B982A239EEE854F5422FE6498E826272ED18A22D861708627A51F1AF0813CACA216BB78C43306908B6BC41A15C1C84510588F8DCEA3A303F1A4C67210518C6EFCA2EFC2689D16E21187300424522045C82B42518A5E7BE30AADD8464201A92D0B51A0FAC648C949E22F534CBC6163B0181F13DA258288BC23584AD748FC11B0809204E1693AB22420BE92957D54E5264139C74862CB7FA99CA1292D193D4CB60396CFC2646168594AF91D1399A2BAE332E157A167F2AE26A29B5F0CC7073069CEEF91C3FA9F07F967B4B2202F7B7BDB65258129360CA42C2CBBF34C457E901752A9937604E11CEA3A21484DBE4E189C585DC7CAD426D2F50D4C5314A8C6082A2783C64D23F9149342FEF5969A803E7472B691E844898950FA5D74A0A62BE8461B88208B7E149B15F5E84899A9928666F1A48500486AC6A6D226258BA5F49CA977E676249CD27437ED3C455FBA020B67EDB48E3DF5A90C6DE3CFA11EF5204B45505277FA54544495A9533D69554151D4916415AA31D554578FB0559ADA131363E5E750CF8AD6B4AA75AD6C6DAB5BDFAAD0AF328D1B72055A5CB53A19EC6807577C118D5EF76A9AEE8475137AF563530E5B1ACB7CC61D441D4552B2A39DE028F6AF0D620BFBF8A6C54C65C5316EE1D5585EC3D955E252419BE5AC739A3390CEEA8536D3DB5A699D358E800C7320A7C143EEEEA7BEBED6A719B061EC0B07C3A8C1E251B7D099565F67FEE9DBD5927370C4550A6F115B5C1C29B7B52ABA9383641B1BD46A45B662B15D43AF1B97EC723736D0C12D696EB694CF12A8B7FE182F6849483B771ED61D0DA9D579F95A20E996D12490ED6F61EF1B58116606B3C9992F7DDF392576EEF5B797CD1B1C39F9D0BAB69462BAECDF46258CD270663237188E5C87EF7389B2C275C4242EB1894F8CE214AB78A21F3ED4D634DC3E877EC4B6A4348B88B1403C90A29756F0A4283A938026612E77742ED62775EDC74DBA55B8C7D324CF8DC793E0C9F6C77D3F550F75FF46D9B641D6B25725E46AEBCB48CCF06DCC9462E76F53C7485F32B8CAC4ADEF4D5E0BA7A0DA17BBD8A3CF4C1F1B5E3CDB94CE0502AD688929FE67CFB2F67B0F0ECD2F931668F60EBA8DB5EBAE7677AB17D1BE434DA79C4D738184A3D88EF296A825AF7DDB11E5818E2DB5EDAC274C0A8D64FDF9671FC13565143ACD5DE926719B4A00EF9CA75BE7F5DA547CB3E4B5A2ED3C5B3A632CD1DAA5A6A17188C2636F88D8BD2169985D4A5EF5AE12224F2E709F132B2B5172D9CD9F3C2A6513FB4ED27499875FFEA92DA5971507DBD8CC92CDF68F690BDD58845B77EAEEE56815E3B4434F388D2405A64B84976A52F4AAC5FF880CC1F799B9CD89A4DAAF3BF88A1F0EF1884B7CE212D786C315F6958B9BE27F14DF4AC643016778D6B3E36075F2C8CBE3CC14EA9BE42FDEF6689AF245CBC61CD2286FB73157CE729DC03107D8EBA8ED7CBE45F0574B499717D7D0AB3FDB1BE4D25BE8B4069B6095A9EC9CF74BD3D10EEFA2D31DF5108B3CDDFA95FABABE2DEF799E57B94C073944BDAEE45B4EAEEC6877EBAD02DEF6B30A37C971AFBBDDEF8EF7BC5B8DA370D73B8BF10974BFBB9DE3DE257BD1050F3453FD8AE387473C8C857A3FC63B5EADA6061ED1713EF9087F52B559C77AE6D14A636A4F09F39FD7FC41CD5BFA341400003B>|ch3-Z-G-5.gif>|0.5par|||>>
    Procedure objects in the global frame.
  </big-figure>

  In figure<nbsp><hlink|3.5|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_fig_3.5>
  we see the environment structure created by evaluating the expression
  <with|font-family|tt|(f 5)>. The call to <with|font-family|tt|f> creates a
  new environment E1 beginning with a frame in which <with|font-family|tt|a>,
  the formal parameter of <with|font-family|tt|f>, is bound to the argument
  5. In E1, we evaluate the body of <with|font-family|tt|f>:

  <\scm-code>
    (sum-of-squares (+ a 1) (* a 2))
  </scm-code>

  <\big-figure|<image|<tuple|<#4749463839618401B900800000000000FFFFFF21F90401000001002C000000008401B9000002FE8C8FA9CBED0FA29CB4DA8BB3DEBCFB0F86E24896E6293EEACAB608E0C6F24CD7F68DE7FACEF706EC0B2E80C2A2F1884C2A97412253E77C4AA7D4AAF59A88625DDAADF70B0E8B7F6356B78C4EABD7B433DBCD8ECBE769B8DA4ECFEBF74C3CDACF172838680338664898A8B8F8C287C80819A9F708462979895966E9B599E9F959D589250A5A6A6A446A957ACADA7AB34A05EB3A4BAB0217D180EBA0DB54EBFBDB63776B5B240B7C3CEB4441F64234F1C31B609C855C6D6DD6287DA0CC0C14ED5C7C2D3E4EBD2D0D6EAEADAE2E91DE4B0E7FEDDCEECEDE0DE35D1F1CCF8FAC4CFF0CDA3680CF02EEEB87B0163A6675123A74354FE09D87144DFD8B360AE3BAFE8A1C2F4D6BB28C61C7918C3E162B4832E52293BB50D0530933104B90ED66C6BC79C42694901B71FA5CA333C74B7D3F8B1E726434A9A666B896350DBA02AAD2A92DB8D9BB2A1502D5ADA398E6B397552BD7B153AC7E8DB8252CD9B5516A86D4186BAD5C256A79D49D4BF52E14BC7C85E815DA37B05DA4820BBF226C38B18CBF38182B4EE9B8D0E3C9D8F644A65CF1721BCC9C19689EF1B973BFD031488B8667BAEAE9D5A92BAFEEDC3AEA6BD1B189CDE65C5BEC6DCAB977EDC6DC3B97CBE1C48B1B3F8E3CB9F2E51C32C1B5F8DC79701FD19355F734B45476ECD75B6DD76E1054F84FE31596177F1E537A8FDFADB7E7FE5E124FF8F1A1AF578FEF1CF873D3FE853E05D6947EA704D89D224F15384841FDE5941F822B35B86021F93828537E022A4406852525E39D3811BED3212B1FD2E5CB887B89E861891CA2288F8A1085688D8983BDC8628C2EC268518A18D238A08EB4C8D8188EFEDC58638E2DEE28A47880710114913D16B9D9406DBD941B90272649DE2B5695D34C434842A9A464524ED996973FAEF8640D652AF095486258B92496D81D968D67751EF5659A46AAC96536682D95E79E8246391F7F77E279268F8346A9DA44816A27A79391CE09268092425AE92F7006A928A6363E1AA69E43829A65A6978ABA68A99F263AA9473EA269AA7AAF769A2AA5ABC28AAAAAD56C4A67ABF2CDEAABABB1B28A6BADCE013BFEACACC9D2BAECAFCD3E2B6CB090F04ADDA9BA7ABAABB5B61A4B2AB6B96E3B6A82CC612093B4968D7BC1177A4586AE0519B57B5F5A717132AF2A6575254595F5E29B2FBF7DF8BB84BEF7D23BB0BDFD5E7197C007CB5B70280DEF1BB0A30B03CC8586444D1C31C20FBF09B1C18BB9D9A8C7FF6A8C31C71B3BCC263E0B19CA28CA4FB07B72251DBB9C722E20BB4673C622EB0C68C9397769674F21FF9C04CC3ECB1C73CCEFB5591AC5453B8D84C22FAB3B84CAFA587CF1D4478FACF51F6DD467F3624E39A8C5BA50E774362A3B549075D57D3229E6C719DE9C329533772DB625468306B46C6B9B0336347657BD25CB7CF35D765528254DB85B056AB409D343DBFEC213209083C68BE461EFB5A6E2F19EA139CE15275E5AE020BA66A11F95BB9D39532DFBBD8EE50675F19FD06D5A6E1746177D209C30AF4F2E520A8C0FD113D98BBB1DB4DE4D83838853C2F916BBE8BD1E1A557AA15F2577F6568F1E6F38A3BB2E38EF9EB971BD6E66B4BEBB07CF87BD32F457B6DFD2F1590474119F793BAEFAEC776F3E3FF7A047573EF7E18C6D9E7B4E7CBCB13DDBF847418F1B8AD936268A7F004F371612DAF86AC2BAF661CD82EE835FEF7441BBEDED4E701344DAD64E18BF74E0AE8007CADF3786373FFA35F085284C9BDA08164380B089212BE419DDD04632BC214A883B5321F43C48BC20728D68519318119968B8242271874AF421FE0C4F37C42556B16FC94BA0F9F677C3223ECD4C4FDC1F0DC34742E9D5108B57AC1619B528C61FC6098A61A4A3F7BCD6C63152C3267B83E31ADD88C73FEA117C7EB16121B738C82C5AD18E7764241B0539A34096318F078923102D594745920887935C641311F94949FA118C99A4E4DF4079C99E7572958D24E52131D9CA37C1AB50AA9865F7A266CB0DE62E97BFE9A52F7F09CC600A7398C42CA6318F89CC642A7399CC6CA63381B90AC6502B9649746428E32607593CD02FBAE424FFAC49CDDFD5A17062CB171FC545BD0BD53214E42C5D36BD321075D64E8EAFE48FD55A48BE79189020FF01A13F1988C06E76EE4E32EC6740C3D7C22E9D7162B3F3E23CFE399845C885F06D833C4B37F4F3161E8EC9A220BC689D5A8795B815CA2C02B2E847D151B6810A51A2C86B9BC9D0C8C578A6339517E228E834DA129CDE0EA43055E7E12E36259DF290A7F6ACD94C2B9A1DB8E8EE9D31DD8E03EB42D2901A10A7C92BA9476FE7278FBE8E7659ED6848A3674442FA548BBA93A804993A3E7926709B054D17F26809D3B6AACC5D52EAA938A958D4BC8E8DAE6914085119F7D0797E289AB084E426BF88D77A825380CFACE6861A4B12D3CD41B290ADAC652F8BD9CC6A565B257C2CCDA61998081E35119769E766D564DA0BC6F44169F9D369B169BBA98E5610232C6AEDF8893FAF1015B473D1A7521D0BD10475D5A49D03E99A0A9BC75BB9A8B4AF874AAE9BBCFA55C3D556ACA97D2DDC8812BAB34682A45E256E3D34F70DD75AF7AE1B85273D851B57DCCE9580CC9548F0C63B47FB1D8BB173AC2E7C953B18E7DEB724DD8CE17EFF0BE0000B78C09625EC6C094C96C82D34B808E6CA828F2853F736B8B7E66D2F41293AE1B10415B8DFC57086B7325D0B17CFC31F9ECA86C31A6109F7B7C41D114678F47760161BC5C02E95B1270A00003B>|ch3-Z-G-6.gif>|0.5par|||>>
    Environments created by evaluating <with|font-family|tt|(f 5)> using the
    procedures in figure<nbsp><hlink|3.4|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_fig_3.4>.
  </big-figure>

  To evaluate this combination, we first evaluate the subexpressions. The
  first subexpression, <with|font-family|tt|sum-of-squares>, has a value that
  is a procedure object. (Notice how this value is found: We first look in
  the first frame of E1, which contains no binding for
  <with|font-family|tt|sum-of-squares>. Then we proceed to the enclosing
  environment, i.e. the global environment, and find the binding shown in
  figure<nbsp><hlink|3.4|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_fig_3.4>.)
  The other two subexpressions are evaluated by applying the primitive
  operations <with|font-family|tt|+> and <with|font-family|tt|*> to evaluate
  the two combinations <with|font-family|tt|(+ a 1)> and
  <with|font-family|tt|(* a 2)> to obtain 6 and 10, respectively.

  Now we apply the procedure object <with|font-family|tt|sum-of-squares> to
  the arguments 6 and 10. This results in a new environment E2 in which the
  formal parameters <with|font-family|tt|x> and <with|font-family|tt|y> are
  bound to the arguments. Within E2 we evaluate the combination
  <with|font-family|tt|(+ (square x) (square y))>. This leads us to evaluate
  <with|font-family|tt|(square x)>, where <with|font-family|tt|square> is
  found in the global frame and <with|font-family|tt|x> is 6. Once again, we
  set up a new environment, E3, in which <with|font-family|tt|x> is bound to
  6, and within this we evaluate the body of <with|font-family|tt|square>,
  which is <with|font-family|tt|(* x x)>. Also as part of applying
  <with|font-family|tt|sum-of-squares>, we must evaluate the subexpression
  <with|font-family|tt|(square y)>, where <with|font-family|tt|y> is 10. This
  second call to <with|font-family|tt|square> creates another environment,
  E4, in which <with|font-family|tt|x>, the formal parameter of
  <with|font-family|tt|square>, is bound to 10. And within E4 we must
  evaluate <with|font-family|tt|(* x x)>.

  The important point to observe is that each call to
  <with|font-family|tt|square> creates a new environment containing a binding
  for <with|font-family|tt|x>. We can see here how the different frames serve
  to keep separate the different local variables all named
  <with|font-family|tt|x>. Notice that each frame created by
  <with|font-family|tt|square> points to the global environment, since this
  is the environment indicated by the <with|font-family|tt|square> procedure
  object.

  After the subexpressions are evaluated, the results are returned. The
  values generated by the two calls to <with|font-family|tt|square> are added
  by <with|font-family|tt|sum-of-squares>, and this result is returned by
  <with|font-family|tt|f>. Since our focus here is on the environment
  structures, we will not dwell on how these returned values are passed from
  call to call; however, this is also an important aspect of the evaluation
  process, and we will return to it in detail in chapter<nbsp>5.

  <label|%_thm_3.9><with|font-series|bold|Exercise
  3.9.><nbsp><nbsp><label|%_idx_3088><label|%_idx_3090><label|%_idx_3092>In
  section<nbsp><hlink|1.2.1|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-11.html#%_sec_1.2.1>
  we used the substitution model to analyze two procedures for computing
  factorials, a recursive version

  <with|font-family|tt|(define<nbsp>(factorial<nbsp>n)<next-line><nbsp><nbsp>(if<nbsp>(=<nbsp>n<nbsp>1)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>1<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(*<nbsp>n<nbsp>(factorial<nbsp>(-<nbsp>n<nbsp>1)))))<next-line>>

  and an iterative version

  <with|font-family|tt|(define<nbsp>(factorial<nbsp>n)<next-line><nbsp><nbsp>(fact-iter<nbsp>1<nbsp>1<nbsp>n))<next-line>(define<nbsp>(fact-iter<nbsp>product<nbsp>counter<nbsp>max-count)<next-line><nbsp><nbsp>(if<nbsp>(\<gtr\><nbsp>counter<nbsp>max-count)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>product<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(fact-iter<nbsp>(*<nbsp>counter<nbsp>product)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(+<nbsp>counter<nbsp>1)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>max-count)))<next-line>>

  \;

  Show the environment structures created by evaluating
  <with|font-family|tt|(factorial 6)> using each version of the
  <with|font-family|tt|factorial> procedure.<hlink|<label|call_footnote_Temp_345><rsup|<with|font-size|0.83|14>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#footnote_Temp_345>

  <subsection|Frames as the Repository of Local State>

  <label|%_idx_3098><label|%_idx_3100><label|%_idx_3102><label|%_idx_3104>We
  can turn to the environment model to see how procedures and assignment can
  be used to represent objects with local state. As an example, consider the
  ``withdrawal processor'' from section<nbsp><hlink|3.1.1|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-20.html#%_sec_3.1.1>
  created by calling the procedure

  \;

  \;

  <with|font-family|tt|(define<nbsp>(make-withdraw<nbsp>balance)<next-line><nbsp><nbsp>(lambda<nbsp>(amount)<next-line><nbsp><nbsp><nbsp><nbsp>(if<nbsp>(\<gtr\>=<nbsp>balance<nbsp>amount)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(begin<nbsp>(set!<nbsp>balance<nbsp>(-<nbsp>balance<nbsp>amount))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>balance)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>"Insufficient<nbsp>funds")))<next-line>>

  \;

  Let us describe the evaluation of

  \;

  \;

  <with|font-family|tt|(define<nbsp>W1<nbsp>(make-withdraw<nbsp>100))<next-line>>

  \;

  followed by

  \;

  \;

  <with|font-family|tt|(W1<nbsp>50)<next-line><with|font-shape|italic|50><next-line>>

  \;

  Figure<nbsp><hlink|3.6|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_fig_3.6>
  shows the result of defining the <with|font-family|tt|make-withdraw>
  procedure in the global environment. This produces a procedure object that
  contains a pointer to the global environment. So far, this is no different
  from the examples we have already seen, except that the body of the
  procedure is itself a <with|font-family|tt|lambda> expression.

  <label|%_fig_3.6>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#4749463839618501DE00800000000000FFFFFF21F90401000001002C000000008501DE000002FE8C8FA9CBED1F809CB4DA8BB3DEBCFB0F86E20595E689A6EACAB6EE1BC1F24CD7760ADCFACEF73E9AFB09874459B0884C2A95C7A5F3396C42A7D46A496ACD6A4FD8ADF75BEC82C75B31F98C7E99D3ECE4BA0D8F2BDEF2FA8D6ECF9FF1FA3E8BEF1758052858E840689818A6C888D3F838850859283969095379A997A9D909E4A9C9093ADA204A9A667AAA1AB3CA98DAAA2351FA26CBF30A5B869B5B0A71CBE0AB3B18EC546120551B31618CCCBA033C0CF50C6D1274D4546DBC8C60DD233DCDF48D94837C9DDD5C4DDE1DBEB91EA57C50CE8A2E0FAFDE5EE77D3FF74E016FCDDFAF5F2C7D72F2113487708C28667FB6F95BC0709AC183B5227A31F52CDE9CFE7B1329BEB3F2B1DE2C80DC2A865C16D0244974B22C2463C9EF52C7835F8A89E4C5101BB797319BF98C370E9BB6044267EEA239AA18AD64FE5836ED223021D0733751A234AA052B526723482CAD682E68588821CB15654A5524CC915D156E05E5724D5C0D56F7A9FC17342589AB79771A71FB5666549F48B5AE301CF8C949C234113B4A7CCAB120C95C20D3D0DB522C15CA7E385FB13CE32C3DC64B3CB303631A97C0B3A9AB16060C5ACDD873AD13BE461DDB48E6D5B54913EC0D31B727E070881315DEC9381BE5AE913F628E06BA6FE789A493916E9D7AE8C4D8B54FCA8E3BBCF746E06BC21EAFA8FCC5F3E80DA93FBABE7D7AEEECE5077A9FB5BEFD3EF8FEB374DF4F097DE201D89980E611789F81F121C89F82F03168477F20E90761715D5D8861861A6EC82108157E18C91D128248A243352C56628AD1D930988A2E52D8428B2FCE98DF6532D2886388366A96638FD1D81883453E0E190590F310892411D28C98647B4B360965912C4649A53D275689E51D5A66C9E55F537609668C5B8649E6275F9689662F63A6C9667067B609677398C449A76D5ED609E79378E6B9E69E68EAE9679A80065AE6A0848669E8A15D26AA68968C365AE5A3904629E9A44D566AA98F2DBDB45DA6546E2AE4619E469AD965A37E7AA398A7528AA2AAAB5EDA6A43AFC29AD1AC50862AABAD9032A9AB7B6EF4FA2166D464400DB00C868AFE2BB278F06A6C1CCBFEF2D903CC36BB5C65C7157B08B5F221A211B6D06A3B5E257E59EB26B8DA896BE715624C6BEE822A8C93EBB5ED226746AACA0AB9EEBCCEAD6B1351FCDE98AFBEC241E5D23E64F56BE24602E74630C20FD975E1C20C1F0C70C3004B8CDEBF28E2EB70BA184FFC8BB26C7DFB317572F1329DB4257B572FCAE8AECC32C9F2A62C33CCF4D66C2721ECDA7CE0CC1EF3B133CF351DE373D1FE0ABDAD5FB80E7534D2FBED356CC74EDB17F4D4C3591D29D69F6A4D29D7B77A7D29D849562D7675F0A255B68B29A54DA3324BB37D6CA970BF98EADCC1C66A378478E7AD37D97CFF0D78E0820F4E78E1861F8E78E2CE8A28ADDF8A7B7BA5CA8F67FEC51B4CBBF1B4964D98ED36EE53754975175E574D1E3933FF6CA499503F21940ECD47B2EEA6686A916E6A58AD3715E45AA0DFCE34CAF2F0CEE968C7EC4DBBB59BA63556EAB0CB3E55B64CA9DEBC68B217EF42E50563AE3939DAF7E579BAD6738F7DF6A2532F1BF9E19ACFF2DBE8AFCF7EFBEEBF0FFFBEA54909BFFAEACB7B3FDADB3C6B8BD1EB038D836EA9A95CB3B052EFDA1795EDF5E5780AABCA4A745739023EF061A552CA601CB72B6DE8447A9293D3066D07968479301B21E420F2E484BE9290502D6F23DAFE3E489B9B2C6678303421F41AE8BE79D4F061CE7360F28AD213D5F9901E259CCD0D4F57BF8F28F0752D1B5DF88485B928E28F2E68DBC0FEE730682E4050062B58D4D6D9E2C79D2E82718C642CA3197BF4B25688F1502EFCDCECD4D53854F88F7CC9220B0F7BE8BBEB340D812FEC9E6B42E72F9588708275691121D152C1CD89F07F38840A0163A711470AEF5A0153DE2447C39835EE090B02B40D2013E6144F169130328AC9284D98C9F7717291A08BD6F1C6654323529284B1C4E417F3A738BC2C5061F7FB1E4FF8523025E6848A4B0C26F0F8F82ED59C7199CC6CA6339F09CD68BACA0764D3240E69D635FD91AB83D16ACED270F99890C571458BB4E6773A77229D198D0EF9F8E600F7B0476D62E91A2BE14BF03A46CFBB4891341174E0273975B1C609D29F96C3DD2FFBB84F933C4F917F449489FE5E391BD8A5F28D3764E5EF4019BB8862F2A186EC1D3A2FE9C24A225296B6BCA6399F83D1D548E58DE5D465431B184A529EF28592EC614C6948523F1AD492B59C280AB3693BE1E584A543649EEB34285192B2C67B0384E84A419A5359CEF49241BA2338D1E8C77AFEF27A3214E6F8F839C1EF1933A67374A205433756833E652FC514DF4BC9C43F8F71B34070296B9C142A4D68D42DAF7CEDAB5FFFAAA893D2512EB5022C8CE4FA07C116AF9F3FF9A756116BD81FE94F8814F5E453237B9450E294AA4E842C66E7F73C8DD692798AA59D581F98D62B7E568DAB6DAD6B5F0BDBD8CA76B63E2B2D9BAC17A3ED5974B73873632F34F6564676329C9E2DDF352168E7107AEE8F8F91C4ADDC701BBC422A308A0E5B1BE72068CADA92317A396DA30CCB85CA802975A41B35E9761FCAC38A7A7384664DEACC38A8B4A5F0969195A5AA77251AC9EEFA14AA53B5E31D55E9B6B35A4EC0BABBA757B1E746F16180BAB1BA2F6D03345F4D1400003B>|ch3-Z-G-7.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  The interesting part of the computation happens when we apply the procedure
  <with|font-family|tt|make-withdraw> to an argument:

  \;

  \;

  <with|font-family|tt|(define<nbsp>W1<nbsp>(make-withdraw<nbsp>100))<next-line>>

  \;

  We begin, as usual, by setting up an environment E1 in which the formal
  parameter <with|font-family|tt|balance> is bound to the argument 100.
  Within this environment, we evaluate the body of
  <with|font-family|tt|make-withdraw>, namely the
  <with|font-family|tt|lambda> expression. This constructs a new procedure
  object, whose code is as specified by the <with|font-family|tt|lambda> and
  whose environment is E1, the environment in which the
  <with|font-family|tt|lambda> was evaluated to produce the procedure. The
  resulting procedure object is the value returned by the call to
  <with|font-family|tt|make-withdraw>. This is bound to
  <with|font-family|tt|W1> in the global environment, since the
  <with|font-family|tt|define> itself is being evaluated in the global
  environment. Figure<nbsp><hlink|3.7|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_fig_3.7>
  shows the resulting environment structure.

  <label|%_fig_3.7>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#4749463839617F01E600800000000000FFFFFF21F90401000001002C000000007F01E6000002FE8C8FA9CBED1F809CB4DA8BB3DEBCFB0F86E24896E64942EACAB62EE0C6F24CD7F68DE7FA7EC3FCAFF30187C4A2F1884CB684CA6682E98C4AA7D42A0F6A3562B3DCAEF79BDC8283E3B2F98C5E89D3B335FB0D8F2BDD7215BD8ECFEB5FFBD8BD0F18B8F727185178883898E840B8E8F828D518281941C9C02424B1A009D98967A9C877852006EA793A659A075561307100C349B1D9FA5A693B7B1B5B2BDB6A880A7CA4FAA9B0FBE4FAFBBB8B8B0C4BFA6C280B8BE5531D7C8D345C475D395DCDA97B69DB4CAE9C9CF9D40B5E8CD2EEFE0E6FD2A54DBAB64E5BC42D6DBE5F3A9E1CAD99B173D0BEDDC3B66ADE0E3777E8314A376B83AB8313D565D26441972FFE8DE1CA218CE310872A5FAC2EAA833624E4C795F914B6218749E044942A37B1BC69A6668D91DDCA592378CB19119D388BDA20FA52462E9F32BBFD04F803A9D1A9A2B28CC4350E5C2E5E144552FD9ACAA51F9468A4823D7B49EC8B6F6FCCA27D2BD42A8DA5F30EBA85FBF62E0BBD51327AC40BD82B17BEA922063E9C833004C56DDC41450CB9AA15C64D32528E8CF072DA441B1F63FEFC70F0A27F7F419B2EA6D693E6D3AA532F79C5ABA75CD6B48F894EFA33B7EBDAA757A36EDC0F99EFDFE96696E63D75385951BA8DDF2EEEB42BF2A2CAE32AC548B2BAF5694CB74F67A9DDF3237FEBC27FFF12DEBC3071E51B60387F2A7D30F231F7C26FFD3C7E5A8BDEFE6DDF1FBF1B8029FD07897CC098A51E810B05E808820A36C8E068433D28617EF8019120853D44C8D9841A1E62202A0E7E584888FA0D48A220265E18558A2A7288C8882EF6B1622732CEA8478D057A88638E3082C8638FC45868633C461E8964924A2EC9E492BC651889745F2128257C503A41175C545E29E04D59E63514690A7239C7976749D5D9836466B34C606862F7E19AC22C23E76418C256E78BE059532575774693E724C921861446C75939E8616E055A62A25AC622DB822932DA125E86F6A9948B94069997998291B8298A967ABAE1A48E3E2A66629A9E8A2AA714868AA1A29826052AAB8FBAAAA6AD38C21A4A194DFE2AD194ABE6742255BCFA48FE2C8B5568A0C67B9269C8E5B16A0C660F43D52E31ACAFC552F1472976D8676AB236DA39AD7F8B955BABB83B722B1925DD663B86B4DF86D5EE580FC8BBCD19F8DE5B58A6E2F10B70BADA2A3B076EB46E2670BCDB56E69E740EA7FAEFA1FF45BB70C1B440DC955FE6DA146E0F1BF1840F238A6142B27BF44264264517706C72C7A502DA2D3708B7AC85564D79DB177B296FF10EBC47411573560D9F641D5659F177E853901EB71ACF1AD77371CA42CE7CD43D8DD4D2727BA535C78AC442A1830ECB58EAEC0FD93C4F2DF6CFC455E401CD066DC78C39F560AA34506B33CC5EC343E38CF6723BC5E52EA96CD5FDF5CD869F1B5DE2695BBC784107F71DF16B1141FECC0E6C7BB34D27E67E1D1D36CA15794373CE8D176E2FE4FDF5F5CFBEA14542355996A80EA455328FCBEEDD703F6B3AC5048FBDB1D7889BEEB717B0B78EBADFD7060CFCE9445628BB4F0D393D7C87EA76496D9AF73E9D7CEFC2573C5BF6B8FE084886D15BAA2FF7E47A2FAAC2BB9F8F7E8BD34308C6F85A96BFFEB2EDA71FBFF9F6DFEFBEAFC0FE8FBDE5F14F6DD4911FEE0648402FCDAA7E08F4174E28770D03A24582CD82E0811A488607926A3E185495063728A20E7E6A2597A2E0EF4438170D02EA81284CA09754C896161EF02326BCDE0A65D82C65D430742484130EED00A90552AF8703F9E1627C081EA380D088DEB0A0FE22E8442672848505DC61FE15ADC8C33D49B1824ADCE26784B82E2F8A9171632C63A5CC88C658112A2A7400A302AD77BD250A6A8DFDCBE204A177C4CA8591465BB108760CC29FECFC114FFBA8DCDB8A364893B08D81496BE31043A1B548C92438DDB908E9B2561FCF2CED294D7924F10831BE7D854D6873130E20116933A805EC90403394DC9AB8C713464E7BE16B945360E2B81BD6AD3900E124C75CD9397E1CCE97B1C396EF6C574B15194D63C1E21CE896B2159D61AE23CC0ACAE79867CC598E0E59734C23F1BE650AD889D29B76EC086AAAC5373D85CF8D46A48FCAC403476DC2018B6374A7CAA027355B92D3931A7967D452A53A7A9E0780250819CA088A5076EE339BA233A498FE001A40792ED44FB53BE8D9DCF94D21D14DA067645DA618524EB481F23BC309A724D1953C689A844E85848C725EA7BC908A74267CE21A6BAA2389AE3134A5CEE0D3D7146AACEEE59196DBECDBE04C09138E4A6A320D91694C8D7AB426C690691B53AA44D7230E1B66B58C56CD605D9C15C7419A716937E5A71781AAC44D7675A2530A225AD95A4F24C275AE173B295DEF6A4EBCEA35AF7BBDAB1CFBEACDB70276B0842DAC610F8BD8C42A76B18C9D4E9ED6DAD8BFB525B20DEA2320FF38C5C92DB39FE6C4E3147B0227AE0896B2F98B94258F3110C275329523D5E53071495AE9E9309841492D2917E9918DD6F4B5AF842C5E8F6A3761523220BDCD65D690FE2A379B0A27B6205AE6C732704D6BD69673B4D55C76A4BAB9D1325780DB6D6777E3EADBEF8A77BCE42DAF79096B528A9E576F43DD29C9CE26CF2A69570B445D6F7CD7B23AE8D81599F5DD9E2AED6B48EE2CD23233A3EEDDFCE839E9F612C1D7CC9273051C5AE83ED5BCC04D6D275B9749ED39D2B4FD51EE256D63E1E41E2E780006DB7205D2A7D9C1133A691A652A4127E2B951431A9454AE8A01FC537E28ADA9E64A27DD680A5BDE7AD870357EED69712C630167B6BA8023A43F676559B1F6539030C6EE75ADABD90923795E5C9E2136C20B3CB26E7980F31DB399CF8CE634AB79AF8411270DFB8BC0A9EED4A9556587C8BEA7E4ADB221C357CDDE8BD9E8FEDEA2F6792F3CCE6F59FEBBDF3827999A59FE2C2A4FF9B1A829F8BDD36CF043814834E75D16C60E6630688D215ADA82395F391EF228D7E6619D82B873F0E5E585934A1A393379C8AF043168857C3B122B1A70D4EC4EAD73BBD25CFBA74DC0A6F597DE8562511779D1A5746D8C559B5B1CD60798D185AD8A531DB94306D3C623D672858B86EB5FEB66D9BC542BA251186C4B07D27AE996EE6D932C5A2C1BADCABA862547A2BC32775BAD9A5AE1774B07EDE72E83C2CD9981F359E5BC66C8FD35E10C6FB8C31F0EF1884B9C8413078B7C7532EA8A173A311997B8655DE7E9CD6AB9E217E4F0D6BA5DEB8E47DCC5CA3676EA489E286A5732DC4786F91B378DEF99EC2AF298364754CF7F0EF4A00B7DE8442FBAD1DD6470A147792EFDE6337FB719C53CDB1B6847B789D39FB5283A374ECCE55139997B29D501DB1669A9239A661319E0088BDC30AAE6B9D1A7CD5BAA0FFB9723B6472E771BE3B4791DDDC665ADB079FD9B6806B7C7446EB2A1F72E42B83FFBEFD6BEFB6A35E9786713D33989AEBAD8CF2E6F96E2D69A1FD7F94133AF794FB5DDF2BD493A600B00003B>|ch3-Z-G-8.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  Now we can analyze what happens when <with|font-family|tt|W1> is applied to
  an argument:

  \;

  \;

  <with|font-family|tt|(W1<nbsp>50)<next-line><with|font-shape|italic|50><next-line>>

  \;

  We begin by constructing a frame in which <with|font-family|tt|amount>, the
  formal parameter of <with|font-family|tt|W1>, is bound to the argument 50.
  The crucial point to observe is that this frame has as its enclosing
  environment not the global environment, but rather the environment E1,
  because this is the environment that is specified by the
  <with|font-family|tt|W1> procedure object. Within this new environment, we
  evaluate the body of the procedure:

  \;

  \;

  <with|font-family|tt|(if<nbsp>(\<gtr\>=<nbsp>balance<nbsp>amount)<next-line><nbsp><nbsp><nbsp><nbsp>(begin<nbsp>(set!<nbsp>balance<nbsp>(-<nbsp>balance<nbsp>amount))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>balance)<next-line><nbsp><nbsp><nbsp><nbsp>"Insufficient<nbsp>funds")<next-line>>

  \;

  The resulting environment structure is shown in
  figure<nbsp><hlink|3.8|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_fig_3.8>.
  The expression being evaluated references both <with|font-family|tt|amount>
  and <with|font-family|tt|balance>. <with|font-family|tt|Amount> will be
  found in the first frame in the environment, while
  <with|font-family|tt|balance> will be found by following the
  enclosing-environment pointer to E1.

  <label|%_fig_3.8>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#4749463839618001FB00800000000000FFFFFF21F90401000001002C000000008001FB000002FE8C8FA9CBED1F809CB4DA8BB3DEBCFB0F86E24896E6D941EACAB62E03BCF24CD7F68DE7FACE27710F0C4684C4A2F1884C167FCA2684E98C4AA7D4AA0B6A8D62B3DCAEF7ABDB8297E3B2F98C3688D3BB35FB0D8FF3DC721ABD8ECFEB17F7FDAAEF17288806380863889848A878C5E8F85855F828A946D900C524C16709D9D9C499C809FA8079E879FA356A8855519919F143B1293BE1AA097B4BDB5A8BCBAB8A0ACC172CEC035B3CF48A2C3BC4AC8650AAEC5CA9102B3D7C7DF32BB815738BEB7AB04CCD6BDDCCDC1D9EFE9C4B8EED2EA3FDE4E60D13EFC06D7CEE9C5BBE4E5F5A2D5A3368B1DABD3BF8C7089D3EF62EF9D8A501DCAC82DE6A59E8D5CA5637FE726B581D43D8A961B865AC32F9FA474424C8957854EA2B17B0E03375415CB2BCC9C6E5469A2F93714C8933282A95E2CCC59C16D05C0F9B429B7AD179B2A24976160D86718A5511D199699866FDAAA58DCCAE60CBEE814A2F8B55AF66DB023D95B19FDBB966D896D94537EF19BB425058D40B180C5FC1B4021BE6321871D1C4871B3B849B56A9E3C94718D7A58C1909DA8D55F359B19CD9B14E6947254B011DFAF066D2FBBAA04E1D7874CF91AE374D930B3BF7C7309A2E7AFE6CDB9855DDC44D0713C38FE7EBE2D7963FAD87127A5CE67A9DD79EC8352175C0D6114BCFAEA2FB763FE2810BA39AECF178BAE523F55D9FB73D15B6F2E1C7A97FFABD7DB7F8FEC3D6DCCF1F42F401D8567F4E0C486059067EA25F825F2DA804820E66056112124EE854859A358861531A56C66187417DA8508822DE44E2127EADC8628B2EBE08638C32B2085B8A0A4576626836A6345C8E98EDD8578F3E4E06644D450DF9A3809C21995A914B71E6249364BDC30F8E52C6C65294574E0992965BEE95E59749AEE4A5986394D986994486A96663685ED5A66A6CC6892599741AF6660E793EC1679FC47CB967365C1A27A89FD49859E18C8A86D002347002320FA29785D42857517D439B385551F51045D6440525A6EB25EA092517E185D14C911D355D5249B1F6DB74D4914A290B001DD3D16DEA5493AB32AE2617DD7EB44262AAAA0421F7FE12AC3B1DFA4D4CE89C231580C34ED2A84FEC4894CE62CF7AEA8F2D03FDE52BB6E34DEB48A07492CB88B971A2ABD59D83B01B8ABBDB4C4AACBC81C08B88BA6DB26B256D1BFAABEB9F95DA501A4FDAC1495C43BE11BA0EB30EABC7A34FB00A6CEBA3BB1DAC277322BD22A43F8E76CA2D4CE84DE52D6E133F4B68B10CABEC51236916B7B15292A0CA6CB0C8CE6669789F0E043129BD5DDACEB2BEF4C3515ABAFC4C51D2121D59236F2DDBCAF4CEA296541AD590EE9CDEC37DBEFAAA3E55E39A2AD152F34AB6A61A230C1E461C98D29BD4CABE9DEC3D48EDD42FCBA4253752DB38EF6A5ACB4BE28C32CF30239CB5CFE08E33722F1AF95674E125372E77C55E6FFE3B4E3E05B3B6EAB194433B96E567E3706AC71A199C6EB53D759633DC79AFDEEDE47A2B8D69D43AAA854FADD8883EF85DA536473A7CF8AE727BBFE3D24BADBD67115FAEF1C7EB6EBBF275FCFEEEC0183BBF14F2A54B3EFD0C4F2B0FFDBCD8476ECFF6C6777F6FB5267D1BAAA88F63D0BBBBE49337F0E5AC2E06B7F8F6BEBFBC76E7A71EF8437977ADAF2ED56551045C9BE4F6C73781806D3601445196366693A095E4745663DD4FD2B62F3209EF0A1B041DF5FCA32485E1AE061DFC20101A68BE12CA638426BC4F9764974215B6F00D28841A0CFFF0B7197A8F4AE890613D14A8C3FCB9A36D3EAC1C108398871A866773854262F9ECF4322726715B4A24C5FE1CA4A8072256D18A51C4E2F37E26A02B7AB125B2E25D17C70887329AD169056CE30DC5F446B804E87E454C5E81B8B7454381258F5EE4A307D1D8BC3D0232900FBAD2C27018C7279AC58F5FE4460733874246126C480CB9C41D1AE825376AF2905829C4CDF418BD24CAB190DF6398D676F8BC5176F2058E0325FC44B93B0AB1B27D5C0C654B54E921ED99B267AFBC652C33F49DF3448E62BD4CE52F85D21135F6EF7FBD42A51CB628C952321347D4E4A4C97C89CD7A017322C349A63281074B423A909BD524E726CF99455C8E483ADD448E3577993B713E909CC2E4A62908044D59FEF0100BE1A57DBA03A9A2492F97F7ACE72C1D04509DA54EA1AB24264DFE4481A19925EE366084C8053BE53657E2A49917B3443499173FCF012EA38F41D9CC04794AB149535AE6DBC7D7F656AC5616B493F62BA74685754097D6EF64A624DB6F6A895295FA136011B521FB3CB3016CB993642BA5E9510D07BB13E5333E24FCA80B8F39471D4E953D48DCEA5CAC0A0CAF66758662DD23155B58D6079DD5846955EBB2D8AA4E058111AD71352B0BD75557BB8215AB76FCEA5DF7754E74C667AF834411610B8BD8C42A76B18C6DAC631F0BD9C83AD37A92E56A4E9EA94B016AF0526A8B1D498E7AB44DC954B4FBAB68686DB4BD6E5ED37FF74891FD86183004F20D5830F994C41222B49D0A2E27FD0CCE4F67EA50C1B0368C772BDCD0D0FE23B28A0CD7700279A9ABD2D83AC575346915541F2626EA59A34DF45A48EBEEC7A884948CCEEF6D0523C8D69AAB5B8E5D76371CA5E5DDB273B3CBC52D67AFD3AD640EFBD90B4C33239C6D56E3469B015D25557DD6FBAEC1B03B36E5B64EBE4C3BEEE65E7A5F28C2F1611C2DA14C9E9B40E7AAD4A71AE6996CC1ABA6A94029BE9E0455FA060C398FE9572A019EDA6633080F095776C634AEB18D6F8C631A5BF8B039862E43DDF7584D89B8B3F09C50E7063ABEF0A277BE8694291AD58B8C5DD511A11E5BDFA64677A70BEBF45B307E2F8405C7E32C0A14CBC1EA280613065FE9BE15CC4FC6AB945DF7B4AE05719980FA9F05414564274EB94357736F8F0175FEE43F9FEBAF822EB4A10F8DE8442B3A7B8BDE92CA48B7C13D37DAB048FEE45027BDC82A2B2E2E4B0D9951B08B674CAF71A442B594A3E23BB1548B7A28C335DB99AD655CDACA8CD0AB5624A9A30C3E269A97D472AEB5ED84CCD4BE9958CD11999AA47D1D4E642B7BD9CC6EB6B39F0DED684B1B6D61BDD8B441B8CF6C2F226D61C6E223810AA68611F5DA115A22A7928BE5EC522DDDDC1D71D84A4D6E0B311357BB5E20004DE6535E935466F13E1043B9B5EEBD956CC122ED7084CFDCEFB770B1BE4649AFAAC7AB6F0F13F5D8098F3154176762C6B11864FA456AB12FBADA8AFF67D44516B9C94F8EF294AB7CE52C6776B7FB1D69D9B4BCDAE0CEC6CBC99D5FB7F00C7B69419B39CD6D460C06D7D6E7AA0C59C019DC73A2C792E10D8FF8AF945EAA61E717B41B0F39D4A97AF5AC6B7DEB5CEFBAD7BF0EF6B0A319E13E9FBA1DAA1EF29342C774D8E1B7D603A78DD7529BECC32C866C293E6DB8CF7BD3420BB5048D4EDA32EA4238665773D3FDACF45D43B8A6BDBBAD7C754EDE2F9B19ECF556B0711DF64992A81AF20C7C686F114F74C5AB8EF1A9763CE604F635592753DC5E3FED8903CCDF1403BBB306893DEC433BD39B8B9D62DA2800003B>|ch3-Z-G-9.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  When the <with|font-family|tt|set!> is executed, the binding of
  <with|font-family|tt|balance> in E1 is changed. At the completion of the
  call to <with|font-family|tt|W1>, <with|font-family|tt|balance> is 50, and
  the frame that contains <with|font-family|tt|balance> is still pointed to
  by the procedure object <with|font-family|tt|W1>. The frame that binds
  <with|font-family|tt|amount> (in which we executed the code that changed
  <with|font-family|tt|balance>) is no longer relevant, since the procedure
  call that constructed it has terminated, and there are no pointers to that
  frame from other parts of the environment. The next time
  <with|font-family|tt|W1> is called, this will build a new frame that binds
  <with|font-family|tt|amount> and whose enclosing environment is E1. We see
  that E1 serves as the ``place'' that holds the local state variable for the
  procedure object <with|font-family|tt|W1>.
  Figure<nbsp><hlink|3.9|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_fig_3.9>
  shows the situation after the call to <with|font-family|tt|W1>.

  <label|%_fig_3.9>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#4749463839616401C600800000000000FFFFFF21F90401000001002C000000006401C6000002FE8C8FA9CBED1F809CB4DA8BB3DEBCFB0F86E24896E6D941EACAAA400BC7F24CD7F68DE7FA1EF13EF3FA0987C4A2F188740493B925F3098D4AA73C271566BD6AB7DCEE31EB6D80C3E4B2F99C18A37BEBB6FB2D55A3E5F0BAFD2EA39BF5F8BEFFCF66C707485838873768A8B8A895E8E518010984B024B160C99889B889E5E33426A9294A15DA9846613071F08289AA6011195491AA1ACB3A5B0B1B38CA5B547A95759B961A286B6BBCFB4949DCBA1A4CBCDB2B4DF44BFA1AE92C8B690B540BFDCDC6BA3A4ED9EA3D8DFE03B6FD4AC7EE79DD1C8E3D7F79AE8C2C5CBC1C7E9EFEDF64921808D5089E42B58116A85CDE54C1CA90CD92AB68E42A820398EE56AEFE531115F2135210A3C85EE2F691CBA7EC6295912C5B4ED2970C5A258F2A7784748993D02C8BF968D5A36833A7D0911AB56D3BCAD0A13F1D37873A85C3AEA9AFA754A5317423B5AAD63045B9BE03BA35AC9FAC9E7682158BB60E599008D3BAEDB3560C0A896FEBAA6DF3D0AE5EBC73269EDD0B1858DF67810B77896B04B1E1C52DBAE2822998B1E428257BFE8C3C393392AEF54A6E59A7CDA2E6D12C2ACB7476D89ECFA5A45B0F8C752C3417D0E052BABEFDF1AEBDA8B87B5FE2D48E77375DBE0B2BA636DCB68BE2868F0F01456FA23BE6C681C3A30ED839C8E7D8B35B5FD95DAF7675DCC3DB1D7F9DBCF9BAE8C1AB5FEFB67DD0EDF0E37F9F5F1FAD7CA6E5FEF38BDD1F107DFE8505200E8A1538A06E82F497605508DA7060835B3D58C35C165E8861861A6EC86187183E45E1615F49E85488B3B146624E267E86628A2EAD088C5F2E0A05232912D538E3672F2A95E3503852264E8B3DFEF3E314450E698D8A48FA48E3924D2AE9244E475216A5944F56C9D294506889E51757768911974C880926832D9159E67B2FA619E6191EBE29029B71B8390D9A246A6927847252B9479D7B6E49A7557F3E81A79F832651A8A0876E1628498B32DAA7A28F4E15A9A393525A469E155E8A29199AD2F0E9805211578A1E2396F34543A6728A1C7FCC9C8AEA30063D309E15C8BCC6AA9A377856D34147B990546E492165D44CC17D33FE5DAEBA42F8CE20B82C470FB2BF75266BB29E25ABAC7B064EAB9007D0F6636C36A74523E340E10A942D7EDB4A5B5AB9D3D265D2B89659F69A30B0F69A2EA84C3D766F44BCCA658E52016340136C35A9BA6ABEAEC6289CA50AAF1BE335923EAC67A5BC84EA5FA20E53BCA9C5A3609C9FC61773BC6BA32393DC71A686A23C83C81FB3ACAFC7A2805C9FCB33C3DCB2C92FE31C83CD9AD00C1F9E700E9D02CF9DA808F4C34937D1AFD1B321BD74BE51332BA4D33AEE58B5D598656996D65CEDD843D35EF3C975D853E77A76C563AB0CE5DA22F673A6DB8F0499761E72CF0D994875734A1C51778B98F5C47F33BC77CF839F58B8E187B3D8F6E2193B9E60E290DFFE2179941760D1F5CD93DB049AA9C1880DD7E60BE3DA0EAD9A8BAEB6E912CFCA48E5393A626B6399B8EEA224E7AE5037ED77DA8DAF128BE82E61A97FF9AE08F00D2E74EABFE540573CEA39EFC69AF2DD325F88F1A226177DE7EE9E6DFDE3D0478FFD88DC3BCF7B70DB6B4F74FA1A90AFB8F94B659F79EFEC0B3EFD3A60C52FFFFC27A31B0FF1DCEADF26D20D0374B202A0DE045811DB19306EFF130D24BAB7C0DC48305AA2F15F04F546980A6A707517CC5201FB052B0276F062102108420237C2003E2F855A81200B21F542CDB830869DA2216366684301E5703138DCA1B67C281E6600513CC610E1109166B023BEE5463D54621EDCE5C409A1308A349A22CC159178C52536318B5CECA217BF08C6308A710D76DAA2D5CA38467FD1E421032BD631BA151B6E1CAC8DA8C10613EF68C621C9065984D1C7AD5252096339EB55F22A64FEB228C85F2D8F90724C46433862C222CECB90C3E36268FEC80F498E2B6C9B04A4EA3449AD5072328DAE28616C7682307149E791EED305B108964431E6318D05A465156769CB5CEA7297BCEC6578C466445F420577C2FC99AA3AE2CA6286CE8E8CA497329739CA6B15EC99CB84971FEB484DB81C737A3ED960EC26984D9985F366B8A46530C7B9800200003B>|ch3-Z-G-10.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  Observe what happens when we create a second ``withdraw'' object by making
  another call to <with|font-family|tt|make-withdraw>:

  \;

  \;

  <with|font-family|tt|(define<nbsp>W2<nbsp>(make-withdraw<nbsp>100))<next-line>>

  \;

  This produces the environment structure of
  figure<nbsp><hlink|3.10|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_fig_3.10>,
  which shows that <with|font-family|tt|W2> is a procedure object, that is, a
  pair with some code and an environment. The environment E2 for
  <with|font-family|tt|W2> was created by the call to
  <with|font-family|tt|make-withdraw>. It contains a frame with its own local
  binding for <with|font-family|tt|balance>. On the other hand,
  <with|font-family|tt|W1> and <with|font-family|tt|W2> have the same code:
  the code specified by the <with|font-family|tt|lambda> expression in the
  body of <with|font-family|tt|make-withdraw>.<hlink|<label|call_footnote_Temp_346><rsup|<with|font-size|0.83|15>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#footnote_Temp_346>
  We see here why <with|font-family|tt|W1> and <with|font-family|tt|W2>
  behave as independent objects. Calls to <with|font-family|tt|W1> reference
  the state variable <with|font-family|tt|balance> stored in E1, whereas
  calls to <with|font-family|tt|W2> reference the
  <with|font-family|tt|balance> stored in E2. Thus, changes to the local
  state of one object do not affect the other object.

  <label|%_fig_3.10>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#4749463839618701D000800000000000FFFFFF21F90401000001002C000000008701D0000002FE8C8FA9CBED1F809CB4DA8BB3DEBCFB0F86E24896E67942EACAB66E02BCF24CD7F68DE7FACEB3710FECFD82C4A2F1884C2A1FC3A593D17C4AA7D4AA3517BD2AB3DAAEF70B3E72C3C031F98C4EAB11E6B5ADED8ECBE74838BD65BFEBF77C5FBF96F72738B81748C87698A8C867A8D8B8081939F578F82881D33474A9B029E959F8D94049099109158A3A473A185561307110B349B16011314B7B8B7B690BABEBBB9A2AFC12FC9725DBFA1A11ABECBAFCACCC2C8D1C7DCB195D3CAC8DB75DCDDC090CEECB390E6DFE232B6DAEFB5ADEFDBE932D6AD60925EF706CFD8CAECF5F5B6ECA1F3568A6F6B98387F00D913676EE8982E16A43BB31B972B1EB8521162DFE8B1461784C88D0A1B3569AC2150CE210A4CA4522AB1514783265AD95346BB6048768DF349C0B6BFA0479CFE2396CED747A13F233E93B91264B6ADCC5EB2016A5548705CDA94666D5AD6782A2D38A92ABD8484CEB693978EC2BBBB16CB37E7276B45FBA756DEB7601DB7523B9A39AECFAB58277210A5EFFCCD21B8C38B1E2C58C2FAC0C0CA657E1937FE540A673F9AC502E1533572EF3F8AD59BACBA0AAFBDC357437CFA8A5B076531619ACA8775BB3547D432051D2AE6D3BC2FD0618D1D72A88FBAE031CD06EA7B58F13329E26E5EC91D0F1397F9E5C1867B571AF3707BAF45F51A9DEAF544FBD5AFCD0D3E5A99C27F3DEBCBD7AF1DB9F5259BF0A4580F3FE6CD92F929F17014E321F65A5FC076076A974645A77582188147EE18505216812A64761853C0C78D684166A188F82A840C6A15D2502E6618420EA70A27E296EB86288176E43628C2C8A184A8D366282E35B3DED985B8F9EE808A472336AD358924A2EC964934E3E99C2752D4E325A742C4D896148E4A15749953662E984506B8049C3962B92B985985626A2E697094585E647CFB519639C62C866A78385D056246F0BF2E3651879FAC06791838A815997A51D4A9690822ACA1D908C26A8CA6D7DB207CFA493167729A62F8E6969A79B6618C7A84C74AA279289FE86AAA92A961AEAA5AEC25829ABA23A1A59AC7DCE2AA365BA1A8A0694C23A3603AF33B51AFE6C8E653E31ECB03E9169EC81C5326BC47BD1F6FAA88FD386D9A84DC96A2B4375D75EE32D979204236EB73441ABECB64B8C2B27AE04824B0CB590C0CBA3B9EAD6CBEDBDCF7E3BE4B2FDFEFA26C0E70AFCEEBE47E64AAF0BE9FA5B2E7C4CC011683CE3549CEAA9FD4D570CBE9E8684055C798CD690B4D57E4431C2F79596F14406EA334F1299CCBCB2BC9C3683B1CB7D4DBCCB834D95F4154F10F9E367CB0F59974F71151D6B5DB53CE946EEBA3726B34244D2D2E729D454A7CC72C6E8F21CB5D26D7646D9CF13B9FCB1515D93E6B1422153FD94072607CD9E706AA3CDE9CE4787AB71BC3A73702CD6DDE9B6F5CD7DE9FDE0C246FA5D0A9D391146D0E3CB4DFEDE3435187FDDF4A20EEB1535DD7CCDD2CCD023BB1479D88A238C38CF90E36336D919AD05FB76409BCC6F81708ECC1FB99023AEB55144576EF9408C178C494466E26DB4312A0B91B4E83AFFF2B7F1B30F6ED253359FCE6CF307BBBB85C2E0E90B31DF03DB6AB3BD01732FB3F7C44BDC3037E3B3F92FF804576D3EF9D877D8BE1FEF57123FFBE78B9FB0F0956F7FF3BB59000BF82901B50B80DD13E0FDE4933FFA119015FDCBD6FF6AD7400466C982DB6360FA1CF83DF8346B84CB430E08D7F72646896B844FAA60A672F685B6C16E4732DC9C0AC972BCFFD490503954E0BD7AD89E1D56CD711CEC1210CB2344B11D114557125E9D52A839D834D189678222FE150D36A728BAE981FE8354F2BC934409FA4A7D15DA5D18F7E6162DF28F86E980E105A3D3468F9D51845754156CE2A8411DC22581745CE218D9E8C713E6259052341421ED074737DE618E74E4626414B92A433A328690AC15AA5038A61A32F292D7DB152731E9C920EE518995D40387FCC3C34342D03968C919C94AF9472AA5A521B38CA46F4A668FBE21F2806884882E41759C4070468CF09B17EDD2363CF9FDA5117033E01AEB774C66C2CA36A340662795074D03561398A82145EA8829888739CC9AD7645837A7B50A7889739CE9E4E667F6E3A5B914A69CA098209DE4498E8EA4F19DB61B263CE3F9CC0FE6532AF864C33DF759997F125476630BA809FE07BAD0C91014A1CBECE730255AA5714147A119B528D394D9168E6E07A32C74162F0D3ACAA240B4A483698D48F349D28FD6E5A5438BA9E93E89ADB87554A1F4140B43776ABB9EE27471324504437A6922A41A3573371DEA54948A330F26B5A7753CA6536F54CE6F5AD52FFA64DA36AFFAAAE135D39909CD6A32A10AD62015952E86D824A5C4AABD5FA6D562A603E856DF39563F8D6EAE6F7509C50E13449FFD35667C75DAEB54872704698094D02BEC04C1A9A16CB875A68E4D5C6563E9D8C956F1B245E32C48C1AA59108596119EB565664B6BC9CA8EB68C9E5D2D845CBB48D462B6B0B0D5616B653BCDCBD6D63E0C61A96F7F2B11DCBAB3A9C22DEE43D7FE6ADCE4FE48A8CA6D6EBE98EBDCE8A2EFACD2AD2E1EF0A811355A77BB4354236160C95DE9DE0EA5550DAF7945374BF09ED7B9294DE97ADF6BBDC9C077BE359D277DEF3B4394E277BFFCEDAF7FFF0BE0000B78C0042EB0810F4CCEEF20989AB95DF090C8F6B7B550E77641C3D378A95761E6D0467AEA75F0340507B369F483742256E9DD2A3762DFEDA6B31EA620368476B6287284BC75C31DA07AA7E22FB6B89EBB3B0DE1A0D635A2BD446337A61C900BBA63236698238B8D9D38128BBC9FFAE7C9AF536592D774E5EDEE36CB3FDC3297BF0CE6308B79CC642EB3289566E6B90A33CD696572DC7E013A3687B2C771FE9D9C4319E4D259F9CEAC1C4F5409E21B653ECB92397036316FC61A68419F4CD1BA6531A33FD9E1477FA100003B>|ch3-Z-G-11.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  \;

  <label|%_thm_3.10><with|font-series|bold|Exercise 3.10.><nbsp><nbsp>In the
  <with|font-family|tt|make-withdraw> procedure, the local variable
  <with|font-family|tt|balance> is created as a parameter of
  <with|font-family|tt|make-withdraw>. We could also create the local state
  variable explicitly, using <with|font-family|tt|let>, as follows:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3106>(define<nbsp>(make-withdraw<nbsp>initial-amount)<next-line><nbsp><nbsp>(let<nbsp>((balance<nbsp>initial-amount))<next-line><nbsp><nbsp><nbsp><nbsp>(lambda<nbsp>(amount)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(if<nbsp>(\<gtr\>=<nbsp>balance<nbsp>amount)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(begin<nbsp>(set!<nbsp>balance<nbsp>(-<nbsp>balance<nbsp>amount))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>balance)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>"Insufficient<nbsp>funds"))))<next-line>>

  \;

  <label|%_idx_3108><label|%_idx_3110>Recall from
  section<nbsp><hlink|1.3.2|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-12.html#%_sec_1.3.2>
  that <with|font-family|tt|let> is simply syntactic sugar for a procedure
  call:

  \;

  \;

  <with|font-family|tt|(let<nbsp>((\<less\><em|var>\<gtr\><nbsp>\<less\><em|exp>\<gtr\>))<nbsp>\<less\><em|body>\<gtr\>)<next-line>>

  \;

  is interpreted as an alternate syntax for

  \;

  \;

  <with|font-family|tt|((lambda<nbsp>(\<less\><em|var>\<gtr\>)<nbsp>\<less\><em|body>\<gtr\>)<nbsp>\<less\><em|exp>\<gtr\>)<next-line>>

  \;

  Use the environment model to analyze this alternate version of
  <with|font-family|tt|make-withdraw>, drawing figures like the ones above to
  illustrate the interactions

  \;

  \;

  <with|font-family|tt|(define<nbsp>W1<nbsp>(make-withdraw<nbsp>100))<next-line><next-line>(W1<nbsp>50)<next-line><next-line>(define<nbsp>W2<nbsp>(make-withdraw<nbsp>100))<next-line>>

  Show that the two versions of <with|font-family|tt|make-withdraw> create
  objects with the same behavior. How do the environment structures differ
  for the two versions?

  <subsection|Internal Definitions>

  <label|%_idx_3112><label|%_idx_3114><label|%_idx_3116>
  Section<nbsp><hlink|1.1.8|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-10.html#%_sec_1.1.8>
  introduced the idea that procedures can have internal definitions, thus
  leading to a block structure as in the following procedure to compute
  square roots:

  <with|font-family|tt|<label|%_idx_3118>(define<nbsp>(sqrt<nbsp>x)<next-line><nbsp><nbsp>(define<nbsp>(good-enough?<nbsp>guess)<next-line><nbsp><nbsp><nbsp><nbsp>(\<less\><nbsp>(abs<nbsp>(-<nbsp>(square<nbsp>guess)<nbsp>x))<nbsp>0.001))<next-line><nbsp><nbsp>(define<nbsp>(improve<nbsp>guess)<next-line><nbsp><nbsp><nbsp><nbsp>(average<nbsp>guess<nbsp>(/<nbsp>x<nbsp>guess)))<next-line><nbsp><nbsp>(define<nbsp>(sqrt-iter<nbsp>guess)<next-line><nbsp><nbsp><nbsp><nbsp>(if<nbsp>(good-enough?<nbsp>guess)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>guess<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(sqrt-iter<nbsp>(improve<nbsp>guess))))<next-line><nbsp><nbsp>(sqrt-iter<nbsp>1.0))<next-line>>

  \;

  Now we can use the environment model to see why these internal definitions
  behave as desired. Figure<nbsp><hlink|3.11|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_fig_3.11>
  shows the point in the evaluation of the expression
  <with|font-family|tt|(sqrt 2)> where the internal procedure
  <with|font-family|tt|good-enough?> has been called for the first time with
  <with|font-family|tt|guess> equal to 1.

  <label|%_fig_3.11>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#4749463839618B012501800000000000FFFFFF21F90401000001002C000000008B0125010002FE8C8FA9CBEDBF809CB4DA8BB3DEBCFB0F86E24896E6899AD0CAB6EE01BCF24CD7F68DE7FACEF775EC0B3E80C2A2F1884C2A974622D3E77C4AA7D4AAF5CA886269DAADF70B0E8B13DDF1D08C4EABD75036A4EC8ECBE769B8DC4ECFEBF74CBCDBCF172838685326D170E890980448E8F8084986A8F8B6D4188999B907546110B548E1B918708953AA899A5AE7C9DADACA298A40745AA86A7B3B070B2AFB0A233A6B892B3C6C1613EA8B0C4B6AEC4AFB430C1D7DC539F13B7B9DD8797CE42CEDFD3DC38C7C075E6EDE634C4DD71D71EE2E4D3D2A562DA9C3FE8EAF772F65314E461F6A83BF7C041DEDA3A22D0BAB6C309C1C2C0811CDC31729126651466AA01DFE0D113B4A5C6751812E8C9F32BA98E831E50E948CB6991409B09A4B7A2F29A9BC898525129A032BF1D08933E8C941A77402158AF4CCB243DAD28D29C5D354D2A98C7A99547654AA95AC54BB5E05D88BEB0DB12BC87A458AD5EAB262D3CEBA5DD930DD31795FCC2A7D8BF79920BB36F3FAA548B4EDDFC12CF872134C38F1A4BD88153BE6C578EBE3C93DF318564879F2E5229B4566D61C58F267C79D8394863C3AF169748D53FF5DFDB3B5EBBCB0E18A9EFD9A68C5DDBC7BFBFE0D3CB8F0E120BCD68EE5962E6E7D39A32675B99CF934E768A94727375D79D04ED737655F4B55E6F1EE5CBE6BBF299EBCE5ADCCACA7640A5E3D7684E2CE7B841F5F3E9BF1E3FE1FF5D70F584E78FD07600BFC0D58602E5B10185A827F2C88A0830F0AF81683127A96917D3B4578E153F0697858851D4A24976CE18D584C89B79D65218AD6D4D6221F31A208DD14334AE7621835F2C3618E60B8178C883EEA78A09043E273E352C42DC9649318DCC7DD4940DAF651874936F70920DB4C39961A579EF3257D8A6C34A6104986590E9A4F34624859A67939A29A411686A19BACAD62259232381420956CE5F90E2DC0EC191B9E17CAB96138F9195868955C80C862A07D79D60D4B67D652D360883661C88E8BC6A51D4A975E145F179BAEE34EA751CA626A3F756AE528A9771176AA9917ADDA50044E42BAA2AEB3D24ADFAEBDF90A13AEAEA8B2FED179BC1A87D053B7EEA8DC05EDDC020753835A435AB3F3A81A2AB76D521BA7B6F320126AA6AC568B4BADC49C1663A5E6D2996EB836C60AEFBB3E810B288F7F0E55D9A4B6A83B0CBB86DAD92F66C2007CB0B8FBFE8A1CC3FFCAAB6F1DC9FAFB6AC2E898258FA79145ECE5285C2EF50FC27ADD19623299081C87AB527E9C4AB231B10AEAB34AAAB3563601F1B48B410A1F59DE62695D059E5C0C019DA1553F9354D6B04AA0CCF3C8D31EBD50BF73454D34D42F756618D34D2B4AEEA0690D8DE1D746FF62721559EFBC35BF32375CAAA7E2DD0CAAD0336374ACAD4BA39D76BDAFC2881A8555CD9B37A1B22E6B26CD10DE0D78E06AEB4A38672C23FE37C78A13FE8CD69C6BC6C91D3B22F7DA441F1F6EDE72CC49F339D5D99E67083A2AE2D43DA64C2742BEB48A12E24C91C605A76979EC8FE3A6854321BC1EB925B693E7F5CA40C6F4B6B573A96333D829E7DE52E3AE71F4C6D47739F555C356D3AD20ECC2A75E50C6F7625F7CD9AB0F3F70C9A74FCEE8F5412347FA3565AFE73DFBCE762DB4F272E7CA3FD9F6664ABAC425CA7EF4EA133CA047C01F61CA1BA64BE0FDC2213D4834D0813A02DE0029A8C0D221B0731874187A36C8990E7A50250DCC5CF3DEF6226C99507FFAEB89B50E6541F519EE6ABD5BC8CF6A4292F29509868D5A0CEBBA173CAFE52C2E36C4D6B1B6F48FA4E5CB1E06A45F10638134F3BDEF6A55F307FEF78AB5C462C5237F2A0B590A6F66BD0C0611792A1308C8FC07B22DD1A477D873109950D78C00AE4A8E718413ECC007203C80ED5A3FAC471C8758C010DE4E84C10BDB1401F83F1C168D8A768CDCEE084932C66D5149E75ADB1993D7373F1E51908584A4D9B886BBFA795280ED0B65274729B9D199638217D454232B07394845304B5DCBA4E37692A5086A725C1ABCA3DE0A53438391D26EF3FBC18CF078B93BAE111B5CECA3EF4E6844324EF25C36839911B518A56A9E707F6C735A057BF9C49A15B18AD7B39AB9CAC7BDED8D337F61191B396F282A12096B9EF4F40D6AEAC3C88F5D6B9AE7345F54D4B9487B05C49D00E563972CA3CB5BE90C0A7A84E23AFEFBD797A145F19EEE2422410F590F7CBE138D5734C5A6D0B7B285FE44436A8C1BDBD095C2342E8F85F10899FCFA67AC172DCFA460048B304B62CB3F3CB27509FDE6487B3AAD5FCAB03162A9554C21B8D385E5E0A88A3AE60C6DF4D455CA6E2C2FDC983D985ABB8E01F5AA5B3D19378D0947AB2EB5AAA894D8380BD11E91592AAD657D5E24C54AD5ECB5750D4049DD518E834C58ADB20D22ED21299505C8C505F2806F0DC45DD953B19C6AA2AB84A8AB7FDEF449D1AD54452BCCE5176B5ACD9AF17381E0706C5FFD14318936C38FE6A4A8440D57D0A58289AF8D85ACB8841858745207187BDC24D098A9DABD1616A161656264A738D1D19293B4C0A55B0E8BFEF9A8D5EE1624BDCDED6F5738334ABAEA9FC96BE14C7C57C95DE274900163AD8CD203DA61720E6F0CF4EE77934AB16FE415AE7A3D2F63B97BB0F71A29BC9B40AF0FE7BA1FF39E57BFF81D2C670D2BDF3EF697977ECDC77A27E759BA82D4A58DC3AB500E1C54FAFE2863B26463297706588312F3BE7C81F02E9DFB4059114BC4E9155E62E1CBDF1233345ECB3DDCBD147BE20FF7819AD1446174294963E9520F8B37C6EC413C8C62C1D645B05019A123CDB9DDD2DEF6B8E39863DF98DC5ED5A5D8449312948A1D998C3512F72B74A96DDDFC10401C27B289526EF16FD566E5FB8616C95BBE6158821BD0086B54C3C9C55781FD061877093371D06D0A4BD158FEE3165A548B83C664C5B62B604C24D80B1353C81B232CE36452D9BF279B3279BB38686A46EB5B9D75A3A5C52B2D983C6BB67B8E867DB365665063BA9B718B56A9071C62DF0E199B9B1EF508604DD74FA7726EADB2B5A9708D23099F59D3AD2AF66C8FF958BF2C9AD1E49A04B75ECDEC9E55D99B490CB282EBF93BC18911D2B9D2F3B6A86DE45A62E6A5EC8DB550F11C633A877B4593E5B575A4A94263713ACC329A10995D7C627A53CEA74BAEE31F3DF6647FA7DB8AADCDAFB6F96DCB609E7BD6FCDB278C092EBAFFCDFBE1F379E58511FE6568C798E1FD6624D56E3A5C948A1A149B0B93336E24BEDBD927C0C46CB71A9FCD5141E71887002F78AE0F9EA2FE2D6AC9632CE7A09A2D6E587B0B599E483DB552296372500A5DAA4036F7D1F77D73604F1AE35007BAD477EDF4171BFCEAC3262FC535FE74AE4B527906423454C1ACF4AD8BDD7D1D1DBB33FB014D1C2311EC89FEB9D5D74EA98D8FFD5BA91DEE95EB4E77468F04EFE27EB2089E66B4655A53EBDCAEBA879A4BF89C9E1C5A39EBBB9618EFF86F1BBDADB42DCAAA03DD3CD057667827D7E91923CFE0AFF274F45F3F25E673DEF42CC2AF48F7863DEA37B8E0562E3CE7B71765D6D73DE1DEFB9EC043177EA7D57E71E39BF2EEC057BEC5A25EFCA93BDFE7CCFFBBD7A74FFDF4ED7ED4FE83FB36E32D4D3FAB5B5A826E37B0938E733BD5FC5383279A22E5EA7E9FFEB573A3631E25FA6B1F518E7A31AC738F66B595F2358A0751B0767FD1E7331AF57EED8734A5D576D9755B17557F9E846D87977ED5B34D2FF724A7B74CD9A465927459D3947BD8B76DDB172BB127821118691DC36A27B858B5F3519BC7826E1583F6638233F87C36586F28882C38181918F362A5612197376318944EBA9682D9573D4A5481E9C61535B85836665C64E752E097813C56599FF75F99778424B628CA724B4DF36BF1175038453E10C54C61163F2B186516486E3EE64CFF674524177707C533962586E7236A1E6776729663599166F85186621854E56248E2A483D6373BF2E366FC97518754128FB6488B286C3E844FB0B56F61685142246B7508FE4DE93455A2775D30A781584887ED03888E28848B675B58818060257C00232802D863FAE64275227ED7A411DAA57CB0E87A81778820767B30D875ACE1843C388C23658CA0918C79538CCBA868CE98361ED68C310864D37882D5688DD8D774D9387DDB088D2DF830DFF88CC8C28DCEF751BAD87AE2E844E0A88E91508EEDB88EF00831F2388FF4C843F6287BF85820EFA88F0C35811ED08FEA857C01D95DD0479005597D07596609A9909566900D198E0C099112349013B990DA6791EC889119398E12C991E5368488F89141673620C28F84E77D24453B7B473E86D67F7A077823195A82884D6F487F7316936827930A444BA3F36E04F5320368775BB8936BFEC2736CC4010A75514A16782789925C686B6BD36764347A53E29478475B2AF79210375E4579768656783F94595DE995244968E856960DB29169E91D0FC99639E8916F5991C4279770B9967559719486974B17767B298377E9976E49978199977D4998714996872931FFD8018AE9988F099991299993499995699997194A5789993E61173D9787B8B89907B5879B487D0D189A1E6853CF0468B3B8786E535D0DD79260E9997E198645E87137F950990381961793A7A911A205197C945AE3979ABB0981BEA98486689BCED381016893BCA981BD899CD9355000D45233C77326C53873A33D35C59D9AB98CB42869BF389DDC1055FC709EE55992B3E982C55800003B>|ch3-Z-G-12.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  Observe the structure of the environment. <with|font-family|tt|Sqrt> is a
  symbol in the global environment that is bound to a procedure object whose
  associated environment is the global environment. When
  <with|font-family|tt|sqrt> was called, a new environment E1 was formed,
  subordinate to the global environment, in which the parameter
  <with|font-family|tt|x> is bound to 2. The body of
  <with|font-family|tt|sqrt> was then evaluated in E1. Since the first
  expression in the body of <with|font-family|tt|sqrt> is

  \;

  \;

  <with|font-family|tt|(define<nbsp>(good-enough?<nbsp>guess)<next-line><nbsp><nbsp>(\<less\><nbsp>(abs<nbsp>(-<nbsp>(square<nbsp>guess)<nbsp>x))<nbsp>0.001))<next-line>>

  \;

  evaluating this expression defined the procedure
  <with|font-family|tt|good-enough?> in the environment E1. To be more
  precise, the symbol <with|font-family|tt|good-enough?> was added to the
  first frame of E1, bound to a procedure object whose associated environment
  is E1. Similarly, <with|font-family|tt|improve> and
  <with|font-family|tt|sqrt-iter> were defined as procedures in E1. For
  conciseness, figure<nbsp><hlink|3.11|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_fig_3.11>
  shows only the procedure object for <with|font-family|tt|good-enough?>.

  After the local procedures were defined, the expression
  <with|font-family|tt|(sqrt-iter 1.0)> was evaluated, still in environment
  E1. So the procedure object bound to <with|font-family|tt|sqrt-iter> in E1
  was called with 1 as an argument. This created an environment E2 in which
  <with|font-family|tt|guess>, the parameter of
  <with|font-family|tt|sqrt-iter>, is bound to 1.
  <with|font-family|tt|Sqrt-iter> in turn called
  <with|font-family|tt|good-enough?> with the value of
  <with|font-family|tt|guess> (from E2) as the argument for
  <with|font-family|tt|good-enough?>. This set up another environment, E3, in
  which <with|font-family|tt|guess> (the parameter of
  <with|font-family|tt|good-enough?>) is bound to 1. Although
  <with|font-family|tt|sqrt-iter> and <with|font-family|tt|good-enough?> both
  have a parameter named <with|font-family|tt|guess>, these are two distinct
  local variables located in different frames. Also, E2 and E3 both have E1
  as their enclosing environment, because the <with|font-family|tt|sqrt-iter>
  and <with|font-family|tt|good-enough?> procedures both have E1 as their
  environment part. One consequence of this is that the symbol
  <with|font-family|tt|x> that appears in the body of
  <with|font-family|tt|good-enough?> will reference the binding of
  <with|font-family|tt|x> that appears in E1, namely the value of
  <with|font-family|tt|x> with which the original <with|font-family|tt|sqrt>
  procedure was called. The environment model thus explains the two key
  properties that make local procedure definitions a useful technique for
  modularizing programs:

  <\itemize>
    <item>The names of the local procedures do not interfere with names
    external to the enclosing procedure, because the local procedure names
    will be bound in the frame that the procedure creates when it is run,
    rather than being bound in the global environment.

    \;

    <item>The local procedures can access the arguments of the enclosing
    procedure, simply by using parameter names as free variables. This is
    because the body of the local procedure is evaluated in an environment
    that is subordinate to the evaluation environment for the enclosing
    procedure.
  </itemize>

  \;

  \;

  <label|%_thm_3.11><with|font-series|bold|Exercise
  3.11.><nbsp><nbsp><label|%_idx_3120><label|%_idx_3122><label|%_idx_3124>In
  section<nbsp><hlink|3.2.3|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_sec_3.2.3>
  we saw how the environment model described the behavior of procedures with
  local state. Now we have seen how internal definitions work. A typical
  message-passing procedure contains both of these aspects. Consider the bank
  account procedure of section<nbsp><hlink|3.1.1|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-20.html#%_sec_3.1.1>:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3126>(define<nbsp>(make-account<nbsp>balance)<next-line><nbsp><nbsp>(define<nbsp>(withdraw<nbsp>amount)<next-line><nbsp><nbsp><nbsp><nbsp>(if<nbsp>(\<gtr\>=<nbsp>balance<nbsp>amount)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(begin<nbsp>(set!<nbsp>balance<nbsp>(-<nbsp>balance<nbsp>amount))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>balance)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>"Insufficient<nbsp>funds"))<next-line><nbsp><nbsp>(define<nbsp>(deposit<nbsp>amount)<next-line><nbsp><nbsp><nbsp><nbsp>(set!<nbsp>balance<nbsp>(+<nbsp>balance<nbsp>amount))<next-line><nbsp><nbsp><nbsp><nbsp>balance)<next-line><nbsp><nbsp>(define<nbsp>(dispatch<nbsp>m)<next-line><nbsp><nbsp><nbsp><nbsp>(cond<nbsp>((eq?<nbsp>m<nbsp>'withdraw)<nbsp>withdraw)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>((eq?<nbsp>m<nbsp>'deposit)<nbsp>deposit)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(else<nbsp>(error<nbsp>"Unknown<nbsp>request<nbsp>--<nbsp>MAKE-ACCOUNT"<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>m))))<next-line><nbsp><nbsp>dispatch)<next-line>>

  \;

  Show the environment structure generated by the sequence of interactions

  \;

  \;

  <with|font-family|tt|(define<nbsp>acc<nbsp>(make-account<nbsp>50))<next-line><next-line>((acc<nbsp>'deposit)<nbsp>40)<next-line><with|font-shape|italic|90><next-line><next-line>((acc<nbsp>'withdraw)<nbsp>60)<next-line><with|font-shape|italic|30><next-line>>

  \;

  Where is the local state for <with|font-family|tt|acc> kept? Suppose we
  define another account

  \;

  \;

  <with|font-family|tt|(define<nbsp>acc2<nbsp>(make-account<nbsp>100))<next-line>>

  \;

  How are the local states for the two accounts kept distinct? Which parts of
  the environment structure are shared between <with|font-family|tt|acc> and
  <with|font-family|tt|acc2>?

  <section|Modeling with Mutable Data><label|sec:3.3>

  Chapter<nbsp>2 dealt with compound data as a means for constructing
  computational objects that have several parts, in order to model real-world
  objects that have several aspects. In that chapter we introduced the
  discipline of data abstraction, according to which data structures are
  specified in terms of constructors, which create data objects, and
  selectors, which access the parts of compound data objects. But we now know
  that there is another aspect of data that chapter<nbsp>2 did not address.
  The desire to model systems composed of objects that have changing state
  leads us to the need to modify compound data objects, as well as to
  construct and select from them. In order to model compound objects with
  changing state, we will design data abstractions to include, in addition to
  selectors and constructors, operations called
  <label|%_idx_3130><em|mutators>, which modify data objects. For instance,
  modeling a banking system requires us to change account balances. Thus, a
  data structure for representing bank accounts might admit an operation

  \;

  \;

  <with|font-family|tt|(set-balance!<nbsp>\<less\><em|account>\<gtr\><nbsp>\<less\><em|new-value>\<gtr\>)<next-line>>

  \;

  that changes the balance of the designated account to the designated new
  value. Data objects for which mutators are defined are known as <em|mutable
  data objects>.

  Chapter<nbsp>2 introduced pairs as a general-purpose ``glue'' for
  synthesizing compound data. We begin this section by defining basic
  mutators for pairs, so that pairs can serve as building blocks for
  constructing mutable data objects. These mutators greatly enhance the
  representational power of pairs, enabling us to build data structures other
  than the sequences and trees that we worked with in
  section<nbsp><hlink|2.2|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-15.html#%_sec_2.2>.
  We also present some examples of simulations in which complex systems are
  modeled as collections of objects with local state.

  <subsection|Mutable List Structure>

  <label|%_idx_3132><label|%_idx_3134><label|%_idx_3136><label|%_idx_3138>The
  basic operations on pairs -- <with|font-family|tt|cons>,
  <with|font-family|tt|car>, and <with|font-family|tt|cdr> -- can be used to
  construct list structure and to select parts from list structure, but they
  are incapable of modifying list structure. The same is true of the list
  operations we have used so far, such as <with|font-family|tt|append> and
  <with|font-family|tt|list>, since these can be defined in terms of
  <with|font-family|tt|cons>, <with|font-family|tt|car>, and
  <with|font-family|tt|cdr>. To modify list structures we need new
  operations.

  <label|%_fig_3.12>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#4749463839611701C500800000000000FFFFFF21F90401000001002C000000001701C5000002FE8C8FA9CBED00A39CB4DA0B9CDEBC1B0C8662E629E38942E5CA22640B1F6F4C9773CDDEAB8E73510F74C5781E623068F4D1921BA6C6B9901C91C3E5F42AB356B73068E2E7C53EB8ADB0B8A8EDA6CB3B55C07C369173F123FCBBA6CF9FEE775D0D18F8577327B46793F7D0E737B87388D6489888F8D8E1F563186959A9A4C9D9340929D88099E9F944BA88973A76CA966A14ABBA3AFA359BC5C753084461EA2215C5D01BEC0A5B2A5B4A6B9BAC2C3CE1FBCB8C0BEBAC225D67517D4D342C57ACD8BD0CDC2CF34CDC94AD7D9B74FDF171FB96225FA1AE5B3F8F9F1F727F2EAEBF1F25DC34134C48B48B73A15EBF68ED7661A317D01CB977E3264694826C9B33FE50D61CE690C888604363A4BEA983566EE4C558E89865E416D00718789AD8B16C25CC24A5923C37F67CC52AA7AD4D3A175A74F7A9E840A3284501150AF59D53A548A37AAB45F5AAD5A39DB036AD7A90695176389F6615BB942BA84F64E3C1F178A6EDD69D67D156B5BBD66B5A2161E78E2DAB554F5DBC72CD3A022CCEB0D2C2810F0F6ECCD5A36454D4148FFDA7EFF14ACCF29670CEA71971E86F70498F3E55FA748FD4AE58AB26FADA746CB5B379D52EE6BA91B578B7C5E4EE0D7B7686E1BF8187348E7038EFD82091AF76FEA7F969E9D09356F7DCB72EF5EB82B94FD91EBAA277CBE3B1D3D49CBDBC68F5D87BA7678F17BE8DF3E8E9CB8F7F5F66F141F6FEF37FF56F497F003AB7DF6D98E9F4CF80772948DB7A913854207A0CFA155C6BD67917A170A13C7821771932B7A16E1D5EF7E16B939904218325AA76A26CEBAD98158CA3B5881B1F14B227637821F2975783184E6897787BD574127E3F0279D40BEB2018D38243C297A384373AE9893D4346C924925F293965744DC283258A5A6E495D984D0944A57C669E45A3857AE138E6935DD5F8A67A6BC6B8A39775967727556DA23662757D2E962736814237E85F877EB728728966B9A7A1911E19E79F55366ADCA32826B829680A6A1A67A8228A4AAA7FA0968A2AA3A9AE3ADEA9ACBE3A29ACB23EE6EAACB65256E967F898A72B0AEE896AE9548E9197CBAFA1065BFEE1B0DD15F11E9BC016FAD3B2CAEA771C88C742DBA58373525BAD89CF62DA2D5DD28223A79495626B64B6D12AE2A3B3038A87ECB6D38A1BD47FE602484FBC3D8E2B6C93EDC6D86BC00263402E856139A15165F18179EB6268A6C4F0665D42142E4511D70B59C3BA0DC3CDC31D0B99E666607AAC70BA1A7F37CBC720AB3C7043244784EBC9841699F1C315FBE3C64B736557EBAD3A8B051EC2D2FCDC587A3DDB5A90B6FBCEFBDF0DEF1D3D6BD2EBD24B75D3D1F42B339D53971B33BF722A2960C8595FAAADBE5D678C54B3628FCD61D9E8A22D367177402DABD4EADE4D183885D00DABDD26C3BD746461FFCBB66F2D8FC0EBE109153E63A68C6BC937DE8F53FE6AE0E44046FE8B1F835B0EDC6E9B8BA91CE7F92987B9C5A58BDE05C8E1A98EBA87ACD3FA7AEB88C63E98DAB2BBF7F965A7DFDEC6EE6EF10E65EE080A0FFC74C48B597CE79C929659F2B5BF7D458ACE6B07BDAAC44EEF66ACBE818B7DF4D5DBC17DF7E0872F89F6E223F43D15E69FBF3DF99340E1FBE4664B3AD4D9EC03EAFE2308DF0FA948176BED0FC9F1CF7A2FEA5F269634400006F06FDEEB879512883F62FC2F7BF5432004C92631C0E9096702BC200EE687BEF579B07C221CDFF5464840AF8DEA8428545F095DA8C2169A908521A4A10C4968C3F6E5F0862FBCD90A63C8C30F2E0F37CD0BA2118F88C4242A71894C6CA2139F08C5284A718A54ACA2FE15AF8845D4280E20A9DB22C1A0B82610A22C7EDFEAA11819E816325E0B5C67D4A0487C78C436126E8EF67A231C8D28C73A2ACD7E0A53E3B9D898BE3BA6448F3CCC23D7F688C8DF11F286865C1B1F9305333A8ACF829144CBC1D071A38308ED8141EC06D12C12B49624E393F6A2891F1FD49128510C679C64C804F5A6BA557E8D3175238EFFBCE8B232DD6360FC401B7D4E894A418E3168BACCA01BB3F192569623707D3BDE4746690C98AC646BAE4C522CFD95485239138641529ABE18F3B4936DD3366E0364392982B555D1EE87DD34273543A2366022C96F6E7C2733BF86CEAA25919E9274A437C7603B6132F291024563B96C923B795E8EA08D842342E57B98405C7EB18B12B55915C9A8D0493A2E8B3CEA1C473B2A1CD26514789E2B9D483F1ABD9332679D287DE6385119D0968AF274E091294577C7529B0628A69DD2E918713752E7F1B4A73E45C24BAB1454F90DB135452CAA3FEDB941207EB4A1CF8128180359D51D5A91AA1FCC1F13B98A43A6D914ACE94B2AD2B0DA55AB3E91AC9C5899531769506E96F2AD4F625D9F58D6412ADEA46277B5A759A3D6CB7E92336F74BDD9FE904758BA92F290355C603DB3C8D617FEB56E680DAB3E651A59AD3216B2952D6B610BFA581D4A95A3991D6D5CA5585AB1DE13B39DC5D4649BD954A67A0A060500003B>|ch3-Z-G-13.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  <label|%_fig_3.13>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#4749463839611701C500800000000000FFFFFF21F90401000001002C000000001701C5000002FE8C8FA9CBED00A39CB4DA0B9CDEBC1B0C8662E629E38942E5CA22640B1F6F4C9773CDDEAB8E73510F74C5781E623068F4D1921BA6C6B9901C91C3E5F42AB356B73068E2E7C53EB8ADB0B8A8EDA6CB3B55C07C369173F123FCBBA6CF9FEE775D0D18F8577327B46793F7D0E737B87388D6489888F8D8E1F563186959A9A4C9D9340929D88099E9F944BA88973A76CA966A14ABBA3AFA359BC5C753084461EA2215C5D01BEC0A5B2A5B4A6B9BAC2C3CE1FBCB8C0BEBAC225D67517D4D342C57ACD8BD0CDC2CF34CDC94AD7D9B74FDF171FB96225FA1AE5B3F8F9F1F727F2EAEBF1F25DC34134C48B48B73A15EBF68ED7661A317D01CB977E3264694826C9B33FE50D61CE690C888604363A4BEA983566EE4C558E89865E416D00718789AD8B16C25CC24A5923C37F67CC52AA7AD4D3A175A74F7A9E840A3284501150AF59D53A548A37AAB45F5AAD5A39DB036AD7A90695176389F6615BB942BA84F64E3C1F178A6EDD69D67D156B5BBD66B5A2161E78E2DAB554F5DBC72CD3A022CCEB0D2C2810F0F6ECCD5A36454D4148FFDA7EFF14ACCF29670CEA71971E86F70498F3E55FA748FD4AE58AB26FADA746CB5B379D52EE6BA91B578B7C5E4EE0D7B7686E1BF8187348E7038EFD82091AF76FEA7F969E9D09356F7DCB72EF5EB82B94FD91EBAA277CBE3B1D3D49CBDBC68F5D87BA7678F17BE8DF3E8E9CB8F7F5F66F141F6FEF37FF56F497F003AB7DF6D98E9F4CF80772948DB7A913854207A0CFA155C6BD67917A170A13C7821771932B7A16E1D5EF7E16B939904218325AA76A26CEBAD98158CA3B5881B1F14B227637821F2975783184E6897787BD574127E3F0279D40BEB2018D38243C297A384373AE9893D4346C924925F293965744DC283258A5A6E495D984D0944A57C669E45A3857AE138E6935DD5F8A67A6BC6B8A39775967727556DA23662757D2E962736814237E85F877EB728728966B9A7A1911E19E79F55366ADCA32826B829680A6A1A67A8228A4AAA7FA0968A2AA3A9AE3ADEA9ACBE3A29ACB23EE6EAACB65256E967F898A72B0AEE896AE9548E9197CBAFA1065BFEE1B0DD15F11E9BC016FAD3B2CAEA771C88C742DBA58373525BAD89CF62DA2D5DD28223A79495626B64B6D12AE2A3B3D7828BECB641FD67EE98F1F638AEB04DB68BE7BBD5AC9B92B61405499313601A7B6E9190B9A51238E3BC3465C108DBCBCFC268A6B9199817232330ADDF8A2464B80CF77AF1C84B4684AB86FE820CD366D942043153D9D59AB296315B1C32C629E9703339E9D1DCB1A935F3BB70B2912D63F4741FDF78EFD047079CF48C4B07896ED13A2B29A0CEF5DAEC74B95D477DF5C0E27ABB32D5F07EED47B35E0F063487DA362DB04D59D3EB71D956C30DF07F6AD3CD36B024A7C0EBDF00D5D6B69F99A65A38A1C0254EA4AD8CA70BE0E36212FEAEDCDC6ACABA9BE5622A47AAE41672CE5CCE407A8E9AE8B49AAEE2ACE09DBEF7E598A3CEB6E6AEBF4EBA5BA8D65EA5EC08EA0EA7EABC93F63B9F8E074F67A9B87FC729F09E0E78BC1D555F91E2A7534F7B69AC244E3F76F5C4DA89BDBE8D6F2FBCDDD97F9F2F94DD83CDA3F5829E2FAFF67C370FBED0E03E4710BEF9C16FDBFC38B41C34A5142B4C34E801906FFEE39AFDB4A6A7AB9C8C79E7DB4E9FF8172EFC516F423739D8E4EAB79C0012A881658214432CC840F179CF6DF12B2092F01617FD118E7D0724DF04CD2742F425B07CBD4B98FA0478C30DC6B07D2E1C1F0C6D58C214E6D0517ECB4CA77625BD5B2991454B6CA28E9C08457745718A1EA4A2FE15DD77C52CA64F8B5C945417BF88050982F13E621CE30FCD88C6E7D9497027081C1B1362201622448DFB231EA076D84219F64F5D8989231ED196471EEA1169B52B231D11B847C8590D652293DA1F13B948404A321A6BD38E1C21A9C14AF2311985FCD42C50A8C84C22D2760494A2A98601CA4862F27D9F9C98274D77108EE5ED174C9358B154A99D37EAF26FC680E00767B9B345F48C5EB64C631D7BC18D8D29245DE960D902F7154A635EC42210A1E62E35D6419F00539A9258A6357306856CBCC44A185C253705E9C001D2AD39C3DC4B7F0C99BAB7C56D478C790F3CD74818738E32626569D63DF9249182E8B391820C9BD80679AC8E44A99A4C3B2441FE096A10CBFDD337C471E63505BACD496E932CAD9B681841F720869A6D885A935B213CFAD11C8104A37C8C66B9E446D2D13DEAA21870234DEDC8BCC71D0FA5A1C3E90C5778CE561D2EA8269C4EE578CAC5CC49EEA8447514537BEAD3A6B606766CA2AA54EBD3BA2322B58BAB63DD56936AD51845F5AAA52BE458C95A93B34647AD68E50F5B1FD256AC2E0F37468CEB1D634ABF20DAD5792A3CE45711E7D0BCD270AFBE09ECFEFA4AD81116748B834DACAAF07A58C83A56B18164EC0B27FB58BD86D1612EC5EC652BFB53627A36B43BCBA817FDD1D2D192874B9DCD5F3E552B448BB656B06AF9EBED32FAC08DC236B62C4B2D0E7B3BDBDD9A76B8BCFDAC7063359A5BC91E57940F252D4297FB5C5C16D787D0D52C73694BDDEA1A77A0D8A5AC76BDCBDDC85AF7BBAD4DEE78C9EB8F79EC6EAE2C2800003B>|ch3-Z-G-14.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  <label|%_fig_3.14>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#4749463839611701C500800000000000FFFFFF21F90401000001002C000000001701C5000002FE8C8FA9CBED00A39CB4DA0B9CDEBC1B0C8662E629E38942E5CA22640B1F6F4C9773CDDEAB8E73510F74C5781E623068F4D1921BA6C6B9901C91C3E5F42AB356B73068E2E7C53EB8ADB0B8A8EDA6CB3B55C07C369173F123FCBBA6CF9FEE775D0D18F8577327B46793F7D0E737B87388D6489888F8D8E1F563186959A9A4C9D9340929D88099E9F944BA88973A76CA966A14ABBA3AFA359BC5C753084461EA2215C5D01BEC0A5B2A5B4A6B9BAC2C3CE1FBCB8C0BEBAC225D67517D4D342C57ACD8BD0CDC2CF34CDC94AD7D9B74FDF171FB96225FA1AE5B3F8F9F1F727F2EAEBF1F25DC34134C48B48B73A15EBF68ED7661A317D01CB977E3264694826C9B33FE50D61CE690C888604363A4BEA983566EE4C558E89865E416D00718789AD8B16C25CC24A5923C37F67CC52AA7AD4D3A175A74F7A9E840A3284501150AF59D53A548A37AAB45F5AAD5A39DB036AD7A90695176389F2A0559B0AC1EAF4B578515AB93ECCFB559E309D48AD7D127B26FE19A94BB75E7C37FA8E6EA655BF5A259AA80FD821A0407A2E1AF5D1773ED1B78EC3F7D8D2E49DC4C7808E87C7589963ECCC7F269C7AB11B6168CC5E3DFD7AE649FC5465B6DEE3FB6C7E2DEFDCB0F4DE054884FB6633C4B86E1C92535CFCB6B793CE3209F23B74E9950C5DDD5B1F7E81DF74C77DAE3BD874A0E7E65F3EDE69D9B4F2F92F969CCEDA75A872FF239FDFA95FEB1E35FA69F7CFC99E6DD7FD1DC67A07FF52548D1800EAA869E769CFD35E183BAE9E71E849D25F5208391C8E69187FDC1662174EB6548576D1C3A28226428A2A6226225B6C8DB8B247AE2108D59E9E8DA7923E2F898892526A6A08F411653104C436616A191857DE384924B0A499D8D294989E449AC75B8A09521AD131E416D11392599189E176598CA6059A69927A2396648598A39DD962C7689E6783C6676979C6DFA799F973FD6B4E2807B8A01A293BF6938239E85DA29DEA38E1628E89131326AE1A1B155FAE49C9872D95EA2925E91E39FD90127AA8C35AA0AEA7B9C5E4828AB77862A216914DA6A2AA067E6CA2BA993F60A2C0E9AFA1A6CB1AFE636FEACB1AED2AA6CB33006EA6CB48336296DB54C56B9C468F864ABAD3CBB52AAE87104A6F8AC25029696EC75A39E0AEBB8E5B694EEBAE81E7BADA5EFBADB92AEC8FE4AEE8DF6F98B2F386E92C7EFBDD31E6C2FC011C54930B3F20E8C70A7FDFAC4F06BF1F262AE2A21865BAFC441B13BAFC3F082C131A4265359CEC96775CB72CB1808CC64585182494DC7F05C6C6C647D5274B342AC49F652BD34E15CAC67E670D327D2EC41EC4F4349D7DCB1B5EAE662A2644DB96C35431A2DDCAED4C456529ED22AE5024CD04CF54574B0A9C6C7E6953781A383D979619636B06BFBB5F15E6AD15777AF775399B78C8DEDD737AF7F5F5632CA80EDA7AFD75F0BDE75C2FF52FE66D0B9153B5E9CDEE2461C395F965F8EF97795363671C0152F2D79E89943BE79EA08DBB44BE1B98288F508DCD60E82EA3D460AADEE6FF2FEADEFC48928BBE9C2B746FC7AD27D7E3C94882E5F7C4ED235CF5DA4D30F8FFA90B803B46A6CD9AF569EF69E2E4AEAF7F399DF6AE99C8BFE3CE32B478FE8C38D4FE1A1FBEFFB2DBF8EF5337FBFE1F96F281EFE69067E9B9255D4D8D7BEDECDEE7F2EBADDB66EF5C0597DAA75AB9BE00181A73E8BB52D259B1B8EFEE8A532FAC90F4A68D152D5C20640063ACF8026FC50D6DC668F956CB0802A1C9FC13A21B6EDA1EE6932D421F75888B2EE65D078017C460E63C8B619CE27718FBB210E5DE892167E257B0404D9FE05E317C4F9C9C47E34C49BC7ACA8260B6271285F5CD6B502B7AF110ACB6699EA1A1A1BA69E104E4D6B5744951B9968433E8531133493A017D59842B6D5B1890341A2A1EE08C80612A367B389499DB8A240C0E1F1524994630579C64816F9301DD54BE4C3AA284267BDF114A5F29F282779C9C92D0994421C22F99C98BE9CA112634014992C3D594BD0C5B268B344A02BFD98B3D0901057A66225F57467CC63862E99CA741C339B29B56742B35AD29C66B4AA69CD6661339BB7E4A63715F9CD708E519CE49C63D136C9C932A0F3859D2CE62CD2354AC808708F6582483C55B9BE41DA459ADB74E03D89584680E6879FEB2C280A66F9CF7C36488BE554A711FE110AD122F4A19F7FDA4E425D87D180E647970D5D630D7F79C02876F495B0A460E434CA41488ED4A3D51097CCD071C6A1E52B8B2B05DB0EA578AA70C80D9232ADE938B5D6C7A65D309D4035249DF4E9D341B1F38858E387909843D16E56F284371D19C97C6611F9449597387553F86626D2384247405B559B46494753A1EDED5C65D59E12217651940ECE726D9D51091199CBCB2DEE73754D2017FD09D5930AB67572715F5F9FF748186EF2AC11EDA05D40AACDEB75861E6931A965D54A12C846764FD5A92C5299265798695659F3F49E41FF8A498336AFB4A42C5252B581ADE0BDD696B19D6DC1C8033DDBFA27B7C313CE61CB698DC4220B7DBAD5206A6BCF43DCE2822FB98C61AE72EB123EE41DF7B948726EFFA8AB3C82FE76A4D345EE763BDA5DE46277B915AA2E31C7FBA15EB274B4E85D2F7BCD89CFF676F1BDA914A87CEB6B5F0C96F4BEBEA42F2DC5C8DFC6E631BE01FE2F800949E002BB77BF3F158725159CDF07F7373BDF5D666625BC604C7E16C2D37AC15BC1C9530EEB57B118F69267451CCA9FD153AF289E2F1D4B1C0A14B638C507A6318367ACD0B43638C138E6F18627ECE31E6774B0230EB290890CE34F1E19C84646708497BCE18B9512CA1F6D6D5EA99C5A6F41701E342800003B>|ch3-Z-G-15.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  <label|%_fig_3.15>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#4749463839611701C500800000000000FFFFFF21F90401000001002C000000001701C5000002FE8C8FA9CBED00A39CB4DA0B9CDEBC1B0C8662E629E38942E5CA22640B1F6F4C9773CDDEAB8E73510F74C5781E623068F4D1921BA6C6B9901C91C3E5F42AB356B73068E2E7C53EB8ADB0B8A8EDA6CB3B55C07C369173F123FCBBA6CF9FEE775D0D18F8577327B46793F7D0E737B87388D6489888F8D8E1F563186959A9A4C9D9340929D88099E9F944BA88973A76CA966A14ABBA3AFA359BC5C753084461EA2215C5D01BECAA17052C775C9AAC88CCA87CFB2C1C2DB53C6831ED8C6B32215C6C6CDBCD1C6EBD9D3B0C7D9B548ECBFE96025F91CD4E844EFBBD99AE3E1F7FC2BF3F0DD5BB5D4BB0E923C64D9B397CA0F4E9FAE7CD472F590AA5FD02A5221A16FE7BF52A5AFCA591A0278AD4F8916AA28D64BD6312336A8CB42E96A2560C3B9DBC1910E72B56112FDAACE9EBDEB8A1448122EC79149CD2A20B5F0A35BA8E6652A646833EB52A6A275266EEB642954AF5E3D5AA58178ECD57EB2CA3AE5E8146D519562C59B36A45DA15E88D6DDB9A6FF77EC03B376E5FAD4BEBEAF58B6F70582622353106EBE853CC5D8DC5F4BB2C2E7042CC980B72EEAC1972D6D0BC480336DD886065D47459CB75BDF113EC9FB35FD7A692F6365AD819DFE98E9DFBF769D7198AAF165EB62172947E9C92CDBCBC87EAE82D9D3FF748BDF0EEECE96A43E71E5C39F8CDC7611E1E2F7A3BFA0FD8439F5F8F7838FCF7D7CB539F0E3F9C6EFAF9FE93CB5FCF5F55D6F5A7D67FE805482072F8DDC719430D26E85F7AFB8502936CE32D18DD5D8959081E86CB69F88D87098A281C88C590D81F8A137278868AF3B1889A89AE38B11284ADD1A62085A9F111DF81309A26E32934F678E18FA44D566388264D45A08BDEE1049092DCB4661F6B4ECE2693813B8E93A48D57F206259171E842424936FE15DE9310C5F54747155519A391EEE9788D9C39A689259D6DDA59229F730539929F2B1276279E757CD9A1A002EA79A8A26A12DAA7A38C8AC91DA2564EDAA2A4601A4A1CA69669DA29A7563E182268675A7A66AA9142AA6AABF781EA6AAC0EC22A6BAD42D26A6BAE758AAA6BAF7CE1EA6BB076002BE467A69661FEEC65836AB72CB33852C22B48CD429BA1A76C4AF82C4A033E476CA07E023A5A4BB6CD19ED91D616A8A578E28EAB19AA409E1B21B6EAE672A3B9E5927B6FBDF352CB63BC7F76BB9135E0AAC76F64CCA11B98BB6E4D04AFBEE93EECDBB57F264B71C528340397B41927C4A40C211D2C71A525DA434E9720B943233A2AC5F771AA701E3A8C9B6FAE19B241E445C9F1C629DE568ECCF4FC6331CA24A399B3CEF9BD3C232C66DE4CA43CAF7D47D76148E35BED924C41EDB0422B4F75DED4ED8A8CEDC0D9D67BC37B5E270CB6D1ECCA9BEE60F49DFD6F768FA9BD6FB875796C06DCDCCAADA5D87593CD1E1C7A2FCA77D80D138D9871770CFE55E16AFBDD76338530FEEE56DA891F3EEE64F9AE9A61D0170FE1B93F2E9FCAB9B0CE16F91BE54D929EBAE900138E657111BB6EF785B26FFBABECB4170C6073DEB5B77BC80A023F3182AEAB3E23F1F5E1BE3BF2C51A9F18F3CD7B293D5FD51F4FBDF3845C6FBAF623715FAAF7A88F08BE94C1D7BE1FA9271E7BBEF8C3BE0E31A5B9BA8FDBE6A5D9AF2AFDF7E38F83C2B2EA2F1DCC05907FAC7B15FCD846B76001B07F02642001BD64B9D3EDE95A0B8C93E35855A129C54F5715C49CFB4CD631EC5DB064F2030E794A58AB0E5A0884DEE2CA43CEE7B04D7527845BE2120D85A5C2E09489858EC909CEDA17C193FDF0564CBBA10283C8BB1E3E104239C4E0D86A28415F35318A096CD4FE12478444F441D160309C2217A998A92BAE6E845F24A2137198458229F18C47949BFA92A72C18224E8E74B4571DEFF8353CEA716F7BECE3ACFC08C8130572902D24A421C774C8448651918CAC5F231FD9404836D28B3608DD083C634910E42F8D1314A325CAC7334EFEED89A32CE53C3649C624AA7195A454C6DA12954A2D9A128155D41825A7704B12C6B09628F497FC4A914B47F2C6666CA4652F7739105FBA3193CCC49A2C3768445A0A4C9276189A2A5B69CC68F68C9AFDCB8CE6FCC2969425AE6518131E3759421567FA2C811C511A0F3DC6CB7326D16963B1E62B07A24E6BC6249BF254233DB1D24C6AE89327F1ECE7D8067A106DCA43252FD4203FFE0D6A20755A8D4DDFD95A51AC13CCEEF54D5E7E538CD9209A83865EEE5B1BC5DB33415AB217CCED98732CE3DD02774D05BA4475FFA421E438DA8A0065D441C6B959404B6ABF950603413B8DDE3D9150D3C578B06FC62B6AF428071DA19A136174FB26183908C0806200935A7526ED40B9C53CA1F464320CE5580B65D6B3B6EE77CD712A487B03D61DF554ADC4B95D46BD4AD784294F407BCDABF5A0B73EC0FAD5317D858A60079B9AC22ECCAD673D2C1C115B57A73A16B26D8AEBF728FBD73886AF1F98ED643111E9C9CE5295A5FBBBAA684D3BDA4F85F6B42D8DA9675DCADA01AEF6A4A48D6D41536B42D4DA7696B7C5E501217B53D09E72AABB852671DF687743C6029224BD45AE2E8F5B5C7052E98FC98DAE30F136B30DB1CCBAA545D707ABCA5DD99E309AC27D2E6EC34BDEDA3AF0B3E86D6E6BD7A8DBF62233BDAA65AF7CA17BD4DCC2F6BEBC55AF24667BDAE02E32BEF715707D092C5F03EBD7B5FC75480A78AAD9161400003B>|ch3-Z-G-16.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  <label|%_idx_3140><label|%_idx_3142><label|%_idx_3144><label|%_idx_3146>The
  primitive mutators for pairs are <with|font-family|tt|set-car!> and
  <with|font-family|tt|set-cdr!>. <with|font-family|tt|Set-car!> takes two
  arguments, the first of which must be a pair. It modifies this pair,
  replacing the <with|font-family|tt|car> pointer by a pointer to the second
  argument of <with|font-family|tt|set-car!>.<hlink|<label|call_footnote_Temp_349><rsup|<with|font-size|0.83|16>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_349>

  As an example, suppose that <with|font-family|tt|x> is bound to the list
  <with|font-family|tt|((a b) c d)> and <with|font-family|tt|y> to the list
  <with|font-family|tt|(e f)> as illustrated in
  figure<nbsp><hlink|3.12|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.12>.
  Evaluating the expression <with|font-family|tt|(set-car! x y)> modifies the
  pair to which <with|font-family|tt|x> is bound, replacing its
  <with|font-family|tt|car> by the value of <with|font-family|tt|y>. The
  result of the operation is shown in figure<nbsp><hlink|3.13|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.13>.
  The structure <with|font-family|tt|x> has been modified and would now be
  printed as <with|font-family|tt|((e<nbsp>f)<nbsp>c<nbsp>d)>. The pairs
  representing the list <with|font-family|tt|(a b)>, identified by the
  pointer that was replaced, are now detached from the original
  structure.<hlink|<label|call_footnote_Temp_350><rsup|<with|font-size|0.83|17>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_350>

  Compare figure<nbsp><hlink|3.13|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.13>
  with figure<nbsp><hlink|3.14|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.14>,
  which illustrates the result of executing <with|font-family|tt|(define z
  (cons y (cdr x)))> with <with|font-family|tt|x> and <with|font-family|tt|y>
  bound to the original lists of figure<nbsp><hlink|3.12|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.12>.
  The variable <with|font-family|tt|z> is now bound to a new pair created by
  the <with|font-family|tt|cons> operation; the list to which
  <with|font-family|tt|x> is bound is unchanged.

  The <with|font-family|tt|set-cdr!> operation is similar to
  <with|font-family|tt|set-car!>. The only difference is that the
  <with|font-family|tt|cdr> pointer of the pair, rather than the
  <with|font-family|tt|car> pointer, is replaced. The effect of executing
  <with|font-family|tt|(set-cdr! x y)> on the lists of
  figure<nbsp><hlink|3.12|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.12>
  is shown in figure<nbsp><hlink|3.15|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.15>.
  Here the <with|font-family|tt|cdr> pointer of <with|font-family|tt|x> has
  been replaced by the pointer to <with|font-family|tt|(e f)>. Also, the list
  <with|font-family|tt|(c d)>, which used to be the <with|font-family|tt|cdr>
  of <with|font-family|tt|x>, is now detached from the structure.

  <label|%_idx_3158><with|font-family|tt|Cons> builds new list structure by
  creating new pairs, while <with|font-family|tt|set-car!> and
  <with|font-family|tt|set-cdr!> modify existing pairs. Indeed, we could
  implement <with|font-family|tt|cons> in terms of the two mutators, together
  with a procedure <with|font-family|tt|get-new-pair>, which returns a new
  pair that is not part of any existing list structure. We obtain the new
  pair, set its <with|font-family|tt|car> and <with|font-family|tt|cdr>
  pointers to the designated objects, and return the new pair as the result
  of the <with|font-family|tt|cons>.<hlink|<label|call_footnote_Temp_351><rsup|<with|font-size|0.83|18>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_351>

  \;

  \;

  <with|font-family|tt|<label|%_idx_3160>(define<nbsp>(cons<nbsp>x<nbsp>y)<next-line><nbsp><nbsp>(let<nbsp>((new<nbsp>(get-new-pair)))<next-line><nbsp><nbsp><nbsp><nbsp>(set-car!<nbsp>new<nbsp>x)<next-line><nbsp><nbsp><nbsp><nbsp>(set-cdr!<nbsp>new<nbsp>y)<next-line><nbsp><nbsp><nbsp><nbsp>new))<next-line>>

  \;

  \;

  <label|%_thm_3.12><with|font-series|bold|Exercise
  3.12.><nbsp><nbsp><label|%_idx_3162>The following procedure for appending
  lists was introduced in section<nbsp><hlink|2.2.1|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-15.html#%_sec_2.2.1>:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3164>(define<nbsp>(append<nbsp>x<nbsp>y)<next-line><nbsp><nbsp>(if<nbsp>(null?<nbsp>x)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>y<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cons<nbsp>(car<nbsp>x)<nbsp>(append<nbsp>(cdr<nbsp>x)<nbsp>y))))<next-line>>

  \;

  <with|font-family|tt|Append> forms a new list by successively
  <with|font-family|tt|cons>ing the elements of <with|font-family|tt|x> onto
  <with|font-family|tt|y>. The procedure <with|font-family|tt|append!> is
  similar to <with|font-family|tt|append>, but it is a mutator rather than a
  constructor. It appends the lists by splicing them together, modifying the
  final pair of <with|font-family|tt|x> so that its <with|font-family|tt|cdr>
  is now <with|font-family|tt|y>. (It is an error to call
  <with|font-family|tt|append!> with an empty<nbsp><with|font-family|tt|x>.)

  \;

  \;

  <with|font-family|tt|<label|%_idx_3166>(define<nbsp>(append!<nbsp>x<nbsp>y)<next-line><nbsp><nbsp>(set-cdr!<nbsp>(last-pair<nbsp>x)<nbsp>y)<next-line><nbsp><nbsp>x)<next-line>>

  \;

  Here <with|font-family|tt|last-pair> is a procedure that returns the last
  pair in its argument:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3168>(define<nbsp>(last-pair<nbsp>x)<next-line><nbsp><nbsp>(if<nbsp>(null?<nbsp>(cdr<nbsp>x))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>x<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(last-pair<nbsp>(cdr<nbsp>x))))<next-line>>

  \;

  Consider the interaction

  \;

  \;

  <with|font-family|tt|(define<nbsp>x<nbsp>(list<nbsp>'a<nbsp>'b))<next-line>(define<nbsp>y<nbsp>(list<nbsp>'c<nbsp>'d))<next-line>(define<nbsp>z<nbsp>(append<nbsp>x<nbsp>y))<next-line>z<next-line><with|font-shape|italic|(a<nbsp>b<nbsp>c<nbsp>d)><next-line>(cdr<nbsp>x)<next-line>\<less\><em|response>\<gtr\><next-line>(define<nbsp>w<nbsp>(append!<nbsp>x<nbsp>y))<next-line>w<next-line><with|font-shape|italic|(a<nbsp>b<nbsp>c<nbsp>d)><next-line>(cdr<nbsp>x)<next-line>\<less\><em|response>\<gtr\><next-line>>

  \;

  What are the missing \<less\><em|response>\<gtr\>s? Draw box-and-pointer
  diagrams to explain your answer.

  \;

  \;

  <label|%_thm_3.13><with|font-series|bold|Exercise
  3.13.><nbsp><nbsp><label|%_idx_3170>Consider the following
  <with|font-family|tt|make-cycle> procedure, which uses the
  <with|font-family|tt|last-pair> procedure defined in
  exercise<nbsp><hlink|3.12|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_thm_3.12>:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3172>(define<nbsp>(make-cycle<nbsp>x)<next-line><nbsp><nbsp>(set-cdr!<nbsp>(last-pair<nbsp>x)<nbsp>x)<next-line><nbsp><nbsp>x)<next-line>>

  \;

  Draw a box-and-pointer diagram that shows the structure
  <with|font-family|tt|z> created by

  \;

  \;

  <with|font-family|tt|(define<nbsp>z<nbsp>(make-cycle<nbsp>(list<nbsp>'a<nbsp>'b<nbsp>'c)))<next-line>>

  \;

  What happens if we try to compute <with|font-family|tt|(last-pair z)>?

  \;

  \;

  <label|%_thm_3.14><with|font-series|bold|Exercise 3.14.><nbsp><nbsp>The
  following procedure is quite useful, although obscure:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3174>(define<nbsp>(mystery<nbsp>x)<next-line><nbsp><nbsp>(define<nbsp>(loop<nbsp>x<nbsp>y)<next-line><nbsp><nbsp><nbsp><nbsp>(if<nbsp>(null?<nbsp>x)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>y<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((temp<nbsp>(cdr<nbsp>x)))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-cdr!<nbsp>x<nbsp>y)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(loop<nbsp>temp<nbsp>x))))<next-line><nbsp><nbsp>(loop<nbsp>x<nbsp>'()))<next-line>>

  \;

  <with|font-family|tt|Loop> uses the ``temporary'' variable
  <with|font-family|tt|temp> to hold the old value of the
  <with|font-family|tt|cdr> of <with|font-family|tt|x>, since the
  <with|font-family|tt|set-cdr!> on the next line destroys the
  <with|font-family|tt|cdr>. Explain what <with|font-family|tt|mystery> does
  in general. Suppose <with|font-family|tt|v> is defined by
  <with|font-family|tt|(define v (list 'a 'b 'c 'd))>. Draw the
  box-and-pointer diagram that represents the list to which
  <with|font-family|tt|v> is bound. Suppose that we now evaluate
  <with|font-family|tt|(define w (mystery v))>. Draw box-and-pointer diagrams
  that show the structures <with|font-family|tt|v> and
  <with|font-family|tt|w> after evaluating this expression. What would be
  printed as the values of <with|font-family|tt|v> and
  <with|font-family|tt|w> ?

  <label|%_sec_Temp_355><subsubsection*|<hlink|Sharing and
  identity|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-4.html#%_toc_%_sec_Temp_355>>

  <label|%_idx_3176><label|%_idx_3178><label|%_idx_3180><label|%_idx_3182>We
  mentioned in section<nbsp><hlink|3.1.3|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-20.html#%_sec_3.1.3>
  the theoretical issues of ``sameness'' and ``change'' raised by the
  introduction of assignment. These issues arise in practice when individual
  pairs are <em|shared> among different data objects. For example, consider
  the structure formed by

  \;

  \;

  <with|font-family|tt|(define<nbsp>x<nbsp>(list<nbsp>'a<nbsp>'b))<next-line>(define<nbsp>z1<nbsp>(cons<nbsp>x<nbsp>x))<next-line>>

  \;

  As shown in figure<nbsp><hlink|3.16|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.16>,
  <with|font-family|tt|z1> is a pair whose <with|font-family|tt|car> and
  <with|font-family|tt|cdr> both point to the same pair
  <with|font-family|tt|x>. This sharing of <with|font-family|tt|x> by the
  <with|font-family|tt|car> and <with|font-family|tt|cdr> of
  <with|font-family|tt|z1> is a consequence of the straightforward way in
  which <with|font-family|tt|cons> is implemented. In general, using
  <with|font-family|tt|cons> to construct lists will result in an interlinked
  structure of pairs in which many individual pairs are shared by many
  different structures.

  <label|%_fig_3.16>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#474946383961AE006A00800000000000FFFFFF21F90401000001002C00000000AE006A000002FE8C8FA9CBED06A29CB4DA8BE3DBBCFB0F860F2042E5419EEACAB6E399C2EE4CD7601CE2A26EF77ECDF3043FC39FF17893A98A489FA4E960BE96D02A493AA320B00D6EB4DAD3A2C017A5199C356DB799B63BD39D2C8AE2393AACF0BACAF3FA9A51017807A456781468C8E69788829837982517B04806483969798909C9D9442799F0F924D859FA233AC404FA68DA4AF845DA35E54ACB2245371B5BBBBB931BEACBCA2B4C043C062B3B9CCC718BDCACAB0C1DFCFCE76C177DFD7B2C6D5D8D1DFD061EAEE94D4E9D538E5EA2B79DDE5EDCB1EE8E1E6F2E6FCF2E74AF8F0FBFEFCF98EFDF3E7AC604DE2308D0E0BC330ADB21DCD4D0DDC387115B4DAC28912146FE6F173772BC02B1DF158A1EAD4CD2404403C99250C66542C95299CB3EA362265B25A4A6CD613A73AEDC790866CA9F404F09F559F4E644A24977887BFA6605D4A970786A4C42E5EAB2A3B53A6A0DA82E87CA9B5FFB650D3B34A1C5B2CBA49EDD1A83A90DAF68D9BEA359AFABDDBB66EB8E382AF755AFB783FDC6E1119806DDC286B146E11A12124E54412877CBD353ADA65B90213EC96C544BAA4B9453C105559A1BDE6799A9BA067D92D2E8D7E02237227D585BEC41165E424EADFAAF68DFBF33E55299F8704DCBFC6277B68D79B272D3D137C4459EBC4FF0509D553D87CEFDF2ED6EB0B309C3427DAFEEE691CB9BE7857E9AE3C6EFA57D675F2AFEF6F98CFEF717BC8F5F27FA05C8575BEBFD0120819259271F3184B137527F7ABD4352857CB977A02B030A465F5EE37568116DB44925E26BF26487048AF6A868048B19A5E3A243E58C95A04734C6B8C7584DFD02D24718DA34D32E41C634242D459674A4863512B9A4914D22F964883892F3237C516E54257C4589989F890A51346583061A04667EEA2D74A6136952F9201A8BF953A6806B72D4662504866927882D6957E08B7A7A2266410231A7E029BE057AE298F5DD915E715F4E87688ABA54D6102E27457A88251050FA2871FE99141D6C7882FAA7A4A5CA382787FCC15927A9E7747A6A8BA95E1327276F0ED4EA9EB1A2B9AB9ABDB2396B1ABFFAE85A97C59E500100003B>|ch3-Z-G-17.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  <label|%_fig_3.17>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#47494638396106016200800000000000FFFFFF21F90401000001002C00000000060162000002FE8C8FA9CBED06A29CB4DA8BC1DB5CE50F869D13962635A66AA3AD907BB4302CAFB53DC7F33D4AF9CFE1F57242E0A3182402911B26CB678C7A764A69C749AA6A712A1FD6CA757D59E0246D7B4EF722AFB274BC80C7DD47AA1D9D924303C509FD7A27F647A626F8239700B7C7C7208328E6A7531836981848399977C586A0816259C97771D9153A95A979481AC7D9C9F81AE378329BF1D40ACA7A8BEBB608EBD12B998BA4A8EB9B08DC46D2170CF14864D1F8B9DB293D0D06DD57CD4C1D791A54917CDCEDAA4CD8727E1E5A9D3DBE1D4B0B1F2F5C6CFC1E3F1BDD1EFE9BF5A96DEAAE99BE7A0291112C03EDD74076061F2554886C981367000F82F326AEE19FFE510CE9755CF6EDE2C739AC9A543424AC91AD61837A49A4775014CC980A31665429CECCC954387BA2ACC824281E4CD6C8BD03B49327499F44D5652184AA14D4A5328724B5CAB42856A04FB32A8DBA0F9741AF57C98635FA13A0D0A94DA59A7D35F66D59B436B5223DB9566E1D556C2DC5D53B9766DEB4A606D7FD4A98EECDB681153B0EB8556D57AA8C23DBAD9AB831B77B9C9372FE4C7133685A9A5795E6753A73EAB2A157DF75AD1376E0D6B227D7EE7B1B6FEE6BBBF389EAAD1BB82A4FB4777A292EFC75721B6C66CA3EBEDC6974489EA60F9C6E0579EF7FDBFF62E7FB3D8F77D8D7C32F312FDE79EDF2E84DB7AF895DFDFBCAF3057E975FDF72FE63F7FEB5E7F77FDA678D09B85F6CEF8506A06A2615B8607D080EE81E839085F7E06C114A48537C174AA72086096A56E15C216248597B235E7522898F51B8612520D9A6E284F7B5D852347BC5789986604926D787C0F968E13C80D5988F47381E661E162FB206553140EEF62493429668DC543C44791B969EE104939637F2F35B8E127A191C44460669A61064BAB6268F1D7248DF98FBA558E58E1ECE49E34679FE87A79D70BA75E45949EE899A9F0CB65918A108297A609F6FBAC8A8897376361BA5810A3A29A26F68FA238EE39187DFA598FE172A9BA55ECAA967A7A6C69EA832CEC71D949FA21A63AC59B6EA6A8607E26A6A75B9C258A017D141F7EB901456B7FE2A84C4156B2C7AA91AF12C9447460B1EB3541ECAA2B5CD0E3AA3B6D7069BADB762C21AAEB8AF3A58AEB9BA0A379AA53BB40B0FB792027B2EBD88ADB86E2EF23AFB2592CA2968D826C9AE46ED1BFD8E8B1BA0FEE64BCDA8DB916B2FC3DFEA272322AD143C948E093B7C70650197536F96106F2CF1C2FFE24B0CC2EB8DFC566BC57D1CB293FBCEBCB0CBE791ACE499DDB20BCC4B5DAE44B268765D37D1CFE976E7CF4A3A67647448288C54F34C18BF0B6FD5F1CEB3B468565F94E6B7714D8DEA434C676D4FD36BC4CAF5637F815D2BD73E2FA9F5900F415D94776CAB1891322C1519F451FE120D5FC7EABAF968DF0D62F2E9DDBFDA1C29BE5FCEAA78AE8C1B352AB84EB3963CB8C18D636EF25397739EF9CD946F3B711D9F831E7AC627537CAFC0CE44EEEAB32F533D7AEA516C8DCF21B897604001003B>|ch3-Z-G-18.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  In contrast to figure<nbsp><hlink|3.16|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.16>,
  figure<nbsp><hlink|3.17|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.17>
  shows the structure created by

  \;

  \;

  <with|font-family|tt|(define<nbsp>z2<nbsp>(cons<nbsp>(list<nbsp>'a<nbsp>'b)<nbsp>(list<nbsp>'a<nbsp>'b)))<next-line>>

  \;

  In this structure, the pairs in the two <with|font-family|tt|(a b)> lists
  are distinct, although the actual symbols are
  shared.<hlink|<label|call_footnote_Temp_356><rsup|<with|font-size|0.83|19>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_356>

  When thought of as a list, <with|font-family|tt|z1> and
  <with|font-family|tt|z2> both represent ``the same'' list,
  <with|font-family|tt|((a b) a b)>. In general, sharing is completely
  undetectable if we operate on lists using only <with|font-family|tt|cons>,
  <with|font-family|tt|car>, and <with|font-family|tt|cdr>. However, if we
  allow mutators on list structure, sharing becomes significant. As an
  example of the difference that sharing can make, consider the following
  procedure, which modifies the <with|font-family|tt|car> of the structure to
  which it is applied:

  \;

  \;

  <with|font-family|tt|(define<nbsp>(set-to-wow!<nbsp>x)<next-line><nbsp><nbsp>(set-car!<nbsp>(car<nbsp>x)<nbsp>'wow)<next-line><nbsp><nbsp>x)<next-line>>

  \;

  Even though <with|font-family|tt|z1> and <with|font-family|tt|z2> are ``the
  same'' structure, applying <with|font-family|tt|set-to-wow!> to them yields
  different results. With <with|font-family|tt|z1>, altering the
  <with|font-family|tt|car> also changes the <with|font-family|tt|cdr>,
  because in <with|font-family|tt|z1> the <with|font-family|tt|car> and the
  <with|font-family|tt|cdr> are the same pair. With <with|font-family|tt|z2>,
  the <with|font-family|tt|car> and <with|font-family|tt|cdr> are distinct,
  so <with|font-family|tt|set-to-wow!> modifies only the
  <with|font-family|tt|car>:

  \;

  \;

  <with|font-family|tt|z1<next-line><with|font-shape|italic|((a<nbsp>b)<nbsp>a<nbsp>b)><next-line><next-line>(set-to-wow!<nbsp>z1)<next-line><with|font-shape|italic|((wow<nbsp>b)<nbsp>wow<nbsp>b)><next-line><next-line>z2<next-line><with|font-shape|italic|((a<nbsp>b)<nbsp>a<nbsp>b)><next-line><next-line>(set-to-wow!<nbsp>z2)<next-line><with|font-shape|italic|((wow<nbsp>b)<nbsp>a<nbsp>b)><next-line>>

  \;

  \;

  One way to detect sharing in list structures is to use the predicate
  <label|%_idx_3186><label|%_idx_3188><with|font-family|tt|eq?>, which we
  introduced in section<nbsp><hlink|2.3.1|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-16.html#%_sec_2.3.1>
  as a way to test whether two symbols are equal. More generally,
  <with|font-family|tt|(eq? x y)> tests whether <with|font-family|tt|x> and
  <with|font-family|tt|y> are the same object (that is, whether
  <with|font-family|tt|x> and <with|font-family|tt|y> are equal as pointers).
  Thus, with <with|font-family|tt|z1> and <with|font-family|tt|z2> as defined
  in figures<nbsp><hlink|3.16|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.16>
  and<nbsp><hlink|3.17|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.17>,
  <with|font-family|tt|(eq? (car<nbsp>z1) (cdr<nbsp>z1))> is true and
  <with|font-family|tt|(eq? (car z2) (cdr z2))> is false.

  <label|%_idx_3190>As will be seen in the following sections, we can exploit
  sharing to greatly extend the repertoire of data structures that can be
  represented by pairs. On the other hand, sharing can also be dangerous,
  since modifications made to structures will also affect other structures
  that happen to share the modified parts. The mutation operations
  <with|font-family|tt|set-car!> and <with|font-family|tt|set-cdr!> should be
  used with care; unless we have a good understanding of how our data objects
  are shared, mutation can have unanticipated
  results.<hlink|<label|call_footnote_Temp_357><rsup|<with|font-size|0.83|20>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_357>

  \;

  <label|%_thm_3.15><with|font-series|bold|Exercise 3.15.><nbsp><nbsp>Draw
  box-and-pointer diagrams to explain the effect of
  <with|font-family|tt|set-to-wow!> on the structures
  <with|font-family|tt|z1> and <with|font-family|tt|z2> above.

  \;

  \;

  <label|%_thm_3.16><with|font-series|bold|Exercise 3.16.><nbsp><nbsp>Ben
  Bitdiddle decides to write a procedure to count the number of pairs in any
  list structure. ``It's easy,'' he reasons. ``The number of pairs in any
  structure is the number in the <with|font-family|tt|car> plus the number in
  the <with|font-family|tt|cdr> plus one more to count the current pair.'' So
  Ben writes the following procedure:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3192>(define<nbsp>(count-pairs<nbsp>x)<next-line><nbsp><nbsp>(if<nbsp>(not<nbsp>(pair?<nbsp>x))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>0<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(+<nbsp>(count-pairs<nbsp>(car<nbsp>x))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(count-pairs<nbsp>(cdr<nbsp>x))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>1)))<next-line>>

  \;

  Show that this procedure is not correct. In particular, draw
  box-and-pointer diagrams representing list structures made up of exactly
  three pairs for which Ben's procedure would return 3; return 4; return 7;
  never return at all.

  \;

  \;

  <label|%_thm_3.17><with|font-series|bold|Exercise 3.17.><nbsp><nbsp>Devise
  a correct version of the <with|font-family|tt|count-pairs> procedure of
  exercise<nbsp><hlink|3.16|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_thm_3.16>
  that returns the number of distinct pairs in any structure. (Hint: Traverse
  the structure, maintaining an auxiliary data structure that is used to keep
  track of which pairs have already been counted.)

  \;

  \;

  \;

  <label|%_thm_3.18><with|font-series|bold|Exercise
  3.18.><nbsp><nbsp><label|%_idx_3194>Write a procedure that examines a list
  and determines whether it contains a cycle, that is, whether a program that
  tried to find the end of the list by taking successive
  <with|font-family|tt|cdr>s would go into an infinite loop.
  Exercise<nbsp><hlink|3.13|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_thm_3.13>
  constructed such lists.

  \;

  \;

  <label|%_thm_3.19><with|font-series|bold|Exercise 3.19.><nbsp><nbsp>Redo
  exercise<nbsp><hlink|3.18|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_thm_3.18>
  using an algorithm that takes only a constant amount of space. (This
  requires a very clever idea.)

  <label|%_sec_Temp_363><subsubsection*|<hlink|Mutation is just
  assignment|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-4.html#%_toc_%_sec_Temp_363>>

  <label|%_idx_3196><label|%_idx_3198><label|%_idx_3200><label|%_idx_3202>
  When we introduced compound data, we observed in
  section<nbsp><hlink|2.1.3|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-14.html#%_sec_2.1.3>
  that pairs can be represented purely in terms of procedures:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3204>(define<nbsp>(cons<nbsp>x<nbsp>y)<next-line><nbsp><nbsp>(define<nbsp>(dispatch<nbsp>m)<next-line><nbsp><nbsp><nbsp><nbsp>(cond<nbsp>((eq?<nbsp>m<nbsp>'car)<nbsp>x)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>((eq?<nbsp>m<nbsp>'cdr)<nbsp>y)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(else<nbsp>(error<nbsp>"Undefined<nbsp>operation<nbsp>--<nbsp>CONS"<nbsp>m))))<next-line><nbsp><nbsp>dispatch)<next-line><label|%_idx_3206>(define<nbsp>(car<nbsp>z)<nbsp>(z<nbsp>'car))<next-line><label|%_idx_3208>(define<nbsp>(cdr<nbsp>z)<nbsp>(z<nbsp>'cdr))<next-line>>

  \;

  The same observation is true for mutable data. We can implement mutable
  data objects as procedures using assignment and local state. For instance,
  we can extend the above pair implementation to handle
  <with|font-family|tt|set-car!> and <with|font-family|tt|set-cdr!> in a
  manner analogous to the way we implemented bank accounts using
  <with|font-family|tt|make-account> in section<nbsp><hlink|3.1.1|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-20.html#%_sec_3.1.1>:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3210>(define<nbsp>(cons<nbsp>x<nbsp>y)<next-line><nbsp><nbsp>(define<nbsp>(set-x!<nbsp>v)<nbsp>(set!<nbsp>x<nbsp>v))<next-line><nbsp><nbsp>(define<nbsp>(set-y!<nbsp>v)<nbsp>(set!<nbsp>y<nbsp>v))<next-line><nbsp><nbsp>(define<nbsp>(dispatch<nbsp>m)<next-line><nbsp><nbsp><nbsp><nbsp>(cond<nbsp>((eq?<nbsp>m<nbsp>'car)<nbsp>x)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>((eq?<nbsp>m<nbsp>'cdr)<nbsp>y)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>((eq?<nbsp>m<nbsp>'set-car!)<nbsp>set-x!)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>((eq?<nbsp>m<nbsp>'set-cdr!)<nbsp>set-y!)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(else<nbsp>(error<nbsp>"Undefined<nbsp>operation<nbsp>--<nbsp>CONS"<nbsp>m))))<next-line><nbsp><nbsp>dispatch)<next-line><label|%_idx_3212>(define<nbsp>(car<nbsp>z)<nbsp>(z<nbsp>'car))<next-line><label|%_idx_3214>(define<nbsp>(cdr<nbsp>z)<nbsp>(z<nbsp>'cdr))<next-line><label|%_idx_3216>(define<nbsp>(set-car!<nbsp>z<nbsp>new-value)<next-line><nbsp><nbsp>((z<nbsp>'set-car!)<nbsp>new-value)<next-line><nbsp><nbsp>z)<next-line><label|%_idx_3218>(define<nbsp>(set-cdr!<nbsp>z<nbsp>new-value)<next-line><nbsp><nbsp>((z<nbsp>'set-cdr!)<nbsp>new-value)<next-line><nbsp><nbsp>z)<next-line>>

  \;

  \;

  Assignment is all that is needed, theoretically, to account for the
  behavior of mutable data. As soon as we admit <with|font-family|tt|set!> to
  our language, we raise all the issues, not only of assignment, but of
  mutable data in general.<hlink|<label|call_footnote_Temp_364><rsup|<with|font-size|0.83|21>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_364>

  \;

  <label|%_thm_3.20><with|font-series|bold|Exercise 3.20.><nbsp><nbsp>Draw
  environment diagrams to illustrate the evaluation of the sequence of
  expressions

  \;

  \;

  <with|font-family|tt|(define<nbsp>x<nbsp>(cons<nbsp>1<nbsp>2))<next-line>(define<nbsp>z<nbsp>(cons<nbsp>x<nbsp>x))<next-line>(set-car!<nbsp>(cdr<nbsp>z)<nbsp>17)<next-line>(car<nbsp>x)<next-line><with|font-shape|italic|17><next-line>>

  \;

  using the procedural implementation of pairs given above. (Compare
  exercise<nbsp><hlink|3.11|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_thm_3.11>.)

  <subsection|Representing Queues>

  <label|%_idx_3220>The mutators <with|font-family|tt|set-car!> and
  <with|font-family|tt|set-cdr!> enable us to use pairs to construct data
  structures that cannot be built with <with|font-family|tt|cons>,
  <with|font-family|tt|car>, and <with|font-family|tt|cdr> alone. This
  section shows how to use pairs to represent a data structure called a
  queue. Section<nbsp><hlink|3.3.3|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_sec_3.3.3>
  will show how to represent data structures called tables.

  A <em|queue> is a sequence in which items are inserted at one end (called
  the <label|%_idx_3222><em|rear> of the queue) and deleted from the other
  end (the <label|%_idx_3224><em|front>).
  Figure<nbsp><hlink|3.18|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.18>
  shows an initially empty queue in which the items <with|font-family|tt|a>
  and <with|font-family|tt|b> are inserted. Then <with|font-family|tt|a> is
  removed, <with|font-family|tt|c> and <with|font-family|tt|d> are inserted,
  and <with|font-family|tt|b> is removed. Because items are always removed in
  the order in which they are inserted, a queue is sometimes called a
  <label|%_idx_3226><em|FIFO> (first in, first out) buffer.

  <label|%_fig_3.18>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<tabular|<tformat|<twith|table-hmode|min>|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|Operation>|<cell|Resulting
  Queue>>|<row|<cell|<with|font-family|tt|(define q
  (make-queue))>>|<cell|>>|<row|<cell|<with|font-family|tt|(insert-queue! q
  'a)>>|<cell|<with|font-family|tt|a>>>|<row|<cell|<with|font-family|tt|(insert-queue!
  q 'b)>>|<cell|<with|font-family|tt|a b>>>|<row|<cell|<with|font-family|tt|(delete-queue!
  q)>>|<cell|<with|font-family|tt|b>>>|<row|<cell|<with|font-family|tt|(insert-queue!
  q 'c)>>|<cell|<with|font-family|tt|b c>>>|<row|<cell|<with|font-family|tt|(insert-queue!
  q 'd)>>|<cell|<with|font-family|tt|b c d>>>|<row|<cell|<with|font-family|tt|(delete-queue!
  q)>>|<cell|<with|font-family|tt|c d>>>>>>>>|<row|<cell|>>>>>

  \;

  <label|%_idx_3228><label|%_idx_3230>In terms of data abstraction, we can
  regard a queue as defined by the following set of operations:

  <\itemize>
    <item>a constructor:<next-line><label|%_idx_3232><with|font-family|tt|(make-queue)><next-line>returns
    an empty queue (a queue containing no items).

    \;

    <item>two selectors:<next-line><label|%_idx_3234><with|font-family|tt|(empty-queue?
    \<less\><em|queue>\<gtr\>)><next-line>tests if the queue is
    empty.<next-line><label|%_idx_3236><with|font-family|tt|(front-queue
    \<less\><em|queue>\<gtr\>)><next-line>returns the object at the front of
    the queue, signaling an error if the queue is empty; it does not modify
    the queue.

    \;

    <item>two mutators:<next-line><label|%_idx_3238><with|font-family|tt|(insert-queue!
    \<less\><em|queue>\<gtr\> \<less\><em|item>\<gtr\>)><next-line>inserts
    the item at the rear of the queue and returns the modified queue as its
    value.<next-line><label|%_idx_3240><with|font-family|tt|(delete-queue!
    \<less\><em|queue>\<gtr\>)><next-line>removes the item at the front of
    the queue and returns the modified queue as its value, signaling an error
    if the queue is empty before the deletion.
  </itemize>

  \;

  Because a queue is a sequence of items, we could certainly represent it as
  an ordinary list; the front of the queue would be the
  <with|font-family|tt|car> of the list, inserting an item in the queue would
  amount to appending a new element at the end of the list, and deleting an
  item from the queue would just be taking the <with|font-family|tt|cdr> of
  the list. However, this representation is inefficient, because in order to
  insert an item we must scan the list until we reach the end. Since the only
  method we have for scanning a list is by successive
  <with|font-family|tt|cdr> operations, this scanning requires
  <image|<tuple|<#47494638396109000A00800000000000FFFFFF21F90401000001002C0000000009000A000002144C806807ABB74C6B513EC95262D552377D974615003B>|book-Z-G-D-3.gif>|0.6383w|||>(<em|n>)
  steps for a list of <em|n> items. A simple modification to the list
  representation overcomes this disadvantage by allowing the queue operations
  to be implemented so that they require <image|<tuple|<#47494638396109000A00800000000000FFFFFF21F90401000001002C0000000009000A000002144C806807ABB74C6B513EC95262D552377D974615003B>|book-Z-G-D-3.gif>|0.6383w|||>(1)
  steps; that is, so that the number of steps needed is independent of the
  length of the queue.

  The difficulty with the list representation arises from the need to scan to
  find the end of the list. The reason we need to scan is that, although the
  standard way of representing a list as a chain of pairs readily provides us
  with a pointer to the beginning of the list, it gives us no easily
  accessible pointer to the end. The modification that avoids the drawback is
  to represent the queue as a list, together with an additional pointer that
  indicates the final pair in the list. That way, when we go to insert an
  item, we can consult the rear pointer and so avoid scanning the list.

  A queue is represented, then, as a pair of pointers,
  <with|font-family|tt|front-ptr> and <with|font-family|tt|rear-ptr>, which
  indicate, respectively, the first and last pairs in an ordinary list. Since
  we would like the queue to be an identifiable object, we can use
  <with|font-family|tt|cons> to combine the two pointers. Thus, the queue
  itself will be the <with|font-family|tt|cons> of the two pointers.
  Figure<nbsp><hlink|3.19|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.19>
  illustrates this representation.

  <label|%_fig_3.19>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#4749463839612C017800800000000000FFFFFF21F90401000001002C000000002C0178000002FE8C8FA9CBED01A29CB4DA8BE3DBBCFB0F86E24896E6C900A54AB2E80BC7F24CD7A62BE2A16EF7FE0F0CFA781FA2C7284C2A97CC2492F3DC449BD4AAF52A5D69B1DCAE973B75841BE3AFF98C6E6D47E5B4FB0D47B415F3443D8ECF3B3576323F252601A84758786561604441E637B1706718D95431B94847F9D8284827D9E9C6F72797314A9AF188C99952BACADAEAFA0A1BDB8A8703B942A9E83878AADBE7494BCB120AD49BA8BA99A9B9FBFB66BB647928F6E0ECCC2C543D0926BDCD660D87FD3C9CCDC89DE3DD7CFE5C9EDC9D8E06EE7EB49EDA1EFF056F9F45BE6F9EEF85EF8F1FBD653B02760168F092AC85E2123241E8B003C488FF282A9968110BC6FE8CEC387ADBE8514EC8732047423069ADE448952889B5ACC1F2658F981C69CAA461D362CE9B317646F4C91305D0844383AE317A0329A1A201992A05E1341F916205FB3D1D4825EA0C1EF02069D513F56B4F3BBA306DC24555942368A8644E5DD4CB52DB036891CD05E68B6E2817C2E81A53BB56EF49B262EFF112F917B15D5C82B936CCC3956CDEBE7FC3D41A2CEAE95BC082E44EB9ECD853E4CC8A290FE6EB27910AD4100A1BBE94D76F6BD55284AD96FD183261507179AFD6004DA1EFE1AE35F222AE7A6D5ABD67CB2E8FC3B478A19DD2B756797E15F1356452B343F75E0FFC3BF155C99FA9FE0BBD78F59DD87B771F09FE55F9D3CDDFFB4DFFDBEDDCF6FEF7B4CEFFCD4900BAF55F7F81706760560826C8198356609760700E86C35F84154EF8C382186A88E1761D2AF4612521AA3562380C3284E245282E74C38AB29844CD512E8567158D50B171615332DEE8841A3BF26823141CFEF4A33C3D065944523E16011C8C454A74D192481A39E531897914A39433D6C865795D06A21D964F42116595648EA98F90B1D584E634657E99649BF3A8825546599A691D9E6ECA29109D75EA74A022CA10D41377484878A5707D1EA3C313CF7D26E84A9A3494CBA33660306947BB3D36C605980947E9818B527428A29F72E662AAC72D586AAAA6301AAA95A31209EB54B5128A93A988AC892AAED3989A9C8695EE1952ABC2DEAAFE69A1BBAE9A2C731C768A88B1B11296A69883FE19ECAC2714236DB3CE6A0B18AFE1263B64986CCE299B9E63A17BAA9770A6AB69B9E6DA49ACB7501E396B35FAD63B90BCF302CA6EBB715EC3EFBF039BE92873079FABED9D414471A8925A625B598E06D3DA309F30400C6EB5EF26DA87BF143BC471C701E35430BC1F9FD9B0C8231395B2CA403E1CB3C00BBB3BB2CB2F1BE42A2C2AF63CCB2D40B3321FC6F595782FCCF1219D34CF920C989E8050DFFCDD6F4C5B69B1214D66AD1170536BDDA43FFB2D0521D2C07E54B619675F9DB6686DDFC775876F3F3DF7413A7F7837DD03E62D77DCF1F9DDF5D7ED092E11E05D339D624A861F42F8781337C3D0832C1AC4E8F0778FE38BF37A1A6B7339C1EA1A5579809DD3FC7950A1A333FA96998377FA279BA35C3A4FADA7313BE92B6BF67A34F65E6CFBEAEF65BAFB797E9E9C61EAB87B2C33EAC1DBECF9ED4A75BBFC6BCC463FD3B5E2B24E0EA74BED33ED38F4746F9EB4B682C5CFF859F9CA7BD1C64B0FDB6C3B0FB14BA4FDD52EFCAAF27BBFA9F9F6D1AF76EE32D8D238FCF9CE71B1CB93F390C23FF60D5075330B9FFFAEF3C08DAD0F8111146003D55140024DF0201514CA064D1739F27D107607BC1A6442A8A017C1A100003B>|ch3-Z-G-19.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  To define the queue operations we use the following procedures, which
  enable us to select and to modify the front and rear pointers of a queue:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3242>(define<nbsp>(front-ptr<nbsp>queue)<nbsp>(car<nbsp>queue))<next-line><label|%_idx_3244>(define<nbsp>(rear-ptr<nbsp>queue)<nbsp>(cdr<nbsp>queue))<next-line><label|%_idx_3246>(define<nbsp>(set-front-ptr!<nbsp>queue<nbsp>item)<nbsp>(set-car!<nbsp>queue<nbsp>item))<next-line><label|%_idx_3248>(define<nbsp>(set-rear-ptr!<nbsp>queue<nbsp>item)<nbsp>(set-cdr!<nbsp>queue<nbsp>item))<next-line>>

  \;

  \;

  Now we can implement the actual queue operations. We will consider a queue
  to be empty if its front pointer is the empty list:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3250>(define<nbsp>(empty-queue?<nbsp>queue)<nbsp>(null?<nbsp>(front-ptr<nbsp>queue)))<next-line>>

  \;

  The <with|font-family|tt|make-queue> constructor returns, as an initially
  empty queue, a pair whose <with|font-family|tt|car> and
  <with|font-family|tt|cdr> are both the empty list:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3252>(define<nbsp>(make-queue)<nbsp>(cons<nbsp>'()<nbsp>'()))<next-line>>

  \;

  To select the item at the front of the queue, we return the
  <with|font-family|tt|car> of the pair indicated by the front pointer:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3254>(define<nbsp>(front-queue<nbsp>queue)<next-line><nbsp><nbsp>(if<nbsp>(empty-queue?<nbsp>queue)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(error<nbsp>"FRONT<nbsp>called<nbsp>with<nbsp>an<nbsp>empty<nbsp>queue"<nbsp>queue)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(car<nbsp>(front-ptr<nbsp>queue))))<next-line>>

  \;

  \;

  To insert an item in a queue, we follow the method whose result is
  indicated in figure<nbsp><hlink|3.20|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.20>.
  We first create a new pair whose <with|font-family|tt|car> is the item to
  be inserted and whose <with|font-family|tt|cdr> is the empty list. If the
  queue was initially empty, we set the front and rear pointers of the queue
  to this new pair. Otherwise, we modify the final pair in the queue to point
  to the new pair, and also set the rear pointer to the new pair.

  <label|%_fig_3.20>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#47494638396173017800800000000000FFFFFF21F90401000001002C00000000730178000002FE8C8FA9CBED01A29CB4DA8BE3DBBCFB0F86E24896E689A62A5402ED0AC7F24CD7F67DBBA43EF2F80F0C0A8744A12F7404258BCCA6F309052E3DD34E358ACD6AB7DCEBC6FB0073C7E4B259256EA419EBB3FB0D87B715F3443D8ECFEB8BF743DFF0B7273848F82141A7A6A1E630C156F80819B95301C8D6E868796927C9D9F94349046A27BA997988E899AA8AA6A3389A011B8BB16081492B8B9BABBBCBDBEBFB0B1CFCFBE613D8433945B168EA8A60BC0AAD44DCFAAC74EAC7BC6C6A1BDD4D53FDA9E974E51508EE8D8E8A776E421EF6921E8F9677DDE4CE082FAF9FBFDF8EFFDFA39F402403FD69E346B0A0C2770B45DC3B98B0A1446713A54154E7B0A246FE76F28405D35891A34491204BB230C90FA5CA1D2B03B67C1911A615993439905C78B366BF9C0579EAECF8F34BD0A1D88822344AD3A740A5485731DDF7B4A9A7A840A5D6A41A0FAB55485A694DDD9A144AD71CB79AC53404B64C1264D7944170FBEA145C527230A6A49296CCDA663CD6027255AB6F2B3A66D7C5A57649AE32B8841BCD659C37C85E676C150B2D3A79905FCAC5307BE6ECD88F8BBD6323571A558AE2DBBF5FA89D3E59D8706AD6AA617F665829B3693E8D15B9AD1CFB6FDBC4E2E26C165DCAF7ED2ABE47632EBD1B2B74238785036E3E5A0364D088B107DF5D836AF154D3A783BF0C16FAF8F351CCAB72CF7E0CFCAFF137E69D5F3F0B7E4EFBFEF38BBDEFDF44FD453260804C14F80882060EA1E01EDAADB6A03E0F7E77150B0D4618DE83526D87A1371C06F56187D084A813892292B7DE50F59C88CE8A48B9C86234301235638CEF51F8538D364E85A3491E0163C48FBEB423642F291469245477A125194B4B32E952940665E4908E233E3953935252E9E496169DF0C71D875CF80D963651E7E59769E2D5E59467D9A49C926DBE6943986E7289279D79426905603B9989DE2773EAC9E69A59823928237CFD9968A1821A7A28A48112AA66A58A1E41E60CE6001A839D9CE2B6279F9F1E95895DE96CDA6899924E4A29ABA2A6EA6A635EC9B9CDAC6531F74D3DCCAD474E8D6914D76B70C12663486CBB0ADBFE1AB1B4F6662C33CACA304B36A68A96E2AF8125C22BB630B651CB6B872D51CE779942AB6DB3B722E9D1B9851D8B2E5DDC815B6EBB1FBA7B52A917B518AFADDF92DA2987DDD6C6ECB35484482FBBE62241EF5BD9DA7BAF87F94EABF08C39457BAEBEFB5A1CAF86EA624CEDB6C5CEE52CC70AC7DACDB0FC46DC300AE2182CB27529C7355B6F27A3DC72592D576B33C932820A71A43894F3F299803E146AD14561DCE3D155BD8CAA143C036CB4CF3DD71BF5AB31439DB4D2593D0DB5A57572ED6DD53A533DF5D88EDE4C99D70E0354B3D930003DB3D0B0927DB5D555E34A9BDD25831DB6DAAAA66C4CE07CD3ADB7DF7D3F27F67B8337FD28E077B64A74AB67F7FE9CA2DBE42D3EEA3C6CD75DB8DC33333E34B6733B252F2E41961E0B91A8C372E4EAAC83342EA20E16123B81F8CE4E48ED5CDDAE87EE656FE55CD69AF56EA1EEDA094FE3F137166F9CF2EB64E7BB831A5FEE5CF356EA35F27926D25EB97CDDABF5BD55E1E73EBE16E56F71FE8BD793BFBEF9EDA3FFBEFAD15BE37BFCF0CF2F3DFE03D78FFCFDF9F59F3FE969467FDE03125700D81EFC215025A03B8330C66140080EA342A3335FE6345541B2AC0A7617FC4F06FF26B99F7D50401D7C4203D194380DA63024251C470B57E029176ED03E23F4E00C416838A7DD90843534E10B35B7C2F0F410273FE44DDB0EA7A520E29054043462C58E68C15B586E89930B45BD6BA04843B0D50E6F9B63D0103BE539ADBD846558C402197FF7B55AA15185CC2A230F67852CE368E3604E4C0D1D0F640931126E250683971CB9E1473C1ED13D020BA44C4EA89644E4AD6B28B463DC1A871A08718E8145B4E2C6DC48AE4B4E3289015B230BBF28C81D6652891814654310893D501E4995400C611649294353BE8D95AB94A54250299F4ACA0E9660B4654F74D9485752516A96E4E52F6919CC1CB2519922F4E5401EF84767AA0C99BB14E68EA4F0117B44509B132C430100003B>|ch3-Z-G-20.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  \;

  \;

  <with|font-family|tt|<label|%_idx_3256>(define<nbsp>(insert-queue!<nbsp>queue<nbsp>item)<next-line><nbsp><nbsp>(let<nbsp>((new-pair<nbsp>(cons<nbsp>item<nbsp>'())))<next-line><nbsp><nbsp><nbsp><nbsp>(cond<nbsp>((empty-queue?<nbsp>queue)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-front-ptr!<nbsp>queue<nbsp>new-pair)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-rear-ptr!<nbsp>queue<nbsp>new-pair)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>queue)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(else<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-cdr!<nbsp>(rear-ptr<nbsp>queue)<nbsp>new-pair)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-rear-ptr!<nbsp>queue<nbsp>new-pair)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>queue))))<nbsp><next-line>>

  \;

  \;

  To delete the item at the front of the queue, we merely modify the front
  pointer so that it now points at the second item in the queue, which can be
  found by following the <with|font-family|tt|cdr> pointer of the first item
  (see figure<nbsp><hlink|3.21|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.21>):<hlink|<label|call_footnote_Temp_366><rsup|<with|font-size|0.83|22>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_366>

  <label|%_fig_3.21>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#47494638396173017800800000000000FFFFFF21F90401000001002C00000000730178000002FE8C8FA9CBED01A29CB4DA8BE3DBBCFB0F86E24896E689A62A5402ED0AC7F24CD7F67DBBA43EF2F80F0C0A8744A12F7404258BCCA6F309052E3DD34E358ACD6AB7DCEBC6FB0073C7E4B259256EA419EBB3FB0D87B715F3443D8ECFEB8BF743DFF0B7273848F82141A7A6A1E630C156F80819B95301C8D6E868796927C9D9F94349046A27BA997988E899AA8AA6A3389A011B8BB16081492B8B9BABBBCBDBEBFB0B1CFCFBE613D8433945B168EA8A60BC0AAD44DCFAAC74EAC7BC6C6A1BDD4D53FDA9E974E51508EE8D8E8A776E421EF6921E8F9677DDE4CE082FAF9FBFDF8EFFDFA39F402403FD69E346B0A0C2770B45DC3B98B0A1446713A54154E7B0A246FE76F28405D35891A34491204BB230C90FA5CA1D2B03B67C1911A615993439905C78B366BF9C0579EAECF8F34BD0A1D88822344AD3A740A5485731DDF7B4A9A7A840A5D6A41A0FAB55485A694DDD9A144AD71C1ECB9A1D06D6261D659A944170FBEA145C52696B8C5598A41E8FBC805CD5DADB6AED5DA98307E62D86EC52336E8147D535F298A1B3237CDFF6FD42AD92E6C50DC5C534F43972A9C97215B3F54CDAAFE97A3D53F4A9537829E49F6E41956E0457F0A1B9B9358BF62A85354CCACDF6FA6EEC0759F293A42FFEF6FDFC04F1D1C891036471F87A74E8DB594E2EA5C838F32AE15D88E74CB17B51F5C76EABA6665E43EFD4F0CB0B67AE3E367B2A28FEF443DDEF066A16B1E71F803814589581D120989582DD30980E840EAEB09B84A9C867D9849C54B8DD6E1A76C26174F37D5808861D0A48E22028D635628A82ACC8227A2EBE785F6435CEB8878C36EA88233D164273A34A67F562C490BBB463A42EAE2599CB4E290DF8897752BA446546FD4D694890403E095A107F18032697FC5D59251526EA638E98DF60191A946D8E291D9B9859D7A09C704659E69B77EAA91699569A291E9A6AF629859D7BF22994A16E766945714E2A9A68A1792E4AE9A18C1AF4E79CA3259829A2317C89E9A4968EEAA973B7542628A492E1D969A9DA553A939FA5DEF7630E8CD448DE8D3989932BADB7EA988667E4E0FA6B32592ED1FEABB161C858AB0DC9A2974C8BBB5E9088AFCC283B275BD55A7B2AB7368912AD80E500FB68B7D05ECBA42FE672F66CBAED02B7AEBBE17A2BD8ABE8BC8B117DD8DA35622D9BC6C52C122DBE25EEB6E73A4457720567B26A9DEBC20BF0BE30CC924DBEFA1E85AE790623BB31C4D95E33EFC1F5361C61B118F745EE0CBC1AEC715CA6EAF6AFCB2DA77632C3162B2C31CA84723AF37AAD3A4BB2CF3F5FDA3377B01E8D5FCC3CC67C6FD04223FDA9D349BBFAB2D1E9898A28798E91BAA0D453136DABBD56838DF44343677DD0D2377B538ED8B14AFA7298837EFD34D9678F3D1E6CE5D64CF7DBACD62C37A46653ED75DF9911BEA1D7697A2975E058E3DDF7CE7327FEFBF8966E471EE9DF453B7E77E48BC7E9B6969703292F2C45964EF124A853DBDFEAAC6FD4748E251218BB1ECD4AFEDCEDF3C84E88EE9268ACF6ECF460E7FB77A23715E254C0174F708671C8173C521E3A85DD3A3096111FF3BD5F5F22F75A0C6C06F85B79AF22F95998FFFDF184A94F23FB58A07FBEFB46C99F63F4E96BFF4A77F4DB6E7FFCF837A7BFFF094C80FDDB42015B228C48EC4F2C02BCCCF8E666C08FD803180C444B5854F53D0802AD729AB39B9034783E10AE898307C220EC4CF83E11AA0C857661E14854281618468D8461EB5C493E470C194ECC852BA4614874680F20EECE8625F4E144701820BED58D71461C61D01A380E96156D0CD1CA5CC22878280330884C2662C859F8AA06B92212B186F68262102BB636323C4B896494591A9968AE299A446BCE631AF6B4B1C52BC22B8F7CB044DDCCC8047CD9518D6993631B9778B5336284635711621FFD58474476F0386C14E3D6F8884047EA5137015364C40C69C94F0E1225483C43296733C60DA6F2889A1CC229E188B81EAEF28558F4642C77D84459DE122FAD44E52C67F8CB2CD6B235C37C642E71194C60EE9298C7B425D454B94C0A1573291294432F85A81F50F5E87DD5E403059FD0CD311400003B>|ch3-Z-G-21.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  \;

  \;

  <with|font-family|tt|<label|%_idx_3258>(define<nbsp>(delete-queue!<nbsp>queue)<next-line><nbsp><nbsp>(cond<nbsp>((empty-queue?<nbsp>queue)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(error<nbsp>"DELETE!<nbsp>called<nbsp>with<nbsp>an<nbsp>empty<nbsp>queue"<nbsp>queue))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(else<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-front-ptr!<nbsp>queue<nbsp>(cdr<nbsp>(front-ptr<nbsp>queue)))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>queue)))<nbsp><next-line>>

  \;

  \;

  \;

  <label|%_thm_3.21><with|font-series|bold|Exercise 3.21.><nbsp><nbsp>Ben
  Bitdiddle decides to test the queue implementation described above. He
  types in the procedures to the Lisp interpreter and proceeds to try them
  out:

  \;

  \;

  <with|font-family|tt|(define<nbsp>q1<nbsp>(make-queue))<next-line>(insert-queue!<nbsp>q1<nbsp>'a)<next-line><with|font-shape|italic|((a)<nbsp>a)><next-line>(insert-queue!<nbsp>q1<nbsp>'b)<next-line><with|font-shape|italic|((a<nbsp>b)<nbsp>b)><next-line>(delete-queue!<nbsp>q1)<next-line><with|font-shape|italic|((b)<nbsp>b)><next-line>(delete-queue!<nbsp>q1)<next-line><with|font-shape|italic|(()<nbsp>b)><next-line>>

  \;

  ``It's all wrong!'' he complains. ``The interpreter's response shows that
  the last item is inserted into the queue twice. And when I delete both
  items, the second <with|font-family|tt|b> is still there, so the queue
  isn't empty, even though it's supposed to be.'' Eva Lu Ator suggests that
  Ben has misunderstood what is happening. ``It's not that the items are
  going into the queue twice,'' she explains. ``It's just that the standard
  Lisp printer doesn't know how to make sense of the queue representation. If
  you want to see the queue printed correctly, you'll have to define your own
  print procedure for queues.'' Explain what Eva Lu is talking about. In
  particular, show why Ben's examples produce the printed results that they
  do. Define a procedure <label|%_idx_3260><with|font-family|tt|print-queue>
  that takes a queue as input and prints the sequence of items in the queue.

  \;

  \;

  <label|%_thm_3.22><with|font-series|bold|Exercise
  3.22.><nbsp><nbsp><label|%_idx_3262>Instead of representing a queue as a
  pair of pointers, we can build a queue as a procedure with local state. The
  local state will consist of pointers to the beginning and the end of an
  ordinary list. Thus, the <with|font-family|tt|make-queue> procedure will
  have the form

  \;

  \;

  <with|font-family|tt|(define<nbsp>(make-queue)<next-line><nbsp><nbsp>(let<nbsp>((front-ptr<nbsp><with|font-family|tt|...>)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(rear-ptr<nbsp><with|font-family|tt|...>))<next-line><nbsp><nbsp><nbsp><nbsp>\<less\><em|definitions<nbsp>of<nbsp>internal<nbsp>procedures>\<gtr\><next-line><nbsp><nbsp><nbsp><nbsp>(define<nbsp>(dispatch<nbsp>m)<nbsp><with|font-family|tt|...>)<next-line><nbsp><nbsp><nbsp><nbsp>dispatch))<next-line>>

  \;

  Complete the definition of <with|font-family|tt|make-queue> and provide
  implementations of the queue operations using this representation.

  \;

  \;

  <label|%_thm_3.23><with|font-series|bold|Exercise
  3.23.><nbsp><nbsp><label|%_idx_3264><label|%_idx_3266>A <em|deque>
  (``double-ended queue'') is a sequence in which items can be inserted and
  deleted at either the front or the rear. Operations on deques are the
  constructor <with|font-family|tt|make-deque>, the predicate
  <with|font-family|tt|empty-deque?>, selectors
  <with|font-family|tt|front-deque> and <with|font-family|tt|rear-deque>, and
  mutators <with|font-family|tt|front-insert-deque!>,
  <with|font-family|tt|rear-insert-deque!>,
  <with|font-family|tt|front-delete-deque!>, and
  <with|font-family|tt|rear-delete-deque!>. Show how to represent deques
  using pairs, and give implementations of the
  operations.<hlink|<label|call_footnote_Temp_370><rsup|<with|font-size|0.83|23>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_370>
  All operations should be accomplished in
  <image|<tuple|<#47494638396109000A00800000000000FFFFFF21F90401000001002C0000000009000A000002144C806807ABB74C6B513EC95262D552377D974615003B>|book-Z-G-D-3.gif>|0.6383w|||>(1)
  steps.

  <subsection|Representing Tables>

  <label|%_idx_3268><label|%_idx_3270>When we studied various ways of
  representing sets in chapter<nbsp>2, we mentioned in
  section<nbsp><hlink|2.3.3|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-16.html#%_sec_2.3.3>
  the task of maintaining a table of records indexed by identifying keys. In
  the implementation of data-directed programming in
  section<nbsp><hlink|2.4.3|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-17.html#%_sec_2.4.3>,
  we made extensive use of two-dimensional tables, in which information is
  stored and retrieved using two keys. Here we see how to build tables as
  mutable list structures.

  <label|%_idx_3272>We first consider a one-dimensional table, in which each
  value is stored under a single key. We implement the table as a list of
  records, each of which is implemented as a pair consisting of a key and the
  associated value. The records are glued together to form a list by pairs
  whose <with|font-family|tt|car>s point to successive records. These gluing
  pairs are called the <label|%_idx_3274><em|backbone> of the table. In order
  to have a place that we can change when we add a new record to the table,
  we build the table as a <label|%_idx_3276><label|%_idx_3278><em|headed
  list>. A headed list has a special backbone pair at the beginning, which
  holds a dummy ``record'' -- in this case the arbitrarily chosen symbol
  <with|font-family|tt|*table*>. Figure<nbsp><hlink|3.22|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.22>
  shows the box-and-pointer diagram for the table

  \;

  \;

  <with|font-family|tt|a:<nbsp><nbsp>1<next-line>b:<nbsp><nbsp>2<next-line>c:<nbsp><nbsp>3<next-line>>

  \;

  \;

  <label|%_fig_3.22>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#47494638396129019D00800000000000FFFFFF21F90401000001002C0000000029019D000002FE8C8FA97BC00FA39CB4DA8BB3DEBCFBE880210294DF89A6EACAB6AE344231F9D6F68DE7FA54F64D1F02C686BE9DF1884C2A1B32C3C8E4A44597D4AAF58A990584D3EE53A8C58AC7E4E3730A4D9F99E5B6FB7DE36EC1F23A108ECFEBF7FCBEFF0F182838485868788898A86818B6E8F8A8D408394969235989997972A9D9E969C1F9293AAA104A7A2A6A8ABA9AA9CAFA0AE90A3B9B284B7B4B688BBBFBA7CBFBABE70B3CEC264C7C2C668CBC4CA5CCFC6C062D8DE73C6DFD527DADAD92BDEDEDD1FD2D9E113E6E4E517EAEFE90BEEE2EF51E0F1ED52E2F1EB465AF4F9E5FBFBFED20E0BF813CE6103CD8040AC285098A307C6810224485121752AC88D01FC6FE4E743A7AFC08F2A2A590244BD2E9603265CA4D2A5B7ED460CC9946063151DA8479731E4E7222D16D90B9A32607A03B7F6E329AC5E105A14873302D0A7569CEA952979A10F6949F8EAC59A882F21AF52BA834612B1075DAB4AC58AD6987B615B1A6AB5AB341DF56B5EBD3ED07AEEC2862C54B772BE0BC834180652B17C6C5BF7309E3E0BBB6B161BD3A11F7D5C29866CF7C979BB050DAA51468369A2F991ACDB9344DB8ECCC4A7ABD3975E75273E534BC1C7BE61CB20BC0F4C6FD7AAC42D8A84DDB86870E7423DFB4656CCEDC9039F2E8777E3F7E7E9C34F5EACD9362CF2E5B34F7E9C205F6061F9E7A6BCB3FC01377097FA5F8E2A5E3CB9F3FDAB87D93E9FE9DA027EE5962F85977DE78E4AD70C772FFD5979B55BCE117867EF43938048311AA16E05D0376B72181DC2887DB6A0CAE071766C07958E072AEA9589F88D115C4DE6D2E4A86E064280A18E381A1E588A38C33FAE75864376AC7630B9C04479964481616D88F3E021964934E12D9630D479248A38D53EE586591A691200B744372A9611C5A3E59248C58A2D9659BFD9116DB96309CA9A3946666C866996EBEC967948D7D891A9D7ED679D663829229E49E4B66A9E698FEC5B9A69D1CE699A89587F6D9689A8BA629699DBB310AE17E2D0525AA7D28951A1F4BA88EFA1926BA6123C8AB355622AB91B1F6516B15B9CE0AC8AE47D1DAEBAD7CF81A49B081105BFED924C8FE6AEC1ECB46D38BB0CEBADA6CB4C3526B6DB5793C6B04B78705832BB67E789BECB6E2867B2CBA9490CBE41BECEAE9C8BB9CBAAB6EBCF48C2B2DB8B1DCAB2F3ED7FA5B0C1A8F08242F8CE6FD8B2816F814DCEAC1E63A0C2EC001435C4B44D352BC2DC66410BC2FA41BF7D38BC663701C8BC71B9B5CC655C1A01C2BC32BF62AF2C82C1FEB727235BBE6ECCCE98E7B33CE2BF7CC8DB6B872BB2AAADD16CDEA4F48AB84C2D24CE39969D3DDB60B35BC83760AEAA48A5E412C64587F3D6792DF865D98BC5D531DA9D551ABBD67D5957A5A57DCF3BA0DF6A557B79DF6DB54267176D68EDE6DF7DA7EC34DB69C53CB8D37DD802B2EF8DC7F379EF0E1820DFE4E69DD8C173E76E0986BADB7E352534EB8E6795B4EBAE190CB56A108E235DAF77CA33FFABAE006C23D7BE456D76E7BA0980651DD69A6D7213998B84BC8A25DD255BEDB847BA5F89C73815E097BF25F14711C117E0D177C7BCF3BAF7C59C77BFABDED95869FF0499CC3E3D097A9610F677B7B5B0AA19CE623BF36F97D921F4E84E8F1393FED4CC4A53D89C5C57C076B9DF0B6079C0B89ED5108B4D0E3C6B73FE2FD8E44FE5203945077BA56A5E875113C0CEE76D7C072698F83C3BB941D5E223D066EEA4E863B4DF19414BBE8D1AF730D929DE80C85B8F389EF82A163DC0A35F340B0D550318F335BF690A78A9E14CA51491449FE4C989C2272ED88E0F359FE0F63F74320CEB06E593C8F0E7788C3C9B5F065579CA0E984B745C07551345FC49418D1C2C1B1A4118B3104D31C3757B930CD007ABAA2E2FBC0F883324AF18C68FCE3D6081948DA392D55A45A24494EE5C890342D92927C463A74B640A5212B7F409B560A7417B4499AA11B98BC453B4AE939C5748D93D7A8072AD9C693A389121A0BFB50CC9022B1A1A80C7EBB04C72D4DC9AF4FE672799C61A5AC02F2CB28763265C114A61BF991CC97BD0A99CF9C4C2F8F41B20F55532AD12CC8356D05CAAF7C7318D40C653871D2CD397D5098AF5CDD323FD6CE04D6289EB439E75EECE9137CC2A29C9FD1A77010E44F4D96639DBBA0276B00EACA80C2C4A0855C0643FE9D8750233DD439FDB4E4315D898D8B4A1417FB29914B6CC6C80426CDA323B5D0D3525136AA29838F73F39A216F682F18326AA5300DE236DB78D33B2AC2A539ED214D2F07D49EBE54A8805C044F793A541F66D2A60F44EABE64DAD2A526B58E4475A3530796D2994AB5A838E52AE1AE1A534DA994902C4D1C52C16AD4AC1688AA0AC223A174974426BD478128856A3DD91AC3B2A20F9167AD1F29E63AC8D1C575448175DB6039752425FED5AF4AE52B05E9FABB3582AF7B914564583BE43FBA1D964390FD5B9C36EB2327BA354FEF84958814DB589BC286872F5DED9B409B59A0769623F2A41F60BBFADA0E6AB6848D03E050DF63D9B4DA15965335A3561D643843B4EE54AD66DD6A55ABD957D03182B9C4F56A6CA34A23E5566CB89D13A46D9D5B5C9C6A1711471D2B75AB5BD5508CF710E53D2E77BB1BDEE4A24DB862756F7DED4BDCF54EF7BD8BB36E6BC1EB5FABCE77A7A6E2DE4779D051031F5895F061B04B0A00003B>|ch3-Z-G-22.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  To extract information from a table we use the <with|font-family|tt|lookup>
  procedure, which takes a key as argument and returns the associated value
  (or false if there is no value stored under that key).
  <with|font-family|tt|Lookup> is defined in terms of the
  <with|font-family|tt|assoc> operation, which expects a key and a list of
  records as arguments. Note that <with|font-family|tt|assoc> never sees the
  dummy record. <with|font-family|tt|Assoc> returns the record that has the
  given key as its <with|font-family|tt|car>.<hlink|<label|call_footnote_Temp_371><rsup|<with|font-size|0.83|24>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_371>
  <with|font-family|tt|Lookup> then checks to see that the resulting record
  returned by <with|font-family|tt|assoc> is not false, and returns the value
  (the <with|font-family|tt|cdr>) of the record.

  \;

  \;

  <with|font-family|tt|<label|%_idx_3280>(define<nbsp>(lookup<nbsp>key<nbsp>table)<next-line><nbsp><nbsp>(let<nbsp>((record<nbsp>(assoc<nbsp>key<nbsp>(cdr<nbsp>table))))<next-line><nbsp><nbsp><nbsp><nbsp>(if<nbsp>record<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cdr<nbsp>record)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>false)))<next-line><label|%_idx_3282>(define<nbsp>(assoc<nbsp>key<nbsp>records)<next-line><nbsp><nbsp>(cond<nbsp>((null?<nbsp>records)<nbsp>false)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>((equal?<nbsp>key<nbsp>(caar<nbsp>records))<nbsp>(car<nbsp>records))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(else<nbsp>(assoc<nbsp>key<nbsp>(cdr<nbsp>records)))))<next-line>>

  \;

  \;

  To insert a value in a table under a specified key, we first use
  <with|font-family|tt|assoc> to see if there is already a record in the
  table with this key. If not, we form a new record by
  <with|font-family|tt|cons>ing the key with the value, and insert this at
  the head of the table's list of records, after the dummy record. If there
  already is a record with this key, we set the <with|font-family|tt|cdr> of
  this record to the designated new value. The header of the table provides
  us with a fixed location to modify in order to insert the new
  record.<hlink|<label|call_footnote_Temp_372><rsup|<with|font-size|0.83|25>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_372>

  \;

  \;

  <with|font-family|tt|<label|%_idx_3284>(define<nbsp>(insert!<nbsp>key<nbsp>value<nbsp>table)<next-line><nbsp><nbsp>(let<nbsp>((record<nbsp>(assoc<nbsp>key<nbsp>(cdr<nbsp>table))))<next-line><nbsp><nbsp><nbsp><nbsp>(if<nbsp>record<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-cdr!<nbsp>record<nbsp>value)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-cdr!<nbsp>table<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cons<nbsp>(cons<nbsp>key<nbsp>value)<nbsp>(cdr<nbsp>table)))))<next-line><nbsp><nbsp>'ok)<next-line>>

  \;

  \;

  To construct a new table, we simply create a list containing the symbol
  <with|font-family|tt|*table*>:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3286>(define<nbsp>(make-table)<next-line><nbsp><nbsp>(list<nbsp>'*table*))<next-line>>

  \;

  <label|%_sec_Temp_373><subsubsection*|<hlink|Two-dimensional
  tables|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-4.html#%_toc_%_sec_Temp_373>>

  <label|%_idx_3288> In a two-dimensional table, each value is indexed by two
  keys. We can construct such a table as a one-dimensional table in which
  each key identifies a subtable. Figure<nbsp><hlink|3.23|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.23>
  shows the box-and-pointer diagram for the table

  \;

  <with|font-family|tt|math:<next-line><nbsp><nbsp><nbsp><nbsp>+:<nbsp><nbsp>43<next-line><nbsp><nbsp><nbsp><nbsp>-:<nbsp><nbsp>45<next-line><nbsp><nbsp><nbsp><nbsp>*:<nbsp><nbsp>42<next-line>letters:<next-line><nbsp><nbsp><nbsp><nbsp>a:<nbsp><nbsp>97<next-line><nbsp><nbsp><nbsp><nbsp>b:<nbsp><nbsp>98<next-line>>

  \;

  which has two subtables. (The subtables don't need a special header symbol,
  since the key that identifies the subtable serves this purpose.)

  <label|%_fig_3.23>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#47494638396161015401800000000000FFFFFF21F90401000001002C00000000610154010002FE8C8F09C9ED0FA39CB4DA8BB3DEBCFBEF2D1120226409A6EACAB6EE0BC71BFAD0872DE7FACEF7FECF38916E428310853C0197CCA6F3E9C3DD8CC4A93520856AB7DCEED676A45E4BC7A1F78C4EAB5F64B1F9DDBEAEE7F4BA7D54C496C37A65DF7C172838485868788898A8B8C8D8E8F808192939495969798999D998A5D9E929C8F9293A8A164A7A8ADA649ACADA9AB3EA1A2B9B023B6B7B7B518BBBCBDBA0DB0BCCFB1B4C3C3B5C8CCC7A9CCC3CBADC0CADF91C4D5D395D8D0D799DCDBDB8DD0D6EF81D4E1E385E8E3E779ECE7EB6DE0EEF24321F5F4F48FF6EAFAFB3D0BFFF5FC75F3E800457082C88D01DA0840CA1F8690851D5C288147B4CAC88915FC6FE8D3B0672FC083264883D244B9A3CE95164AF9412D6A17C099324889834637E7C76CDE592712C6BF4AC86B3834E0D3967CE207A9162500E433314FDB034973F8E5189AAA8EAD4A855A9623662C5D014AC50AD592D00FA49ED6BAEAB479992155B6121DA686ACDB2DDDA36445E3C34E642E3F45041CB2CBF927685BBD72D5E08810F63249C47B0CFC672E25E0C45B825630A861D4B76608A32969BA0CB0461CCE7B3533F9045038EAC7A300E29A9630731ECB7196DD3B64DD4FCBDA734ECCA0A6A139F1079F770CFBE335315EE1AF5F2D133CE42A7FC1AF86FEAB7A7B7DEFCFCBA2FE9B8C162BF3E9B7CD2650F9547F7D5997944CC3506D7B77B1FFE7BF1E3FE2D5FE67F5A779A85975F80898D3519687C15881A78A531D80772A43968E0627A51D81B7E172AC8A068FD793502846BD1122287075A98E1611E7E98117D26A2A89888F2C5F5568506AEC8E26325E68818543BDAD8638C3C9A60447C43CEF7638A9CDD2523773096F5E269464659917656F2562390C769882095CD3DA9526E421EE963995E5601A648625677659B33B579A54A679A238E9C1625B2A64176F290670B7D92B8A74688FC9965A02E10CAE42088125867218B823868A386C6F0A8998A4E2A43A51B5E8A290C9A76C969A787E229A9A82C7C3A269DA6FA49AAA3ABB21AA9ABAF6A458FACAAD63A6B5BB8864AE7AEB9663595ADBDCEF8AB84C1DE83FEECB1C58AA52C288E36BB2C8D53AAF3AC93D14A856A9A6B0C916D423806F46CB7DE4EBBAD38E27ADBEA3DE722B42E97CE5E4B4ABBF00A0567BDDF823A2F1DF76ACA92BCF66A77EABFDBD12B704D033ED16FB9DA2669E9880B1F1C2467DC42AC8AA70A438971A14B9EE870C4B2110B329F16AB51D7C68976EC31CAEE7E1C32BF23A751B2847A3EDC248D34178904C54C244C32C726039AB1CA29CB8CDC44A1E19BEAC95EC4ACF3A642DB9CF4CFD269A95ACEF615B74A1CA3F67C33993E370DF5D70CC337A7157CC0421B5F13B371F1D0444BEDF5D86177AD64913577C51A6C67EBDD5C12BECE0CF364694377B77E4D4E676DDF85E30C86E065EB81E187ED95FE4886D6DC55FEB7D25DB8B71E7A8F9397219644EAE7E1309393DEB94F728F3E9AE544B0C63AE6794CC573E0A8A7777BC13225CE78EADDE91EDCED644E79B48971C061B78A606BFC85E7548BCE3A9B5B422F1FF5210388F57E5F2EBFE51FB2EFBE77E92F97E27CE8C675AFF6F3E7F3EEFDE0FE45DFB7EFAFC34DF50FB5934FF8F02B16165F6BEEFFBEB808D50F717D2117FBE0B7B3F1B92372085C99D394348D6DB88845F76A60DD44C636AE952D82A76220FAB8473F0B5ECE802DD3C2FD1658330E02CE6B2A8C5AF7E641C2123A44814BF3E0F502E840F4B5506C99A960FD3E88C1ADD96E832EFC1A608A18C217FAF087377C050D3767C303BE8D7952DCA1FEB6BEB330E0C52983438C1B128326C207BAED8031BCA025FCA5C597042C8D2719091BDB780A79AD4E55BC02871CA378873B7EEE2FA5EA631ED1A1C73DEA4B5876F423B20E498E407A115C880C87229968874786312D86ACE31FCB21C949469290DDC824101969496E78B2896DA3A3232BF9AE5066639452BCA42AB1C14A56522173A5EC242A37494B0D9E9293CECA650D5B97C86491128AD0B25D312979295FAAE3982864261F9339CCCD39B386650C86270F62AE56525396B58CE434B7554D79402E98EAD2E6321515CE95840B4F994CA73AAB35A87672B39BDE04883B85C185371A6C8DFA0C1E53FA591254A0AA3042D45C12A708C68322D413039D6107FEE966C6394A1484976828C2609550852E54A3133D633E1DBAC2A771B4A382C4E1242C2ACE876674A33964E9482981D28AA9748C24C5A34D6B7AD28F5E74A62275E94B2189534934F45B8DA3A2D86E6AD2920215A930D5692B8BDA308D21AE8ADE11E31F524840813AD56F30CC5B7BBE5A84B361347EFFCB9EFC60643DAA8A2F8E5B8D9D67A0DA55DFB861ACAF5BABF096CAC0B4FA4F7BA240E9F7D606BFE05C06763CED5D59C9BAC8B1E955707CFD845F11783CB3DDE633CA44EBFAD47A56302E96B14A15EA47C30707AF8676B45D759D54F7B7A0C47A70AA98B1AB339C2AD3904E326BB843A273F0D0D948C4348185FD206DA1CAC3006696A1B0E5AD6C7DFE2B31BCDEEDB6B855AE679BB7D3E382AC1646B3EA0B2DE35CDD167727749D2D76350942E63617BCD6D82E1006225EE5CAC5BA33D24575D90ADD944AD79CEF8B261379D217AD7E01A06AE4277F97C8D8FFDED31B05C9C780E7F6CF58CCF310063EB04FB9D28A05DFB23A827A932B24CC4BA8A0E51D0E26F03E6AC5E1CA96E59BC9A56F53FF41BB8099183F244E2E86BF884960AE71C51B6B718800FB5A14CB58C5E8DD318270EC588200B94C0096964E86DC891783C2C6FE61B2B1382CC01CA3B8C3A4EB20951907DF29F7A4C8259E71BC0AFC932B27CF4F4A5E693BC44C3683F4ABCC3D5DE51603BC4FD9004C6DC0F1283B98C6B44F7E2ECF8A60F32FCDCCFE671A6B32D0B14A079E8F6A5F199AD9C3860E2ECDF24C68069FD9D18B4EB436233D6158529AA6962E5EA5D305C84DB7797A14C574866D794544B3CF489EAEEBFCC85BE850A71A80DED3737A2F98DFB92AAFBC77C69E7729EB06D3CE697DAD1E270C777DE246CB6D82682AA0ADF3F31F86852FA2B18E31EA1E371BBE3DFB45C01D36DE602DE95EF7A73C514C027921336620EEE6DB7AAE36397F375C11CAC56A60B35EB1F5F6DE64CB1AD0B4AE0CDA8E6AEA465A9BDF8F06B8AADDBD4B827F1AD2070FB7B215CE6941ABBBE199068AA85B4A6D4806FC95A2BC3882733B71880AFCDD630C34C345CE71375B89CE0393739D591EE79CE66B4F7E9EB9CC6D1E26FE9CCBA9E63A7F04CF7BBE09A087E4E742EF73D12774F416251D524BAF52D375F474A544BD21209E7A8167697576F938EB1FDE3AD7ED81CDAF771DCD62B726D9CBBE92B3A37D176A5F3BDBDDAE63B877A4A202BE2C9BEA7E4FBC4F155B78AF28770DEA44181754F0B4E0F2A9291A54C4831CDCAACD6EC6999A5D2510BDD348ABFC4F1B8F79C63B3EF3EDC699A55319F1A42A9EF39A7F7CE94FBFF9159F8ED79F167DE23B4F7AD8A3FEF3A8A7EE7AEDDCFAC5BB9EF64FC97DEC4D6FEB7CEB7BD4AF873CF0672F71DE1BF5A6E7C17DE875AFFBDEA33CF9B28F3ECB8ECFF1CE64C7F8CC9EEC06FB57B4EF1FD6FBAA3DA2EAB04D6ED6C35B7FA8E53BFBE35DEB92FE6AFBDA3FBCAC7B9B0FEFDA1A0EFAA644ACFA58FB4FD67157E60380E6514CF6A61EFA671684957FEC677C958480B9A34FD5436CE8C14616587F00B56A15B87FBBA74A11D880D017189CA38075A57D0678801C583EA5971C2B781CFBE277BED65E05B880F0A782EB2748C3B1572C9455F595223DB83DC59772B7F66B1F5784F7D55144785DE38557E6F72051624093F7541E487B48C87FD2373C96E7364E384E9737614AE8851205860F268654487D10E420312485DD877C50664358587266C813E5966E6138723FA885B3F67B67388557484547544D6BB83A709887645488E125877F3835BEF785890878ED758865E887511546E9B4867A77659898779AF8FE267A970A0B764D15F74C083748876771A0E64A29874CA4482DA6B88A0ED77FB1886AAC484FA04472A2F867AA481746A78B5D9470B0988AA0F78BB80845AEB88BA8B849C6388AC0988C77D871C8688BC25848D0588ACEB84AE1E664D1D58BBA818D7C7827D4F14829F68C22D64CDE8841D9284EE4684D58E72AE8C85DEE9840EA080CF850276DC72AF0F88EE6280B61974CE1E875FA828FB6D00FDC647815638F6C1090C6D085EB640E07792809B98F0B594E4B364A0EE95816E929F2549152785EA0688D0069769AB87777D77701E8899D78928C603ADD458915367DEC457C83478D51C09276587DB51789364988CC785E3549860F887D3BC988374994BEFEF877F3357A933894C8879384D78CB1F58842A87C2FA98FD42794CA98293E99947BB87145199439198C47199540D98614977AA977951F69963D46956949965ED99466D98A6352466CD981F775822ED47E0DC27FF2C68577897D4619312BD95B9B258353898319E85A956798F47796F8735761901A76179822D298215899D9068403C8942F687F70B68728A420CDF237C2169A43729964558242939AFE57990DD49A86B59A3C3905B4333B37629379F59901C6959C598937C898BBE98255988B52028EC9135937649766257EE9F724C2E998AF393D7B199D9D598C64135692999D0399355AF99780E995AF51388B594479B9888F299A5009342C5434B36984FE4B7835D2492CE6C98470599C62B99EF5D76565F986FB699FD3255CEE899594E29D4C156D1ED744070A93632857F2695EF653A038A4A010476D136A5B12DA6D33F98D48F99D7C199E83B8800ECA869D277CBC285F8FD8A109F2A1FDF95DFFD9878D57A2EC2492050973FF453029E946383A292136771606A13E3A2B3CEA9223613FF8F52B0D36A4F452A485972BE8B5616A1605E78091F0E0A481C7A455691F46CA91DAF58F4A8AA5BA26A51079631089643BC78E5751A66321A690F3A4690A615BEA73678AA65F8A7573C8A659E9A64646A7FA30900F45A39B21A67DBA617F4A24790A127D6A656B3A4B5046A812D361DCD929889AA84EDA60073992EE17FEA96777A9AB41A9FC9089539A485BD6A8024266834A66A262A9488A90AFD0A99892AA069691ACFA9043F7661648138EBA7209D872356A13BC0A131071680587A02375724B798B186795B939A2EFF9954208A7B58888C2AA870B677054398B7128AD141A93C5FA7CE2A6ADCC3A7BCB4AACD56AACC388AC2677A1AAC6AD3149A520FA96FF36AC3FB9AEC80A76EE6A99DF736EE94A7EB501AF8B966DAE669D9AC6A2F74A41CABA6CA6D9AF34F5AFEC469CD7983B5658A85893AF0F0BB1118B65137B383A032DF4862E030B85CA12A322286DC1C22D1CFB865595244016B2F664AF1F8B7FF4654540723E268B55E3171B9399A142D6B247A27F098BAD9223073E7A2BB15EE43E6F10B0A7F8ADA21551314B8017BB6DA3B967FBC7AFC01AAF24C5B4E1AA935B79B4AFD866E85AB5564BAEDDFA703F1B71575B94420BAEC94A755F2B5CFA4AAD5924970347B6DBEAB6651BB6EC3A69D34AB76CDBB6706BADCFF8ADE3CAB73978B7F45A0F6EA2ABB7DA9EB90A673197B8BDFAB8BF5A00003B>|ch3-Z-G-23.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  When we look up an item, we use the first key to identify the correct
  subtable. Then we use the second key to identify the record within the
  subtable.

  \;

  \;

  <with|font-family|tt|<label|%_idx_3290>(define<nbsp>(lookup<nbsp>key-1<nbsp>key-2<nbsp>table)<next-line><nbsp><nbsp>(let<nbsp>((subtable<nbsp>(assoc<nbsp>key-1<nbsp>(cdr<nbsp>table))))<next-line><nbsp><nbsp><nbsp><nbsp>(if<nbsp>subtable<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((record<nbsp>(assoc<nbsp>key-2<nbsp>(cdr<nbsp>subtable))))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(if<nbsp>record<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cdr<nbsp>record)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>false))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>false)))<next-line>>

  \;

  \;

  To insert a new item under a pair of keys, we use
  <with|font-family|tt|assoc> to see if there is a subtable stored under the
  first key. If not, we build a new subtable containing the single record
  (<with|font-family|tt|key-2>, <with|font-family|tt|value>) and insert it
  into the table under the first key. If a subtable already exists for the
  first key, we insert the new record into this subtable, using the insertion
  method for one-dimensional tables described above:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3292>(define<nbsp>(insert!<nbsp>key-1<nbsp>key-2<nbsp>value<nbsp>table)<next-line><nbsp><nbsp>(let<nbsp>((subtable<nbsp>(assoc<nbsp>key-1<nbsp>(cdr<nbsp>table))))<next-line><nbsp><nbsp><nbsp><nbsp>(if<nbsp>subtable<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((record<nbsp>(assoc<nbsp>key-2<nbsp>(cdr<nbsp>subtable))))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(if<nbsp>record<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-cdr!<nbsp>record<nbsp>value)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-cdr!<nbsp>subtable<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cons<nbsp>(cons<nbsp>key-2<nbsp>value)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cdr<nbsp>subtable)))))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-cdr!<nbsp>table<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cons<nbsp>(list<nbsp>key-1<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cons<nbsp>key-2<nbsp>value))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cdr<nbsp>table)))))<next-line><nbsp><nbsp>'ok)<next-line>>

  \;

  <label|%_sec_Temp_374><subsubsection*|<hlink|Creating local
  tables|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-4.html#%_toc_%_sec_Temp_374>>

  <label|%_idx_3294>The <with|font-family|tt|lookup> and
  <with|font-family|tt|insert!> operations defined above take the table as an
  argument. This enables us to use programs that access more than one table.
  Another way to deal with multiple tables is to have separate
  <with|font-family|tt|lookup> and <with|font-family|tt|insert!> procedures
  for each table. We can do this by representing a table procedurally, as an
  object that maintains an internal table as part of its local state. When
  sent an appropriate message, this ``table object'' supplies the procedure
  with which to operate on the internal table. Here is a generator for
  two-dimensional tables represented in this fashion:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3296>(define<nbsp>(make-table)<next-line><nbsp><nbsp>(let<nbsp>((local-table<nbsp>(list<nbsp>'*table*)))<next-line><nbsp><nbsp><nbsp><nbsp>(define<nbsp>(lookup<nbsp>key-1<nbsp>key-2)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((subtable<nbsp>(assoc<nbsp>key-1<nbsp>(cdr<nbsp>local-table))))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(if<nbsp>subtable<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((record<nbsp>(assoc<nbsp>key-2<nbsp>(cdr<nbsp>subtable))))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(if<nbsp>record<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cdr<nbsp>record)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>false))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>false)))<next-line><nbsp><nbsp><nbsp><nbsp>(define<nbsp>(insert!<nbsp>key-1<nbsp>key-2<nbsp>value)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((subtable<nbsp>(assoc<nbsp>key-1<nbsp>(cdr<nbsp>local-table))))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(if<nbsp>subtable<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((record<nbsp>(assoc<nbsp>key-2<nbsp>(cdr<nbsp>subtable))))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(if<nbsp>record<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-cdr!<nbsp>record<nbsp>value)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-cdr!<nbsp>subtable<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cons<nbsp>(cons<nbsp>key-2<nbsp>value)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cdr<nbsp>subtable)))))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-cdr!<nbsp>local-table<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cons<nbsp>(list<nbsp>key-1<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cons<nbsp>key-2<nbsp>value))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cdr<nbsp>local-table)))))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>'ok)<nbsp><nbsp><nbsp><nbsp><next-line><nbsp><nbsp><nbsp><nbsp>(define<nbsp>(dispatch<nbsp>m)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cond<nbsp>((eq?<nbsp>m<nbsp>'lookup-proc)<nbsp>lookup)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>((eq?<nbsp>m<nbsp>'insert-proc!)<nbsp>insert!)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(else<nbsp>(error<nbsp>"Unknown<nbsp>operation<nbsp>--<nbsp>TABLE"<nbsp>m))))<next-line><nbsp><nbsp><nbsp><nbsp>dispatch))<next-line>>

  \;

  \;

  Using <with|font-family|tt|make-table>, we could implement the
  <with|font-family|tt|get> and <with|font-family|tt|put> operations used in
  section<nbsp><hlink|2.4.3|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-17.html#%_sec_2.4.3>
  for data-directed programming, as follows:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3298>(define<nbsp>operation-table<nbsp>(make-table))<next-line><label|%_idx_3300>(define<nbsp>get<nbsp>(operation-table<nbsp>'lookup-proc))<next-line><label|%_idx_3302>(define<nbsp>put<nbsp>(operation-table<nbsp>'insert-proc!))<next-line>>

  \;

  <with|font-family|tt|Get> takes as arguments two keys, and
  <with|font-family|tt|put> takes as arguments two keys and a value. Both
  operations access the same local table, which is encapsulated within the
  object created by the call to <with|font-family|tt|make-table>.

  <label|%_thm_3.24><with|font-series|bold|Exercise
  3.24.><nbsp><nbsp><label|%_idx_3304><label|%_idx_3306>In the table
  implementations above, the keys are tested for equality using
  <with|font-family|tt|equal?> (called by <with|font-family|tt|assoc>). This
  is not always the appropriate test. For instance, we might have a table
  with numeric keys in which we don't need an exact match to the number we're
  looking up, but only a number within some tolerance of it. Design a table
  constructor <with|font-family|tt|make-table> that takes as an argument a
  <with|font-family|tt|same-key?> procedure that will be used to test
  ``equality'' of keys. <with|font-family|tt|Make-table> should return a
  <with|font-family|tt|dispatch> procedure that can be used to access
  appropriate <with|font-family|tt|lookup> and <with|font-family|tt|insert!>
  procedures for a local table.

  \;

  \;

  <label|%_thm_3.25><with|font-series|bold|Exercise
  3.25.><nbsp><nbsp><label|%_idx_3308>Generalizing one- and two-dimensional
  tables, show how to implement a table in which values are stored under an
  arbitrary number of keys and different values may be stored under different
  numbers of keys. The <with|font-family|tt|lookup> and
  <with|font-family|tt|insert!> procedures should take as input a list of
  keys used to access the table.

  \;

  \;

  <label|%_thm_3.26><with|font-series|bold|Exercise
  3.26.><nbsp><nbsp><label|%_idx_3310><label|%_idx_3312>To search a table as
  implemented above, one needs to scan through the list of records. This is
  basically the unordered list representation of
  section<nbsp><hlink|2.3.3|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-16.html#%_sec_2.3.3>.
  For large tables, it may be more efficient to structure the table in a
  different manner. Describe a table implementation where the (key, value)
  records are organized using a binary tree, assuming that keys can be
  ordered in some way (e.g., numerically or alphabetically). (Compare
  exercise<nbsp><hlink|2.66|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-16.html#%_thm_2.66>
  of chapter<nbsp>2.)

  \;

  \;

  <label|%_thm_3.27><with|font-series|bold|Exercise
  3.27.><nbsp><nbsp><label|%_idx_3314><label|%_idx_3316><label|%_idx_3318><label|%_idx_3320><em|Memoization>
  (also called <em|tabulation>) is a technique that enables a procedure to
  record, in a local table, values that have previously been computed. This
  technique can make a vast difference in the performance of a program. A
  memoized procedure maintains a table in which values of previous calls are
  stored using as keys the arguments that produced the values. When the
  memoized procedure is asked to compute a value, it first checks the table
  to see if the value is already there and, if so, just returns that value.
  Otherwise, it computes the new value in the ordinary way and stores this in
  the table. As an example of memoization, recall from
  section<nbsp><hlink|1.2.2|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-11.html#%_sec_1.2.2>
  the exponential process for computing Fibonacci numbers:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3322>(define<nbsp>(fib<nbsp>n)<next-line><nbsp><nbsp>(cond<nbsp>((=<nbsp>n<nbsp>0)<nbsp>0)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>((=<nbsp>n<nbsp>1)<nbsp>1)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(else<nbsp>(+<nbsp>(fib<nbsp>(-<nbsp>n<nbsp>1))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(fib<nbsp>(-<nbsp>n<nbsp>2))))))<next-line>>

  \;

  The memoized version of the same procedure is

  \;

  \;

  <with|font-family|tt|<label|%_idx_3324>(define<nbsp>memo-fib<next-line><nbsp><nbsp>(memoize<nbsp>(lambda<nbsp>(n)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cond<nbsp>((=<nbsp>n<nbsp>0)<nbsp>0)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>((=<nbsp>n<nbsp>1)<nbsp>1)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(else<nbsp>(+<nbsp>(memo-fib<nbsp>(-<nbsp>n<nbsp>1))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(memo-fib<nbsp>(-<nbsp>n<nbsp>2))))))))<next-line>>

  \;

  where the memoizer is defined as

  \;

  <with|font-family|tt|<label|%_idx_3326>(define<nbsp>(memoize<nbsp>f)<next-line><nbsp><nbsp>(let<nbsp>((table<nbsp>(make-table)))<next-line><nbsp><nbsp><nbsp><nbsp>(lambda<nbsp>(x)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((previously-computed-result<nbsp>(lookup<nbsp>x<nbsp>table)))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(or<nbsp>previously-computed-result<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((result<nbsp>(f<nbsp>x)))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(insert!<nbsp>x<nbsp>result<nbsp>table)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>result))))))<next-line>>

  \;

  Draw an environment diagram to analyze the computation of
  <with|font-family|tt|(memo-fib 3)>. Explain why
  <with|font-family|tt|memo-fib> computes the <em|n>th Fibonacci number in a
  number of steps proportional to <em|n>. Would the scheme still work if we
  had simply defined <with|font-family|tt|memo-fib> to be
  <with|font-family|tt|(memoize fib)>?

  \;

  <subsection|A Simulator for Digital Circuits><label|sec:3.3.4>

  <label|%_idx_3328>Designing complex digital systems, such as computers, is
  an important engineering activity. Digital systems are constructed by
  interconnecting simple elements. Although the behavior of these individual
  elements is simple, networks of them can have very complex behavior.
  Computer simulation of proposed circuit designs is an important tool used
  by digital systems engineers. In this section we design a system for
  performing digital logic simulations. This system typifies a kind of
  program called an <label|%_idx_3330><label|%_idx_3332><em|event-driven
  simulation>, in which actions (``events'') trigger further events that
  happen at a later time, which in turn trigger more events, and so so.

  Our computational model of a circuit will be composed of objects that
  correspond to the elementary components from which the circuit is
  constructed. There are <label|%_idx_3334><em|wires>, which carry
  <label|%_idx_3336><label|%_idx_3338><em|digital signals>. A digital signal
  may at any moment have only one of two possible values, 0 and 1. There are
  also various types of digital <label|%_idx_3340><em|function boxes>, which
  connect wires carrying input signals to other output wires. Such boxes
  produce output signals computed from their input signals. The output signal
  is <label|%_idx_3342>delayed by a time that depends on the type of the
  function box. For example, an <label|%_idx_3344><em|inverter> is a
  primitive function box that inverts its input. If the input signal to an
  inverter changes to 0, then one inverter-delay later the inverter will
  change its output signal to 1. If the input signal to an inverter changes
  to 1, then one inverter-delay later the inverter will change its output
  signal to 0. We draw an inverter symbolically as in
  figure<nbsp><hlink|3.24|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.24>.
  An <label|%_idx_3346><em|and-gate>, also shown in
  figure<nbsp><hlink|3.24|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.24>,
  is a primitive function box with two inputs and one output. It drives its
  output signal to a value that is the <label|%_idx_3348><em|logical and> of
  the inputs. That is, if both of its input signals become<nbsp>1, then one
  and-gate-delay time later the and-gate will force its output signal to be
  1; otherwise the output will be 0. An <label|%_idx_3350><em|or-gate> is a
  similar two-input primitive function box that drives its output signal to a
  value that is the <label|%_idx_3352><em|logical or> of the inputs. That is,
  the output will become 1 if at least one of the input signals is 1;
  otherwise the output will become 0.

  <label|%_fig_3.24>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#474946383961E5002D00800000000000FFFFFF21F90401000001002C00000000E5002D000002FE8C8F0990ED0FA39CB4DA8BB35B4BFBCB7DE2486E4C8982DCDAA51FEBC6254BD7F2AD9C818D53E7DA0BFA2C4061AC85A8E98C866588093D2C7DC8E8A8DA8041A745AB704AF5929E11F2D704165395340D568D793FCCB874134B87C7DDF628FBDF9795E71258A4A5971158A68838C7982487C2A815D958E65169E918978906D87987F47988F868A2A99208EA2661B38ADA8439DA556A9A33FBBAB3A8430BDB2AEB1BC659E7981B9C057CBC384C2C685B3B9B0C87DB563198C275AD6CCDB70D91AB2D09F9EC8DAC5A7E3AD17BC36B8CAE70FE0EA91E4EB8E32E9FA442AE59496AB42E1F116BF594BDE161A5A0C06FD4F8352283508DC38520288EAB6631A3C6DC8D1C3B7AFC0832A4C891244B9A3C8932A5CA952C5BBA7C0933A6CC99346BDABC8933A7CE9D3C37F494A5700FAAA0F8E03D2CAA2E51B3A1AF264A79F8F488D25021AA76E802480AC47FF67E500A48F52A904360EDE9C378CBAA5A51D79C44151B2BAE1930BC427D61D0A2AEA87B3C0EC6D5F77769ACAD7DE906FE9BC62D625D7CC772496B15A0A1A78ACDC99D7C312826789D145382EC372A63BEA2B51A654CD7E940B994BD6EBA7779F168C96F15E5FD7147761F186A4B7F7DF2FBB6664E78798B051BFCB870A4C4B56A4B5E1C78D99FBF4EAAA64E8439BAE1120A00003B>|ch3-Z-G-24.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  We can connect primitive functions together to construct more complex
  functions. To accomplish this we wire the outputs of some function boxes to
  the inputs of other function boxes. For example, the
  <label|%_idx_3354><label|%_idx_3356><em|half-adder> circuit shown in
  figure<nbsp><hlink|3.25|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.25>
  consists of an or-gate, two and-gates, and an inverter. It takes two input
  signals, A and B, and has two output signals, S and C. S will become 1
  whenever precisely one of A and B is<nbsp>1, and C will become 1 whenever A
  and B are both 1. We can see from the figure that, because of the delays
  involved, the outputs may be generated at different times. Many of the
  difficulties in the design of digital circuits arise from this fact.

  <label|%_fig_3.25>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#474946383961F2005200800000000000FFFFFF21F90401000001002C00000000F20052000002FE8C8FA97BE00FA39CB4DA8BB3DEBC7BCA84E248964089A6EACAB6EE0B1B674CA7738DE7FACE8B77BFFB0187C4A2B171C40993CCA613B57CDAA4D46A356AF565B7DC21B69BF882C76492987C2EABD78134D8CD8E73E173B92E62AFD1B7FB67E535E39017D36755E8F4D00632253308734805D99488B0A8D5E8E822E99747A92071D996A949E449A8671A9406C110B839F86A264813AB987AE7C65AA93BC6C1E8254A4B8B07346B626CB74A1CDA2388FC011D2DCD7B5C7BB4771B564A4D4AB8DCBC925DD6278E598C743A5C8E1A8EBC76E85EE9E51C1F9E63ED5338BDEFCB228E6F041FC056FA06826B512F58A77B01FD193CE8B0959275E9F4345491701C20FE89C21401B3B1E804BF0B201F9ED314A5D62C930A4D306B0687221A40236FC97C84F1A52A59377BD15C00306347283AEF650435AAA53DA0C3D04174198265BC096C34A0E4E84DE850A85871DDA09ACCCC55A6B07246E541D2D12A845F58A235DBD5A8D62BDFE48D28D8562D5CB2A3E6DE75AAED2F46A16E83ECFD94D49624914A01C78DCA0D71D95F7C3389F40BB49CB27E82175296DCB7016679472D1E8E83AD6858D1A3156229FCB8EA69BBA1C360460A7A92DECF816BDB6EADBA086C86BC695B866C2C7267DD93899E4D7A26D1CAD49C9A73AD9CA503CFE9DAAB7B761E3B52F1DFD3577FBF9E3BFB7819DC7B1ADA0D1EFBFBF8BF770D377D5EECF33AF4FED9039F699D7EE14941C712EEC916E072E9CD779D72D0C1875E6F7CFC72A01CF7E117A171EA3957A185100A28DF15255DC804891565E818833C2506A287EB3526627F2C86F8CE6C29C638A3121F2A28613E9CD99823423B0607238DE4E913A48E091219D360AD9958E392FB19D9E331402679258032DE4825642F62B9A51AD4116495434D8289D344FF8549E59911A188269B70ADD9228F42B2550D945AA6698E615FCA49A47F1DC6A9D23559028A5C4D8A2ECAE88F7D0A6A0D36B12C165D5D71C2399868AE61E8239D5C620AA99E6FA8B9D2A78786CA673B795EEACF3CA9340A2B249EB20A2A9FB33E9AE8ACF0DC4A6BA0A94E0A85837F66D6EB4768597A4367B05B295BEC49F9195A52B3C69A57E276BC4A3BA58B93388AAD9FCF760BAEA8C9824B6E9162968BAEB8ADA24BAEBA4BB1DBADBBA7C28BA5BC23C68A6FBEFAEE0B4401003B>|ch3-Z-G-25.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  We will now build a program for modeling the digital logic circuits we wish
  to study. The program will construct computational objects modeling the
  wires, which will ``hold'' the signals. Function boxes will be modeled by
  procedures that enforce the correct relationships among the signals.

  <label|%_idx_3358>One basic element of our simulation will be a procedure
  <with|font-family|tt|make-wire>, which constructs wires. For example, we
  can construct six wires as follows:

  \;

  \;

  <with|font-family|tt|(define<nbsp>a<nbsp>(make-wire))<next-line>(define<nbsp>b<nbsp>(make-wire))<next-line>(define<nbsp>c<nbsp>(make-wire))<next-line><next-line>(define<nbsp>d<nbsp>(make-wire))<next-line>(define<nbsp>e<nbsp>(make-wire))<next-line>(define<nbsp>s<nbsp>(make-wire))<next-line>>

  \;

  We attach a function box to a set of wires by calling a procedure that
  constructs that kind of box. The arguments to the constructor procedure are
  the wires to be attached to the box. For example, given that we can
  construct and-gates, or-gates, and inverters, we can wire together the
  half-adder shown in figure<nbsp><hlink|3.25|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.25>:

  \;

  \;

  <with|font-family|tt|(or-gate<nbsp>a<nbsp>b<nbsp>d)<next-line><with|font-shape|italic|ok><next-line><next-line>(and-gate<nbsp>a<nbsp>b<nbsp>c)<next-line><with|font-shape|italic|ok><next-line><next-line>(inverter<nbsp>c<nbsp>e)<next-line><with|font-shape|italic|ok><next-line><next-line>(and-gate<nbsp>d<nbsp>e<nbsp>s)<next-line><with|font-shape|italic|ok><next-line>>

  \;

  \;

  Better yet, we can explicitly name this operation by defining a procedure
  <with|font-family|tt|half-adder> that constructs this circuit, given the
  four external wires to be attached to the half-adder:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3360>(define<nbsp>(half-adder<nbsp>a<nbsp>b<nbsp>s<nbsp>c)<next-line><nbsp><nbsp>(let<nbsp>((d<nbsp>(make-wire))<nbsp>(e<nbsp>(make-wire)))<next-line><nbsp><nbsp><nbsp><nbsp>(or-gate<nbsp>a<nbsp>b<nbsp>d)<next-line><nbsp><nbsp><nbsp><nbsp>(and-gate<nbsp>a<nbsp>b<nbsp>c)<next-line><nbsp><nbsp><nbsp><nbsp>(inverter<nbsp>c<nbsp>e)<next-line><nbsp><nbsp><nbsp><nbsp>(and-gate<nbsp>d<nbsp>e<nbsp>s)<next-line><nbsp><nbsp><nbsp><nbsp>'ok))<next-line>>

  \;

  The advantage of making this definition is that we can use
  <with|font-family|tt|half-adder> itself as a building block in creating
  more complex circuits. Figure<nbsp><hlink|3.26|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.26>,
  for example, shows a <label|%_idx_3362><label|%_idx_3364><em|full-adder>
  composed of two half-adders and an or-gate.<hlink|<label|call_footnote_Temp_379><rsup|<with|font-size|0.83|26>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_379>
  We can construct a full-adder as follows:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3366>(define<nbsp>(full-adder<nbsp>a<nbsp>b<nbsp>c-in<nbsp>sum<nbsp>c-out)<next-line><nbsp><nbsp>(let<nbsp>((s<nbsp>(make-wire))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(c1<nbsp>(make-wire))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(c2<nbsp>(make-wire)))<next-line><nbsp><nbsp><nbsp><nbsp>(half-adder<nbsp>b<nbsp>c-in<nbsp>s<nbsp>c1)<next-line><nbsp><nbsp><nbsp><nbsp>(half-adder<nbsp>a<nbsp>s<nbsp>sum<nbsp>c2)<next-line><nbsp><nbsp><nbsp><nbsp>(or-gate<nbsp>c1<nbsp>c2<nbsp>c-out)<next-line><nbsp><nbsp><nbsp><nbsp>'ok))<next-line>>

  \;

  Having defined <with|font-family|tt|full-adder> as a procedure, we can now
  use it as a building block for creating still more complex circuits. (For
  example, see exercise<nbsp><hlink|3.30|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_thm_3.30>.)

  <label|%_fig_3.26>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#47494638396109016000800000000000FFFFFF21F90401000001002C00000000090160000002FE8C8FA9CB070FA39CB4DA8BB3DEBCFB2F35E24896E69900E8CAB6EE0BC7AC2AD77649DFFACEF777EE0BBE80C2A2F1A82322970B25F3098D1A9C5224B58ACD26B5CF2BF70B3E79C33FB2F94C1AA361EAB53BDB7EAFE2F2FA926E4FE7F770BE0CEF1758032888405888389738B3D8B8738808E9389942896389D92229B88905F21991D7E9372A558A727A946AB7CAD4AAC79A29F26AD5252AFA1043AB6A1B8BBBB96B14CC30FCC8130A11103245A702CCD95BD74A93ABECA09C5B8DE30C04EAFD0D5A2954BC95443D758DAD6EB2AC09EDD0969C22DF046E7FAFA1409F431DCA9EEE2E109166E246902BD3A31A3F74F40C66D3A648E03C79EDACC16BA8EFD68FFE85162D3AEB584BA2218024075EF2B51122C5870749EE31890E5B43980635CA6AF20EE0B975315D12B379B3209F6E2C65265B563123CAA02345DE01CAB4E7D068725A82B16ACC15D4A858CB3D5D1A15E44BAA6FBA6A316BA32B5A176BABB4D545D6CDDB287387A0522A662BD3BA6CC50C04C4F75F589F606B0A3D296D30E1C486FC2175BC0FA9DEA08119FDD4C62D1D478C956129BE82AFC3DDC6474776337A5409240AC2144B3DDC3A6FD387CCD629D4A79AED051F9D79FDD42AFB626A64211EEF1BA27282D7C1A0E3CE72EE974AD2BE65FDB169A076F457E46930462CBB3838DE9082B7737708F1BBDCF0E5C7FB6EFFFE7CF7F4F0D14C577FB8D8872EF8FEA25B065F9B70F634B68D6ADEB1E75E6CBAE071E0736935781D8286E1D41462AFFDC64E681B0C02187D0EFE018F39D65147A180CCCC449A87122E82598BD6419860401786D15C85B9B9140F573B79449F86F988B51E863DF58362851FDE745B4C3DAA28A45D329A979F6601BE96E35E3B2964207EBA8528536D2C6155E3895D2A671C934062E2A2893036891C45527A044598E4C962E6444F3E72A592716207DD24758A4962422E1269959CF1A1A9C688FF31C7A7563E3EEA0D31F769B957A350FA999C7269B976E68CE3649241429C1AAA2025AC15D15BA9B01DE9A9A59C1E33AAAB0ECD43E9AB83C4CA26AB9DCA6AEBA657AD1961892762B952B1FC48D6C06B565C1CCB1BAFD760C6D38E44AE9A6CB07DAC88DA80297EF4AC6964DE58ADAF67CD19A53A58DAB6239746860BD7B2E4AEFB2D71F2120B2DBBB72ECBECAE81521B44AA399DA5E872FC366B2F886B0C2A09A9A8166CF0C1B33929ECA10C2F7AC669FA4E18E3A713435C716A3C51BCAEAA1B6BC7A8A4905A30F2BE5CA59C88BF1AB3FC6F582EC36CA1CC34C7BCF2CDA4E0AAF358AECDDC73AE9405EDF367444F86E4D18555AA74553C37EDF0CF500368F4D451576D75C5A39ECC75D75E7FFD4501003B>|ch3-Z-G-26.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  \;

  In essence, our simulator provides us with the tools to construct a
  language of circuits. If we adopt the general perspective on languages with
  which we approached the study of Lisp in
  section<nbsp><hlink|1.1|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-10.html#%_sec_1.1>,
  we can say that the primitive function boxes form the primitive elements of
  the language, that wiring boxes together provides a means of combination,
  and that specifying wiring patterns as procedures serves as a means of
  abstraction.

  <label|%_sec_Temp_380><subsubsection*|<hlink|Primitive function
  boxes|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-4.html#%_toc_%_sec_Temp_380>>

  <label|%_idx_3368>The primitive function boxes implement the ``forces'' by
  which a change in the signal on one wire influences the signals on other
  wires. To build function boxes, we use the following operations on wires:

  \;

  <\itemize>
    <item><with|font-family|tt|(get-signal
    \<less\><em|wire>\<gtr\>)><next-line><label|%_idx_3370>returns the
    current value of the signal on the wire.

    \;

    <item><with|font-family|tt|(set-signal! \<less\><em|wire>\<gtr\>
    \<less\><em|new value>\<gtr\>)><next-line><label|%_idx_3372>changes the
    value of the signal on the wire to the new value.

    \;

    <item><with|font-family|tt|(add-action! \<less\><em|wire>\<gtr\>
    \<less\><em|procedure of no arguments>\<gtr\>)><next-line><label|%_idx_3374>asserts
    that the designated procedure should be run whenever the signal on the
    wire changes value. Such procedures are the vehicles by which changes in
    the signal value on the wire are communicated to other wires.
  </itemize>

  <label|%_idx_3376>In addition, we will make use of a procedure
  <with|font-family|tt|after-delay> that takes a time delay and a procedure
  to be run and executes the given procedure after the given delay.

  Using these procedures, we can define the primitive digital logic
  functions. To connect an input to an output through an inverter, we use
  <with|font-family|tt|add-action!> to associate with the input wire a
  procedure that will be run whenever the signal on the input wire changes
  value. The procedure computes the <with|font-family|tt|logical-not> of the
  input signal, and then, after one <with|font-family|tt|inverter-delay>,
  sets the output signal to be this new value:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3378>(define<nbsp>(inverter<nbsp>input<nbsp>output)<next-line><nbsp><nbsp>(define<nbsp>(invert-input)<next-line><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((new-value<nbsp>(logical-not<nbsp>(get-signal<nbsp>input))))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(after-delay<nbsp>inverter-delay<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(lambda<nbsp>()<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-signal!<nbsp>output<nbsp>new-value)))))<next-line><nbsp><nbsp>(add-action!<nbsp>input<nbsp>invert-input)<next-line><nbsp><nbsp>'ok)<next-line><label|%_idx_3380>(define<nbsp>(logical-not<nbsp>s)<next-line><nbsp><nbsp>(cond<nbsp>((=<nbsp>s<nbsp>0)<nbsp>1)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>((=<nbsp>s<nbsp>1)<nbsp>0)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(else<nbsp>(error<nbsp>"Invalid<nbsp>signal"<nbsp>s))))<next-line>>

  \;

  \;

  An and-gate is a little more complex. The action procedure must be run if
  either of the inputs to the gate changes. It computes the
  <with|font-family|tt|logical-and> (using a procedure analogous to
  <with|font-family|tt|logical-not>) of the values of the signals on the
  input wires and sets up a change to the new value to occur on the output
  wire after one <with|font-family|tt|and-gate-delay>.

  \;

  \;

  <with|font-family|tt|<label|%_idx_3382>(define<nbsp>(and-gate<nbsp>a1<nbsp>a2<nbsp>output)<next-line><nbsp><nbsp>(define<nbsp>(and-action-procedure)<next-line><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((new-value<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(logical-and<nbsp>(get-signal<nbsp>a1)<nbsp>(get-signal<nbsp>a2))))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(after-delay<nbsp>and-gate-delay<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(lambda<nbsp>()<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-signal!<nbsp>output<nbsp>new-value)))))<next-line><nbsp><nbsp>(add-action!<nbsp>a1<nbsp>and-action-procedure)<next-line><nbsp><nbsp>(add-action!<nbsp>a2<nbsp>and-action-procedure)<next-line><nbsp><nbsp>'ok)<next-line>>

  \;

  \;

  \;

  <label|%_thm_3.28><with|font-series|bold|Exercise
  3.28.><nbsp><nbsp><label|%_idx_3384>Define an or-gate as a primitive
  function box. Your <with|font-family|tt|or-gate> constructor should be
  similar to <with|font-family|tt|and-gate>.

  \;

  \;

  <label|%_thm_3.29><with|font-series|bold|Exercise
  3.29.><nbsp><nbsp><label|%_idx_3386>Another way to construct an or-gate is
  as a compound digital logic device, built from and-gates and inverters.
  Define a procedure <with|font-family|tt|or-gate> that accomplishes this.
  What is the delay time of the or-gate in terms of
  <with|font-family|tt|and-gate-delay> and
  <with|font-family|tt|inverter-delay>?

  \;

  \;

  <label|%_thm_3.30><with|font-series|bold|Exercise
  3.30.><nbsp><nbsp>Figure<nbsp><hlink|3.27|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.27>
  shows a <label|%_idx_3388><label|%_idx_3390><em|ripple-carry adder> formed
  by stringing together <em|n> full-adders. This is the simplest form of
  parallel adder for adding two <em|n>-bit binary numbers. The inputs
  A<rsub|1>, A<rsub|2>, A<rsub|3>, <with|font-family|tt|...>, A<rsub|<em|n>>
  and B<rsub|1>, B<rsub|2>, B<rsub|3>, <with|font-family|tt|...>,
  B<rsub|<em|n>> are the two binary numbers to be added (each A<rsub|<em|k>>
  and B<rsub|<em|k>> is a 0 or a 1). The circuit generates S<rsub|1>,
  S<rsub|2>, S<rsub|3>, <with|font-family|tt|...>, S<rsub|<em|n>>, the <em|n>
  bits of the sum, and C, the carry from the addition. Write a procedure
  <with|font-family|tt|ripple-carry-adder> that generates this circuit. The
  procedure should take as arguments three lists of <em|n> wires each -- the
  A<rsub|<em|k>>, the B<rsub|<em|k>>, and the S<rsub|<em|k>> -- and also
  another wire C. The major drawback of the ripple-carry adder is the need to
  wait for the carry signals to propagate. What is the delay needed to obtain
  the complete output from an <em|n>-bit ripple-carry adder, expressed in
  terms of the delays for and-gates, or-gates, and inverters?

  \;

  <label|%_fig_3.27>

  <tabular|<tformat|<twith|table-width|1par>|<cwith|1|-1|1|-1|cell-hyphen|t>|<table|<row|<cell|<image|<tuple|<#47494638396198018E00800000000000FFFFFF21F90401000001002C0000000098018E000002FE8C8FA9CBBD005D8254DA8B59C534E6FF6D570780E689A6A66891EA0BC7082B95862DE707EDE0B80EE2357CC0A2F125D4EC8ECC63E9575B369101684F3A8D5A87D8ACD7FBCC10BFE4D573FBE89483678E7A3D698FDEF07A2CE269D1EDFCD9FE7A83D61798A4E02308F6C71538D818A2A8C4E8C837D63573793399B9296988994756D989B909AA792A0AC8791A8AE7214462530857B1216BE852B59A559B77EBF7F65B84C83AE44A5C955BACCA1BB43CB1BB88BC366D9953AD83ADA2DC03C9AA4D15F28CFBA8390BEC44FB85E7A6DB64BA12EA3CBEA30DDF78AF01CEA10E161D898CDB1C7728F6A50067905A98810999E44B63A4E1C175FF1E54AC672D0AC1FE1312C59CABF7D091407D1FD795F4466FD1945E7AE4449A63EB62CA612867262B9972A4CD9CDB64E213B32D5544A01E33DE215A50E8CE70235AC4317A33E6C662D824768CC70FE93BAD58970ECDCA8C504892F4AAF67C998DAB467232CC4E8408CD2B58A76B8DE1649A6EAE192977C5E9AD314618DEBA7B4BEDBADAD5A15A4F7AA6E655FC970D0BC48C9B3E924AD9EDC13F5028FBDD1A39AE46CF61872D3E6A3A7461189AB39922ADFADA69528060A3FD6A393590D69B65C746F2C3365DD0B955DA4DD68CF8F0DDB89727755C7036EBE0FD9413B6F86DA5F4A463396E6FD9FD37EDB67D1F432E7E5B6E74F1A8BE5777AEFEA778E13CD99B734F0D7F7C8AF3FEF79F455F1F8020C5426081E155065F1C062EC8602CFE41971E8293D00795840A36882181DEA9769541BC59F856191456289A71136A171B851ECED6E186028EF79F3C28BE08A37CE72548628CFA09D26262D79538983F33E258E3202342885D846DB948648FF3D0E8D367325A571A88460EF9638E214A992592FA1599A4924CF247A589619E58A6985E06092590607EA9A54F4762D95C97713E68E5996EFAF66493AC8D59E59B782ED9DFA07DDAA922A066DEB92891794669A88E810A1AE99E6A26EAE3A44E723929A4952AAAA6A79F7E48E9963B36CA699B827A36671DA45ADAC791AF8A9AA9AA506D7A6AA7870A99A69E8FDA21AB7498EE8A2AAEF6ADC9FEEA7BE6D9492B99CB763A6CAA621A6BAB9C7C4E7923B36BBA4A27AADB9A7A2C8F7FD61A6AB2F9751BEAB7E7660B2DBBD52249ADA3B0369B1DBABECE0BACBD8F469BEBBDD26A4B62ABEE3257E8A7F2BEC96FB8DE1E5BAAB50613ACAAC0EDA53830C017C56B31B20F437CB0C4B16608B28669C11472C92B926C32C8E30E9AB2C9138F5CF17A07B339B3BAE092DBABA41CDB786D9D2B672CF3BFF8FE1CB4B33DEB2612D23ED3FC2BD1F605CB74CC37C39CF4CE4A3B9D6ED40B330AAAD0CFA226F5BA475BAD35D738EB6A36B16AE73CF5D8945C4DB6CEFE12BAF6D0652F231CD41BD35B77D776CB6DB1DE7B7B8DF5A8FAFADD70DB68F34DF8E04DDFFDA0E06003FE8D78D636175DF94E923FBC39E49DD7FC79E33685CE6DDC6E2B9E38E6D592CE30DD542FFDB6E9AE4FBE38E0B5B3FEEEE9B6D37EA5EC0EDED43AE8DD0473E0C98EFE8E13C661FB8D7CF12FEB4ED021D3C0560D31959C94B9C69C600FF9EBB357267DEEC9790FCD42BA4C2FFBAAE72F81FED9EA9B6F7EEDF5A61F0611ED0F6EBD08AED48C5FFEBEB8B4B5B9AD4A7F00B49CE3024640E4504E3DD65360540292BE803950277FFB5B03FFF7118F05480918EC8E06956521A554F069D71161EAE2D440D140F080DBB18209D3E61544D0A11729845E8566788C05AA4B86043C430D51B7141E621078F2E3950DBB4742B6590E77FC3BA2FB0A97AF08227175875B62FE159BF83DDE49115B5924DFEE6008274F315187530C5EDFC4D64527F6EF8A8FBB5CF68A98C62F9651894F9CE3EDD868413C3E4F8DAA8B9D17F948453AB6718CF3FB631C0D45C8242E6F907A3C6022E3F348E109328F93646124E572C93B5612858D1460103BB949F1D5517497AC1E284778C83E02F294701CE51A43B943568211886F5465E90CA94539BAD1950DCBE4097369C730C2928CC2D4E4222979CC006EF18CC1845D505AA6325C0E089A0DCA1E35A3A94B6972E49A18DA63285BD5917D982B9B8CC39B8878694974DA5294E3A4E52F5918BC0F96459DB5F4641B4579CF72C2B395F21C87388D58CF5D2A138EF4E92717F1893F7A2AD46CED5C673EFE45E79F7F6EB093E02C6343EB5950107E73261293A82C7779517466148D14E5E841B1E8D005869499EF442839A138503F8EAF982C8DA93E5169CF96A214A67023E649BFE6539AD26BA510BDA93737BA4F7602549D44859341F1E4D1441C48A34135E32F9BDABAA7466EA15D99EA396BFAD2870AD48036D56A44B92A25B392D5A82E1DEA2A1F3AD2848235ACB39CEB58ED8A53AC8A2FAE3F056A2B53BAD6B05654B06F45255F8D56D24460442CDC6C2C5ADD70CDC74E139A786D2B781A4BD9CA6EB32F6AB5E927CFEACC64DED29FF3DC5867012B59CD22962AA5E5DC562375DAC026D5AA2605ED6C657ADB54EE27B6A9CD6D407DFBD7D1BDB6A7C065EB478FFEFB0CDEAA36B874FD6A6BCD69DAE12EB3B07DBD0F69A36BDBE9EA3656B54DEEDE945BD4F002134DCF652D7677EB57D152F5A8D6756D76A13AD1E2BA3322E5A1AD6448035E57D557A8F2AD6B88BC6A5FA40098B9861B8536FB5B5526E56DA6F8453075D28B60CBA276BE145EAE6771ABDEF5568DA4C4A5EE4E25AC5081E557A74B556C2732C38B4318B8B738E5A931169BBB11FB7798D3B1C580656B06CC34F7C33BA6202EECD15DE8B6B79967B10A84437B5F198A57C33CDB309181B363F392C74B408E70A564DC0E2B134C1633D4B26FB1DC183043522662F6F235F63BA19A98D9230514CB9ADF0CE704C739C373AEB39C976CE632DB19914CDEB39EF70CC25F0E037AC683AEF307FFECDD422BDAC22C062EA2176D68484B7AD294AEB4A52F8DE94CFB59D3D5E5B49D0F6D69E5AAD9D3E03972878D84E64EF7E3C6394975EC58CDE30ACB08D6ABFD9871AD4B6B6009E6C0BC56C8AD4DAD904737E6AE1F4BD84CBF91EB128B44D88061F68ADF4B1567EBB70BD27E4A0CAF576DBCBDF0CD38ACB62F605C16FDFDDACAA31E74B6BB4CEC2693DAC791762FB35D6DEEF8153ADB2F8E28BDEB73EF3EEFD6DBF9BE6EBF4D92EC68A75BD70137F4FE48CDC07223DCCA0500003B>|ch3-Z-G-27.gif>|0.6383w|||>>>|<row|<cell|>>>>>

  <label|%_sec_Temp_384><subsubsection*|<hlink|Representing
  wires|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-4.html#%_toc_%_sec_Temp_384>>

  <label|%_idx_3392>A wire in our simulation will be a computational object
  with two local state variables: a <with|font-family|tt|signal-value>
  (initially taken to be 0) and a collection of
  <with|font-family|tt|action-procedures> to be run when the signal changes
  value. We implement the wire, using message-passing style, as
  <label|%_idx_3394>a collection of local procedures together with a
  <with|font-family|tt|dispatch> procedure that selects the appropriate local
  operation, just as we did with the simple bank-account object in section
  <nbsp><hlink|3.1.1|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-20.html#%_sec_3.1.1>:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3396>(define<nbsp>(make-wire)<next-line><nbsp><nbsp>(let<nbsp>((signal-value<nbsp>0)<nbsp>(action-procedures<nbsp>'()))<next-line><nbsp><nbsp><nbsp><nbsp>(define<nbsp>(set-my-signal!<nbsp>new-value)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(if<nbsp>(not<nbsp>(=<nbsp>signal-value<nbsp>new-value))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(begin<nbsp>(set!<nbsp>signal-value<nbsp>new-value)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(call-each<nbsp>action-procedures))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>'done))<next-line><nbsp><nbsp><nbsp><nbsp>(define<nbsp>(accept-action-procedure!<nbsp>proc)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set!<nbsp>action-procedures<nbsp>(cons<nbsp>proc<nbsp>action-procedures))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(proc))<next-line><nbsp><nbsp><nbsp><nbsp>(define<nbsp>(dispatch<nbsp>m)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cond<nbsp>((eq?<nbsp>m<nbsp>'get-signal)<nbsp>signal-value)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>((eq?<nbsp>m<nbsp>'set-signal!)<nbsp>set-my-signal!)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>((eq?<nbsp>m<nbsp>'add-action!)<nbsp>accept-action-procedure!)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(else<nbsp>(error<nbsp>"Unknown<nbsp>operation<nbsp>--<nbsp>WIRE"<nbsp>m))))<next-line><nbsp><nbsp><nbsp><nbsp>dispatch))<next-line>>

  \;

  The local procedure <with|font-family|tt|set-my-signal!> tests whether the
  new signal value changes the signal on the wire. If so, it runs each of the
  action procedures, using the following procedure
  <with|font-family|tt|call-each>, which calls each of the items in a list of
  no-argument procedures:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3398>(define<nbsp>(call-each<nbsp>procedures)<next-line><nbsp><nbsp>(if<nbsp>(null?<nbsp>procedures)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>'done<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(begin<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>((car<nbsp>procedures))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(call-each<nbsp>(cdr<nbsp>procedures)))))<next-line>>

  \;

  The local procedure <with|font-family|tt|accept-action-procedure!> adds the
  given procedure to the list of procedures to be run, and then runs the new
  procedure once. (See exercise<nbsp><hlink|3.31|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_thm_3.31>.)

  With the local <with|font-family|tt|dispatch> procedure set up as
  specified, we can provide the following procedures to access the local
  operations on wires:<hlink|<label|call_footnote_Temp_385><rsup|<with|font-size|0.83|27>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_385>

  \;

  \;

  <with|font-family|tt|<label|%_idx_3404>(define<nbsp>(get-signal<nbsp>wire)<next-line><nbsp><nbsp>(wire<nbsp>'get-signal))<next-line><label|%_idx_3406>(define<nbsp>(set-signal!<nbsp>wire<nbsp>new-value)<next-line><nbsp><nbsp>((wire<nbsp>'set-signal!)<nbsp>new-value))<next-line><label|%_idx_3408>(define<nbsp>(add-action!<nbsp>wire<nbsp>action-procedure)<next-line><nbsp><nbsp>((wire<nbsp>'add-action!)<nbsp>action-procedure))<next-line>>

  \;

  \;

  Wires, which have time-varying signals and may be incrementally attached to
  devices, are typical of mutable objects. We have modeled them as procedures
  with local state variables that are modified by assignment. When a new wire
  is created, a new set of state variables is allocated (by the
  <with|font-family|tt|let> expression in <with|font-family|tt|make-wire>)
  and a new <with|font-family|tt|dispatch> procedure is constructed and
  returned, capturing the environment with the new state variables.

  The wires are shared among the various devices that have been connected to
  them. Thus, a change made by an interaction with one device will affect all
  the other devices attached to the wire. The wire communicates the change to
  its neighbors by calling the action procedures provided to it when the
  connections were established.<label|%_sec_Temp_386>

  <subsubsection*|<hlink|The agenda|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-4.html#%_toc_%_sec_Temp_386>>

  <label|%_idx_3410>The only thing needed to complete the simulator is
  <with|font-family|tt|after-delay>. The idea here is that we maintain a data
  structure, called an <em|agenda>, that contains a schedule of things to do.
  The following operations are defined for agendas:

  \;

  <\itemize>
    <item><label|%_idx_3412><with|font-family|tt|(make-agenda)><next-line>returns
    a new empty agenda.

    \;

    <item><label|%_idx_3414><with|font-family|tt|(empty-agenda?
    \<less\><em|agenda>\<gtr\>)><next-line>is true if the specified agenda is
    empty.

    \;

    <item><label|%_idx_3416><with|font-family|tt|(first-agenda-item
    \<less\><em|agenda>\<gtr\>)><next-line>returns the first item on the
    agenda.

    \;

    <item><label|%_idx_3418><with|font-family|tt|(remove-first-agenda-item!
    \<less\><em|agenda>\<gtr\>)><next-line>modifies the agenda by removing
    the first item.

    \;

    <item><label|%_idx_3420><with|font-family|tt|(add-to-agenda!
    \<less\><em|time>\<gtr\> \<less\><em|action>\<gtr\>
    \<less\><em|agenda>\<gtr\>)><next-line>modifies the agenda by adding the
    given action procedure to be run at the specified time.

    \;

    <item><label|%_idx_3422><with|font-family|tt|(current-time
    \<less\><em|agenda>\<gtr\>)><next-line>returns the current simulation
    time.
  </itemize>

  \;

  The particular agenda that we use is denoted by
  <with|font-family|tt|the-agenda>. The procedure
  <with|font-family|tt|after-delay> adds new elements to
  <with|font-family|tt|the-agenda>:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3424>(define<nbsp>(after-delay<nbsp>delay<nbsp>action)<next-line><nbsp><nbsp>(add-to-agenda!<nbsp>(+<nbsp>delay<nbsp>(current-time<nbsp>the-agenda))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>action<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>the-agenda))<next-line>>

  \;

  \;

  The simulation is driven by the procedure <with|font-family|tt|propagate>,
  which operates on <with|font-family|tt|the-agenda>, executing each
  procedure on the agenda in sequence. In general, as the simulation runs,
  new items will be added to the agenda, and <with|font-family|tt|propagate>
  will continue the simulation as long as there are items on the agenda:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3426>(define<nbsp>(propagate)<next-line><nbsp><nbsp>(if<nbsp>(empty-agenda?<nbsp>the-agenda)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>'done<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((first-item<nbsp>(first-agenda-item<nbsp>the-agenda)))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(first-item)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(remove-first-agenda-item!<nbsp>the-agenda)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(propagate))))<next-line>>

  \;

  \;

  <label|%_sec_Temp_387><subsubsection*|<hlink|A sample
  simulation|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-4.html#%_toc_%_sec_Temp_387>>

  <label|%_idx_3428><label|%_idx_3430>The following procedure, which places a
  ``probe'' on a wire, shows the simulator in action. The probe tells the
  wire that, whenever its signal changes value, it should print the new
  signal value, together with the current time and a name that identifies the
  wire:

  \;

  \;

  <with|font-family|tt|<label|%_idx_3432>(define<nbsp>(probe<nbsp>name<nbsp>wire)<next-line><nbsp><nbsp>(add-action!<nbsp>wire<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(lambda<nbsp>()<nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(newline)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(display<nbsp>name)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(display<nbsp>"<nbsp>")<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(display<nbsp>(current-time<nbsp>the-agenda))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(display<nbsp>"<nbsp><nbsp>New-value<nbsp>=<nbsp>")<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(display<nbsp>(get-signal<nbsp>wire)))))<next-line>>

  \;

  \;

  We begin by initializing the agenda and specifying delays for the primitive
  function boxes:

  \;

  \;

  <with|font-family|tt|(define<nbsp>the-agenda<nbsp>(make-agenda))<next-line>(define<nbsp>inverter-delay<nbsp>2)<next-line>(define<nbsp>and-gate-delay<nbsp>3)<next-line>(define<nbsp>or-gate-delay<nbsp>5)<next-line>>

  \;

  Now we define four wires, placing probes on two of them:

  \;

  \;

  <with|font-family|tt|(define<nbsp>input-1<nbsp>(make-wire))<next-line>(define<nbsp>input-2<nbsp>(make-wire))<next-line>(define<nbsp>sum<nbsp>(make-wire))<next-line>(define<nbsp>carry<nbsp>(make-wire))<next-line>(probe<nbsp>'sum<nbsp>sum)<next-line><with|font-shape|italic|sum<nbsp>0<nbsp><nbsp>New-value<nbsp>=<nbsp>0><next-line>(probe<nbsp>'carry<nbsp>carry)<next-line><with|font-shape|italic|carry<nbsp>0<nbsp><nbsp>New-value<nbsp>=<nbsp>0><next-line>>

  \;

  Next we connect the wires in a half-adder circuit (as in
  figure<nbsp><hlink|3.25|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_fig_3.25>),
  set the signal on <with|font-family|tt|input-1> to 1, and run the
  simulation:

  \;

  \;

  <with|font-family|tt|(half-adder<nbsp>input-1<nbsp>input-2<nbsp>sum<nbsp>carry)<next-line><with|font-shape|italic|ok><next-line>(set-signal!<nbsp>input-1<nbsp>1)<next-line><with|font-shape|italic|done><next-line>(propagate)<next-line><with|font-shape|italic|sum<nbsp>8<nbsp><nbsp>New-value<nbsp>=<nbsp>1><next-line><with|font-shape|italic|done><next-line>>

  \;

  The <with|font-family|tt|sum> signal changes to 1 at time 8. We are now
  eight time units from the beginning of the simulation. At this point, we
  can set the signal on <with|font-family|tt|input-2> to 1 and allow the
  values to propagate:

  \;

  \;

  <with|font-family|tt|(set-signal!<nbsp>input-2<nbsp>1)<next-line><with|font-shape|italic|done><next-line>(propagate)<next-line><with|font-shape|italic|carry<nbsp>11<nbsp><nbsp>New-value<nbsp>=<nbsp>1><next-line><with|font-shape|italic|sum<nbsp>16<nbsp><nbsp>New-value<nbsp>=<nbsp>0><next-line><with|font-shape|italic|done><next-line>>

  \;

  The <with|font-family|tt|carry> changes to 1 at time 11 and the
  <with|font-family|tt|sum> changes to 0 at time 16.

  <label|%_thm_3.31><with|font-series|bold|Exercise 3.31.><nbsp><nbsp>
  <label|%_idx_3434>The internal procedure
  <with|font-family|tt|accept-action-procedure!> defined in
  <with|font-family|tt|make-wire> specifies that when a new action procedure
  is added to a wire, the procedure is immediately run. Explain why this
  initialization is necessary. In particular, trace through the half-adder
  example in the paragraphs above and say how the system's response would
  differ if we had defined <with|font-family|tt|accept-action-procedure!> as

  \;

  \;

  <with|font-family|tt|(define<nbsp>(accept-action-procedure!<nbsp>proc)<next-line><nbsp><nbsp>(set!<nbsp>action-procedures<nbsp>(cons<nbsp>proc<nbsp>action-procedures)))<next-line>>

  \;

  \;

  \;

  <label|%_sec_Temp_389><subsubsection*|<hlink|Implementing the
  agenda|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-4.html#%_toc_%_sec_Temp_389>>

  <label|%_idx_3436>Finally, we give details of the agenda data structure,
  which holds the procedures that are scheduled for future execution.

  The agenda is made up of <label|%_idx_3438><em|time segments>. Each time
  segment is a pair consisting of a number (the time) and a
  <label|%_idx_3440>queue (see exercise<nbsp><hlink|3.32|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_thm_3.32>)
  that holds the procedures that are scheduled to be run during that time
  segment.

  \;

  \;

  <with|font-family|tt|<label|%_idx_3442>(define<nbsp>(make-time-segment<nbsp>time<nbsp>queue)<next-line><nbsp><nbsp>(cons<nbsp>time<nbsp>queue))<next-line><label|%_idx_3444>(define<nbsp>(segment-time<nbsp>s)<nbsp>(car<nbsp>s))<next-line><label|%_idx_3446>(define<nbsp>(segment-queue<nbsp>s)<nbsp>(cdr<nbsp>s))<next-line>>

  \;

  We will operate on the time-segment queues using the queue operations
  described in section<nbsp><hlink|3.3.2|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_sec_3.3.2>.

  <label|%_idx_3448>The agenda itself is a one-dimensional table of time
  segments. It differs from the tables described in
  section<nbsp><hlink|3.3.3|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#%_sec_3.3.3>
  in that the segments will be sorted in order of increasing time. In
  addition, we store the <label|%_idx_3450><em|current time> (i.e., the time
  of the last action that was processed) at the head of the agenda. A newly
  constructed agenda has no time segments and has a current time of
  0:<hlink|<label|call_footnote_Temp_390><rsup|<with|font-size|0.83|28>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_390>

  \;

  \;

  <with|font-family|tt|<label|%_idx_3456>(define<nbsp>(make-agenda)<nbsp>(list<nbsp>0))<next-line><label|%_idx_3458>(define<nbsp>(current-time<nbsp>agenda)<nbsp>(car<nbsp>agenda))<next-line><label|%_idx_3460>(define<nbsp>(set-current-time!<nbsp>agenda<nbsp>time)<next-line><nbsp><nbsp>(set-car!<nbsp>agenda<nbsp>time))<next-line><label|%_idx_3462>(define<nbsp>(segments<nbsp>agenda)<nbsp>(cdr<nbsp>agenda))<next-line><label|%_idx_3464>(define<nbsp>(set-segments!<nbsp>agenda<nbsp>segments)<next-line><nbsp><nbsp>(set-cdr!<nbsp>agenda<nbsp>segments))<next-line><label|%_idx_3466>(define<nbsp>(first-segment<nbsp>agenda)<nbsp>(car<nbsp>(segments<nbsp>agenda)))<next-line><label|%_idx_3468>(define<nbsp>(rest-segments<nbsp>agenda)<nbsp>(cdr<nbsp>(segments<nbsp>agenda)))<next-line>>

  \;

  \;

  An agenda is empty if it has no time segments:

  \;

  <with|font-family|tt|<label|%_idx_3470>(define<nbsp>(empty-agenda?<nbsp>agenda)<next-line><nbsp><nbsp>(null?<nbsp>(segments<nbsp>agenda)))<next-line>>

  \;

  \;

  To add an action to an agenda, we first check if the agenda is empty. If
  so, we create a time segment for the action and install this in the agenda.
  Otherwise, we scan the agenda, examining the time of each segment. If we
  find a segment for our appointed time, we add the action to the associated
  queue. If we reach a time later than the one to which we are appointed, we
  insert a new time segment into the agenda just before it. If we reach the
  end of the agenda, we must create a new time segment at the end.

  \;

  \;

  <with|font-family|tt|<label|%_idx_3472>(define<nbsp>(add-to-agenda!<nbsp>time<nbsp>action<nbsp>agenda)<next-line><nbsp><nbsp>(define<nbsp>(belongs-before?<nbsp>segments)<next-line><nbsp><nbsp><nbsp><nbsp>(or<nbsp>(null?<nbsp>segments)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(\<less\><nbsp>time<nbsp>(segment-time<nbsp>(car<nbsp>segments)))))<next-line><nbsp><nbsp>(define<nbsp>(make-new-time-segment<nbsp>time<nbsp>action)<next-line><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((q<nbsp>(make-queue)))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(insert-queue!<nbsp>q<nbsp>action)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(make-time-segment<nbsp>time<nbsp>q)))<next-line><nbsp><nbsp>(define<nbsp>(add-to-segments!<nbsp>segments)<next-line><nbsp><nbsp><nbsp><nbsp>(if<nbsp>(=<nbsp>(segment-time<nbsp>(car<nbsp>segments))<nbsp>time)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(insert-queue!<nbsp>(segment-queue<nbsp>(car<nbsp>segments))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>action)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((rest<nbsp>(cdr<nbsp>segments)))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(if<nbsp>(belongs-before?<nbsp>rest)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-cdr!<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>segments<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cons<nbsp>(make-new-time-segment<nbsp>time<nbsp>action)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cdr<nbsp>segments)))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(add-to-segments!<nbsp>rest)))))<next-line><nbsp><nbsp>(let<nbsp>((segments<nbsp>(segments<nbsp>agenda)))<next-line><nbsp><nbsp><nbsp><nbsp>(if<nbsp>(belongs-before?<nbsp>segments)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-segments!<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>agenda<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(cons<nbsp>(make-new-time-segment<nbsp>time<nbsp>action)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>segments))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(add-to-segments!<nbsp>segments))))<next-line>>

  \;

  \;

  The procedure that removes the first item from the agenda deletes the item
  at the front of the queue in the first time segment. If this deletion makes
  the time segment empty, we remove it from the list of
  segments:<hlink|<label|call_footnote_Temp_391><rsup|<with|font-size|0.83|29>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_391>

  \;

  \;

  <with|font-family|tt|<label|%_idx_3478>(define<nbsp>(remove-first-agenda-item!<nbsp>agenda)<next-line><nbsp><nbsp>(let<nbsp>((q<nbsp>(segment-queue<nbsp>(first-segment<nbsp>agenda))))<next-line><nbsp><nbsp><nbsp><nbsp>(delete-queue!<nbsp>q)<next-line><nbsp><nbsp><nbsp><nbsp>(if<nbsp>(empty-queue?<nbsp>q)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-segments!<nbsp>agenda<nbsp>(rest-segments<nbsp>agenda)))))<next-line>>

  \;

  \;

  The first agenda item is found at the head of the queue in the first time
  segment. Whenever we extract an item, we also update the current
  time:<hlink|<label|call_footnote_Temp_392><rsup|<with|font-size|0.83|30>>|https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-22.html#footnote_Temp_392>

  \;

  \;

  <label|%_idx_3480>(define<nbsp>(first-agenda-item<nbsp>agenda)<next-line><nbsp><nbsp>(if<nbsp>(empty-agenda?<nbsp>agenda)<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(error<nbsp>"Agenda<nbsp>is<nbsp>empty<nbsp>--<nbsp>FIRST-AGENDA-ITEM")<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(let<nbsp>((first-seg<nbsp>(first-segment<nbsp>agenda)))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(set-current-time!<nbsp>agenda<nbsp>(segment-time<nbsp>first-seg))<next-line><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp><nbsp>(front-queue<nbsp>(segment-queue<nbsp>first-seg)))))<next-line>

  \;

  \;

  <label|%_thm_3.32><with|font-series|bold|Exercise 3.32.><nbsp><nbsp>The
  procedures to be run during each time segment of the agenda are kept in a
  queue. Thus, the procedures for each segment are called in the order in
  which they were added to the agenda (first in, first out). Explain why this
  order must be used. In particular, trace the behavior of an and-gate whose
  inputs change from 0,1 to 1,0 in the same segment and say how the behavior
  would differ if we stored a segment's procedures in an ordinary list,
  adding and removing procedures only at the front (last in, first out).

  <subsection|Propagation of Constraints>

  Computer programs are traditionally organized as one-directional
  computations, which perform operations on prespecified arguments to produce
  desired outputs. On the other hand, we often model systems in terms of
  relations among quantities. For example, a mathematical model of a
  mechanical structure might include the information that the deflection
  <math|d> of a metal rod is related to the force <math|F> on the rod, the
  length <math|L> of the rod, the cross-sectional area <math|A>, and the
  elastic modulus <math|E> via the equation

  <\equation*>
    d*A*E=F*L
  </equation*>

  Such an equation is not one-directional. Given any four of the quantities,
  we can use it to compute the fifth. Yet translating the equation into a
  traditional computer language would force us to choose one of the
  quantities to be computed in terms of the other four. Thus, a procedure for
  computing the area <math|A> could not be used to compute the deflection
  <math|d>, even though the computations of <math|A> and <math|d> arise from
  the same equation.

  In this section, we sketch the design of a language that enables us to work
  in terms of relations themselves. The primitive elements of the language
  are <em|primitive constraints><index|primitive cnstraints>, which state
  that certain relations hold between quantities. For example, <scm|(adder a
  b c)> specifies that the quantities <math|a>, <math|b>, and <math|c> must
  be related by the equation <math|a + b = c>, <scm|(multiplier x y z)>
  expresses the constraint <math|xy = z>, and <scm|(constant 3.14 x)> says
  that the value of <math|x> must be 3.14.

  Our language provides a means of combining primitive constraints in order
  to express more complex relations. We combine constraints by constructing
  <em|constraint networks><index|constraint networks>, in which constraints
  are joined by <em|connectors><index|connectors>. A connector is an object
  that ``holds'' a value that may participate in one or more constraints. For
  example, we know that the relationship between Fahrenheit and Celsius
  temperatures is

  <\equation*>
    9*C=5*<around*|(|F-32|)>
  </equation*>

  Such a constraint can be thought of as a network consisting of primitive
  adder, multiplier, and constant constraints (<smart-ref|fig:3.28>). In the
  figure, we see on the left a multiplier box with three terminals, labeled
  <em|m1>, <em|m2>, and <em|p>. These connect the multiplier to the rest of
  the network as follows: The <em|m1> terminal is linked to a connector
  <em|C>, which will hold the Celsius temperature. The <em|m2> terminal is
  linked to a connector <em|w>, which is also linked to a constant box that
  holds 9. The <em|p> terminal, which the multiplier box constrains to be the
  product of <em|m1> and <em|m2> , is linked to the <em|p> terminal of
  another multiplier box, whose <em|m2> is connected to a constant 5 and
  whose <em|m1> is connected to one of the terms in a sum.

  \;

  <\big-figure|<with|gr-mode|<tuple|edit|line>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-grid|<tuple|empty>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|empty>|gr-text-at-valign|center|gr-snap|<tuple|control
  point|grid point|grid curve point|curve-grid intersection|curve
  point|curve-curve intersection>|gr-auto-crop|true|gr-grid-old|<tuple|cartesian|<point|0|0>|2>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|<graphics||<text-at|m1|<point|-3.8|1.4>>|<text-at|m2|<point|-3.8|0.6>>|<line|<point|-0.4|2>|<point|-0.3999999999999998|0.2>|<point|1.7999999999999996|0.2>|<point|1.7999999999999996|2.0>|<point|-0.3999999999999998|2.0>>|<line|<point|3.2|2>|<point|3.2|0.2>|<point|5.4|0.2>|<point|5.4|2.0>|<point|3.2|2.0>>|<text-at|p|<point|-0.2|1>>|<text-at|a1|<point|3.4|1.4>>|<text-at|a2|<point|3.4|0.6>>|<with|text-at-halign|right|<text-at|s|<point|5.2|1>>>|<with|text-at-halign|right|<text-at|p|<point|-2.0|1.0>>>|<with|text-at-halign|right|<text-at|m1|<point|1.5999999999999992|1.4>>>|<with|text-at-halign|right|<text-at|m2|<point|1.5999999999999992|0.6>>>|<text-at|*|<point|0.6000000000000002|1.0>>|<text-at|*|<point|-3.0|1.0>>|<with|<text-at|+|<point|4.2|1>>>|<line|<point|-3.4|-0.6>|<point|-3.4|-1.4>|<point|-2.4|-1.4>|<point|-2.4|-0.6>|<point|-3.4|-0.6>>|<line|<point|0.2|-0.6>|<point|0.20000000000000037|-1.4>|<point|1.2000000000000004|-1.4>|<point|1.2000000000000004|-0.6>|<point|0.20000000000000037|-0.6>>|<with|text-at-valign|center|<text-at|9|<point|-3.0|-1.0>>>|<with|text-at-valign|center|<text-at|5|<point|0.6000000000000002|-1.0>>>|<with|text-at-valign|center|<text-at|32|<point|4.2|-1.0>>>|<line|<point|-4|0.2>|<point|-4.0|2.0>|<point|-1.7999999999999996|2.0>|<point|-1.7999999999999996|0.2>|<point|-4.0|0.2>>|<line|<point|-1.8|1>|<point|-0.3999999999999998|0.995193008843565>>|<line|<point|1.8|1.5>|<point|3.2|1.5>>|<line|<point|-4.8|1.5>|<point|-4.0|1.5>>|<line|<point|5.4|1.5>|<point|6.2|1.5>>|<line|<point|-4.8|1.8>|<point|-5.8|1.8>|<point|-5.8|1.0>|<point|-4.8|1.0>|<point|-4.8|1.8>>|<with|text-at-valign|center|<text-at|C|<point|-5.4|1.4>>>|<line|<point|6.2|1.8>|<point|6.2|1.0>|<point|7.2|1.0>|<point|7.2|1.8>|<point|6.2|1.8>>|<with|text-at-valign|center|<text-at|F|<point|6.6|1.4>>>|<line|<point|-3.4|-1>|<point|-4.4|-1.0>|<point|-4.4|0.7>|<point|-4.0|0.7>>|<line|<point|1.2|-1>|<point|2.2|-1.0>|<point|2.2|0.7>|<point|1.7999999999999976|0.7000000000000001>>|<line|<point|3.8|-1.4>|<point|3.8|-0.6>|<point|4.8|-0.6>|<point|4.8|-1.4>|<point|3.8|-1.4>>|<line|<point|3.8|-1>|<point|2.8|-1.0>|<point|2.8|0.7>|<point|3.2|0.7>>>>>
    <label|fig:3.28>The relation <math|9*C = 5*(F - 32)> expressed as a
    constraint network.
  </big-figure>

  Computation by such a network proceeds as follows: When a connector is
  given a value (by the user or by a constraint box to which it is linked),
  it awakens all of its associated constraints (except for the constraint
  that just awakened it) to inform them that it has a value. Each awakened
  constraint box then polls its connectors to see if there is enough
  information to determine a value for a connector. If so, the box sets that
  connector, which then awakens all of its associated constraints, and so on.
  For instance, in conversion between Celsius and Fahrenheit, <math|w>,
  <math|x>, and <math|y> are immediately set by the constant boxes to 9, 5,
  and 32, respectively. The connectors awaken the multipliers and the adder,
  which determine that there is not enough information to proceed. If the
  user (or some other part of the network) sets <math|C> to a value (say 25),
  the leftmost multiplier will be awakened, and it will set <math|u> to
  <math|25\<times\>9 = 225>. Then <math|u> awakens the second multiplier,
  which sets <math|v> to 45, and <math|v> awakens the adder, which sets
  <math|F> to 77.

  <subsubsection*|Using the constraint system>

  To use the constraint system to carry out the temperature computation
  outlined above, we first create two connectors, <verbatim|C> and
  <verbatim|F>, by calling the constructor <verbatim|make-connector>, and
  link <verbatim|C> and <verbatim|F> in an appropriate network:

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define C (make-connector))
    </input>

    <\input|Scheme] >
      (define F (make-connector))
    </input>

    <\input|Scheme] >
      (celsius-fahrenheit-converter C F)
    </input>
  </session>

  The procedure that creates the network is defined as follows:

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define (celsius-fahrenheit-converter c f)

      \ \ (let ((u (make-connector))

      \ \ \ \ \ \ \ \ (v (make-connector))

      \ \ \ \ \ \ \ \ (w (make-connector))

      \ \ \ \ \ \ \ \ (x (make-connector))

      \ \ \ \ \ \ \ \ (y (make-connector)))

      \ \ \ \ (multiplier c w u)

      \ \ \ \ (multiplier v x u)

      \ \ \ \ (adder v y f)

      \ \ \ \ (constant 9 w)

      \ \ \ \ (constant 5 x)

      \ \ \ \ (constant 32 y)

      \ \ \ \ 'ok))
    </input>
  </session>

  This procedure creates the internal connectors <verbatim|u>, <verbatim|v>,
  <verbatim|w>, <verbatim|x>, and <verbatim|y>, and links them as shown in
  figure 3.28 using the primitive constraint constructors <verbatim|adder>,
  <verbatim|multiplier>, and <verbatim|constant>. Just as with the
  digital-circuit simulator of <smart-ref|sec:3.3.4>, expressing these
  combinations of primitive elements in terms of procedures automatically
  provides our language with a means of abstraction for compound objects.

  To watch the network in action, we can place probes on the connectors
  <verbatim|C> and <verbatim|F>, using a probe procedure similar to the one
  we used to monitor wires in <smart-ref|sec:3.3.4>. Placing a probe on a
  connector will cause a message to be printed whenever the connector is
  given a value:

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (probe ``Celsius temp'' C)
    </input>

    <\input|Scheme] >
      (probe ``Fahrenheit temp'' F)
    </input>
  </session>

  Next we set the value of <verbatim|C> to 25. (The third argument to
  <verbatim|set-value!> tells <verbatim|C> that this directive comes from the
  user.)

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (set-value! C 25 'user)
    </input>
  </session>

  Probe: Celsius temp = 25<next-line>Probe: Fahrenheit temp =
  77<next-line>done

  The probe on <verbatim|C> awakens and reports the value. <verbatim|C> also
  propagates its value through the network as described above. This sets
  <verbatim|F> to 77, which is reported by the probe on <verbatim|F>.

  Now we can try to set <verbatim|F> to a new value, say 212:

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (set-value! F 212 'user)
    </input>
  </session>

  Error! Contradiction (77 212)

  The connector complains that it has sensed a contradiction: Its value is
  77, and someone is trying to set it to 212. If we really want to reuse the
  network with new values, we can tell C to forget its old value:

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (forget-value! C 'user)
    </input>
  </session>

  Probe: Celsius temp = ?<next-line>Probe: Fahrenheit temp = ?<next-line>done

  <verbatim|C> finds that the user, who set its value originally, is now
  retracting that value, so <verbatim|C> agrees to lose its value, as shown
  by the probe, and informs the rest of the network of this fact. This
  information eventually propagates to <verbatim|F>, which now finds that it
  has no reason for continuing to believe that its own value is 77. Thus,
  <verbatim|F> also gives up its value, as shown by the probe.

  Now that <verbatim|F> has no value, we are free to set it to 212:

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (set-value! F 212 'user)
    </input>
  </session>

  Probe: Fahrenheit temp = 212<next-line>Probe: Celsius temp =
  100<next-line>done

  This new value, when propagated through the network, forces C to have a
  value of 100, and this is registered by the probe on C. Notice that the
  very same network is being used to compute C given F and to compute F given
  C. This nondirectionality of computation is the distinguishing feature of
  constraint-based systems.

  <subsubsection*|Implementing the constraint system>

  The constraint system is implemented via procedural objects with local
  state, in a manner very similar to the digital-circuit simulator of
  <smart-ref|sec:3.3.4>. Although the primitive objects of the constraint
  system are somewhat more complex, the overall system is simpler, since
  there is no concern about agendas and logic delays.

  The basic operations on connectors are the following:

  <\itemize>
    <item><verbatim|(has-value? \<less\>connector\<gtr\>)><next-line>tells
    whether the connector has a value.

    <item><scm|(get-value \<less\>connector\<gtr\>)><next-line>returns the
    connector's current value.

    <item><verbatim|(set-value! \<less\>connector\<gtr\>
    \<less\>new-value\<gtr\> \<less\>informant\<gtr\>)><next-line>indicates
    that the informant is requesting the connector to set its value to the
    new value.

    <item><verbatim|(forget-value! \<less\>connector\<gtr\>
    \<less\>retractor\<gtr\>)><next-line>tells the connector that the
    retractor is requesting it to forget its value.

    <item><verbatim|(connect \<less\>connector\<gtr\>
    \<less\>new-constraint\<gtr\>)><next-line>tells the connector to
    participate in the new constraint.
  </itemize>

  The connectors communicate with the constraints by means of the procedures
  <verbatim|inform-about-value>, which tells the given constraint that the
  connector has a value, and<verbatim| inform-about-no-value>, which tells
  the constraint that the connector has lost its value.

  Adder constructs an adder constraint among summand connectors <verbatim|a1>
  and <verbatim|a2> and a <verbatim|sum> connector. An adder is implemented
  as a procedure with local state (the procedure me below):

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define (adder a1 a2 sum)

      \ \ (define (process-new-value)

      \ \ \ \ (cond\ 

      \ \ \ \ \ \ ((and (has-value? a1) (has-value?
      a2))<hlink||file:///C:/TJUPT/%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A8%8B%E5%BA%8F%E7%9A%84%E6%9E%84%E9%80%A0%E5%92%8C%E8%A7%A3%E9%87%8A%C2%B7%E7%AC%AC2%E7%89%88%EF%BC%88%E4%B8%AD%E8%8B%B1%E5%8F%8C%E7%89%88%EF%BC%89/Structure%20and%20Interpretation%20of%20Computer%20Programs_2nd%20Edition%20by%20Harold%20Abelson,%20Gerald%20Jay%20Sussman.pdf#%u201AR%u0160VG%11R%u2022-%C0%0C%A2%uFB01%EAE%u0192%25_sec_3.3.4>

      \ \ \ \ \ \ \ (set-value! sum

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (+ (get-value a1) (get-value a2))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ me))

      \ \ \ \ \ \ ((and (has-value? a1) (has-value? sum))

      \ \ \ \ \ \ \ (set-value! a2

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (- (get-value sum) (get-value
      a1))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ me))

      \ \ \ \ \ \ ((and (has-value? a2) (has-value? sum))

      \ \ \ \ \ \ \ (set-value! a1

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (- (get-value sum) (get-value
      a2))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ me))))

      \ \ (define (process-forget-value)

      \ \ \ \ (forget-value! sum me)

      \ \ \ \ (forget-value! a1 me)

      \ \ \ \ (forget-value! a2 me)

      \ \ \ \ (process-new-value))

      \ \ (define (me request)

      \ \ \ \ (cond\ 

      \ \ \ \ \ \ ((eq? request 'I-have-a-value)

      \ \ \ \ \ \ \ (process-new-value))

      \ \ \ \ \ \ ((eq? request 'I-lost-my-value)

      \ \ \ \ \ \ \ (process-forget-value))

      \ \ \ \ \ \ (else

      \ \ \ \ \ \ \ \ (error ``Unknown request -- ADDER'' request))))

      \ \ (connect a1 me)

      \ \ (connect a2 me)

      \ \ (connect sum me)

      \ \ me)
    </input>
  </session>

  <verbatim|adder> connects the new adder to the designated connectors and
  returns it as its value. The procedure <verbatim|me>, which represents the
  adder, acts as a dispatch to the local procedures. The following ``syntax
  interfaces'' (see footnote 27 in <smart-ref|sec:3.3.4>) are used in
  conjunction with the dispatch:

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define (inform-about-value constraint)

      \ \ (constraint 'I-have-a-value))

      (define (inform-about-no-value constraint)

      \ \ (constraint 'I-lost-my-value))
    </input>
  </session>

  The adder's local procedure <verbatim|process-new-value> is called when the
  adder is informed that one of its connectors has a value. The adder first
  checks to see if both <verbatim|a1> and <verbatim|a2> have values. If so,
  it tells sum to set its value to the sum of the two addends. The informant
  argument to <verbatim|set-value!> is <verbatim|me>, which is the adder
  object itself. If <verbatim|a1> and <verbatim|a2> do not both have values,
  then the adder checks to see if perhaps <verbatim|a1> and <verbatim|sum>
  have values. If so, it sets <verbatim|a2> to the difference of these two.
  Finally, if <verbatim|a2> and <verbatim|sum> have values, this gives the
  adder enough information to set <verbatim|a1>. If the adder is told that
  one of its connectors has lost a value, it requests that all of its
  connectors now lose their values. (Only those values that were set by this
  adder are actually lost.) Then it runs <verbatim|process-new-value>. The
  reason for this last step is that one or more connectors may still have a
  value (that is, a connector may have had a value that was not originally
  set by the adder), and these values may need to be propagated back through
  the adder.

  A multiplier is very similar to an adder. It will set its product to 0 if
  either of the factors is 0, even if the other factor is not known.

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define (multiplier m1 m2 product)

      \ \ (define (process-new-value)

      \ \ \ \ (cond ((or (and (has-value? m1) (= (get-value m1) 0))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (and (has-value? m2) (= (get-value m2)
      0)))

      \ \ \ \ \ \ \ \ \ \ \ (set-value! product 0 me))

      \ \ \ \ \ \ \ \ \ \ ((and (has-value? m1) (has-value? m2))

      \ \ \ \ \ \ \ \ \ \ \ (set-value! product

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (* (get-value m1)
      (get-value m2))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ me))

      \ \ \ \ \ \ \ \ \ \ ((and (has-value? product) (has-value? m1))

      \ \ \ \ \ \ \ \ \ \ \ (set-value! m2

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (/ (get-value product)
      (get-value m1))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ me))

      \ \ \ \ \ \ \ \ \ \ ((and (has-value? product) (has-value? m2))

      \ \ \ \ \ \ \ \ \ \ \ (set-value! m1

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (/ (get-value product)
      (get-value m2))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ me))))

      \ \ (define (process-forget-value)

      \ \ \ \ (forget-value! product me)

      \ \ \ \ (forget-value! m1 me)

      \ \ \ \ (forget-value! m2 me)

      \ \ \ \ (process-new-value))

      \ \ (define (me request)

      \ \ \ \ (cond ((eq? request 'I-have-a-value)

      \ \ \ \ \ \ \ \ \ \ \ (process-new-value))

      \ \ \ \ \ \ \ \ \ \ ((eq? request 'I-lost-my-value)

      \ \ \ \ \ \ \ \ \ \ \ (process-forget-value))

      \ \ \ \ \ \ \ \ \ \ (else

      \ \ \ \ \ \ \ \ \ \ \ \ (error ``Unknown request -- MULTIPLIER''
      request))))

      \ \ (connect m1 me)

      \ \ (connect m2 me)

      \ \ (connect product me)

      \ \ me)
    </input>
  </session>

  A constant constructor simply sets the value of the designated connector.
  Any <verbatim|I-have-a-value> or <verbatim|I-lost-my-value> message sent to
  the constant box will produce an error.

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define (constant value connector)

      \ \ (define (me request)

      \ \ \ \ (error ``Unknown request -- CONSTANT'' request))

      \ \ (connect connector me)

      \ \ (set-value! connector value me)

      \ \ me)
    </input>
  </session>

  \;

  Finally, a probe prints a message about the setting or unsetting of the
  designated connector:

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define (probe name connector)

      \ \ (define (print-probe value)

      \ \ \ \ (newline)(display "Probe: ")(display name)(display " =
      ")(display value))

      \ \ (define (process-new-value)

      \ \ \ \ (print-probe (get-value connector)))

      \ \ (define (process-forget-value)

      \ \ \ \ (print-probe "?"))

      \ \ (define (me request)

      \ \ \ \ (cond ((eq? request 'I-have-a-value)

      \ \ \ \ \ \ \ \ \ \ \ (process-new-value))

      \ \ \ \ \ \ \ \ \ \ ((eq? request 'I-lost-my-value)

      \ \ \ \ \ \ \ \ \ \ \ (process-forget-value))

      \ \ \ \ \ \ \ \ \ \ (else

      \ \ \ \ \ \ \ \ \ \ \ \ (error ``Unknown request -- PROBE'' request))))

      \ \ (connect connector me)

      \ \ me)
    </input>
  </session>

  <subsubsection*|Representing connectors>

  \;

  <section|Concurrency: Time Is of the Essence><label|sec:3.4>
</body>

<\initial>
  <\collection>
    <associate|chapter-nr|2>
    <associate|page-first|147>
    <associate|page-medium|paper>
    <associate|par-first|0tab>
    <associate|par-par-sep|1fn>
    <associate|preamble|false>
    <associate|save-aux|false>
    <associate|section-nr|5>
    <associate|subsection-nr|3>
  </collection>
</initial>