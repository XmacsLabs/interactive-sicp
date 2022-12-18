<TeXmacs|2.1.2>

<project|sicp.tm>

<style|<tuple|book|smart-ref>>

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

    <\unfolded-io|Scheme] >
      (define paul-acc peter-acc)
    <|unfolded-io>
      dispatch
    </unfolded-io>

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

  <subsection|>

  <section|Modeling with Mutable Data><label|sec:3.3>

  <subsection|>

  <subsection|>

  <subsection|>

  <subsection|><label|sec:3.3.4>

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
    <associate|section-nr|5>
    <associate|subsection-nr|3>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|3|147>>
    <associate|auto-10|<tuple|assignment operator|148>>
    <associate|auto-11|<tuple|3.1.1|148>>
    <associate|auto-12|<tuple|encapsulated|150>>
    <associate|auto-13|<tuple|hiding principle|150>>
    <associate|auto-14|<tuple|accumulator|152>>
    <associate|auto-15|<tuple|3.1.2|152>>
    <associate|auto-16|<tuple|pseudo-random|153>>
    <associate|auto-17|<tuple|Monte Carlo simulation|153>>
    <associate|auto-18|<tuple|Monte Carlo integration|154>>
    <associate|auto-19|<tuple|3.1.3|155>>
    <associate|auto-2|<tuple|modular|147>>
    <associate|auto-20|<tuple|functional programming|155>>
    <associate|auto-21|<tuple|3.9|157>>
    <associate|auto-22|<tuple|referentially transparent|157>>
    <associate|auto-23|<tuple|aliasing|158>>
    <associate|auto-24|<tuple|side-effect bugs|158>>
    <associate|auto-25|<tuple|side-effect bugs|159>>
    <associate|auto-26|<tuple|imperative programming|159>>
    <associate|auto-27|<tuple|3.2|160>>
    <associate|auto-28|<tuple|environments|160>>
    <associate|auto-29|<tuple|frames|160>>
    <associate|auto-3|<tuple|object|147>>
    <associate|auto-30|<tuple|bindings|160>>
    <associate|auto-31|<tuple|enclosing environment|160>>
    <associate|auto-32|<tuple|global|160>>
    <associate|auto-33|<tuple|value of a variable|160>>
    <associate|auto-34|<tuple|unbound|160>>
    <associate|auto-35|<tuple|3.1|160>>
    <associate|auto-36|<tuple|3.2.1|161>>
    <associate|auto-37|<tuple|3.2|162>>
    <associate|auto-38|<tuple|3.2.2|162>>
    <associate|auto-39|<tuple|3.3|162>>
    <associate|auto-4|<tuple|stream|147>>
    <associate|auto-40|<tuple|3.3.1|162>>
    <associate|auto-41|<tuple|3.3.2|162>>
    <associate|auto-42|<tuple|3.3.3|162>>
    <associate|auto-43|<tuple|3.3.4|162>>
    <associate|auto-44|<tuple|3.3.5|162>>
    <associate|auto-45|<tuple|primitive cnstraints|163>>
    <associate|auto-46|<tuple|constraint networks|163>>
    <associate|auto-47|<tuple|connectors|163>>
    <associate|auto-48|<tuple|3.3|163>>
    <associate|auto-49|<tuple|3.3|164>>
    <associate|auto-5|<tuple|environment model|147>>
    <associate|auto-50|<tuple|3.3|165>>
    <associate|auto-51|<tuple|<with|mode|<quote|math>|\<bullet\>>|168>>
    <associate|auto-52|<tuple|3.4|168>>
    <associate|auto-6|<tuple|delayed evaluation|147>>
    <associate|auto-7|<tuple|3.1|147>>
    <associate|auto-8|<tuple|state variable|147>>
    <associate|auto-9|<tuple|local state variable|148>>
    <associate|fig:3.2|<tuple|3.2|162>>
    <associate|fig:3.28|<tuple|3.3|163>>
    <associate|footnote-3.1|<tuple|3.1|148>>
    <associate|footnote-3.10|<tuple|3.10|158>>
    <associate|footnote-3.11|<tuple|3.11|159>>
    <associate|footnote-3.12|<tuple|3.12|161>>
    <associate|footnote-3.2|<tuple|3.2|149>>
    <associate|footnote-3.3|<tuple|3.3|149>>
    <associate|footnote-3.4|<tuple|3.4|150>>
    <associate|footnote-3.5|<tuple|3.5|150>>
    <associate|footnote-3.6|<tuple|3.6|153>>
    <associate|footnote-3.7|<tuple|3.7|153>>
    <associate|footnote-3.8|<tuple|3.8|155>>
    <associate|footnote-3.9|<tuple|3.9|156>>
    <associate|footnr-3.1|<tuple|3.1|148>>
    <associate|footnr-3.10|<tuple|side-effect bugs|158>>
    <associate|footnr-3.11|<tuple|3.11|159>>
    <associate|footnr-3.12|<tuple|3.12|161>>
    <associate|footnr-3.2|<tuple|3.2|149>>
    <associate|footnr-3.3|<tuple|3.3|149>>
    <associate|footnr-3.4|<tuple|hiding principle|150>>
    <associate|footnr-3.5|<tuple|3.5|150>>
    <associate|footnr-3.6|<tuple|pseudo-random|153>>
    <associate|footnr-3.7|<tuple|3.7|153>>
    <associate|footnr-3.8|<tuple|3.8|155>>
    <associate|footnr-3.9|<tuple|3.9|156>>
    <associate|sec:3.1.1|<tuple|3.1.1|148>>
    <associate|sec:3.1.3|<tuple|3.1.3|155>>
    <associate|sec:3.2|<tuple|3.2|160>>
    <associate|sec:3.3|<tuple|3.3|162>>
    <associate|sec:3.3.4|<tuple|3.3.4|162>>
    <associate|sec:3.4|<tuple|3.4|168>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|3.1>|>
        The simple environment structure
      </surround>|<pageref|auto-35>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|3.2>|>
        Environment structure produced by evaluating
        <with|mode|<quote|prog>|prog-language|<quote|scheme>|font-family|<quote|rm>|(define
        (square x) (* x x))> in the global environment.
      </surround>|<pageref|auto-37>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|3.3>|>
        The relation <with|mode|<quote|math>|9*C = 5*(F - 32)> expressed as a
        constraint network.
      </surround>|<pageref|auto-48>>
    </associate>
    <\associate|idx>
      <tuple|<tuple|modular>|<pageref|auto-2>>

      <tuple|<tuple|object>|<pageref|auto-3>>

      <tuple|<tuple|stream>|<pageref|auto-4>>

      <tuple|<tuple|environment model>|<pageref|auto-5>>

      <tuple|<tuple|delayed evaluation>|<pageref|auto-6>>

      <tuple|<tuple|state variable>|<pageref|auto-8>>

      <tuple|<tuple|local state variable>|<pageref|auto-9>>

      <tuple|<tuple|assignment operator>|<pageref|auto-10>>

      <tuple|<tuple|encapsulated>|<pageref|auto-12>>

      <tuple|<tuple|hiding principle>|<pageref|auto-13>>

      <tuple|<tuple|accumulator>|<pageref|auto-14>>

      <tuple|<tuple|pseudo-random>|<pageref|auto-16>>

      <tuple|<tuple|Monte Carlo simulation>|<pageref|auto-17>>

      <tuple|<tuple|Monte Carlo integration>|<pageref|auto-18>>

      <tuple|<tuple|functional programming>|<pageref|auto-20>>

      <tuple|<tuple|referentially transparent>|<pageref|auto-22>>

      <tuple|<tuple|aliasing>|<pageref|auto-23>>

      <tuple|<tuple|side-effect bugs>|<pageref|auto-24>>

      <tuple|<tuple|imperative programming>|<pageref|auto-26>>

      <tuple|<tuple|environments>|<pageref|auto-28>>

      <tuple|<tuple|frames>|<pageref|auto-29>>

      <tuple|<tuple|bindings>|<pageref|auto-30>>

      <tuple|<tuple|enclosing environment>|<pageref|auto-31>>

      <tuple|<tuple|global>|<pageref|auto-32>>

      <tuple|<tuple|value of a variable>|<pageref|auto-33>>

      <tuple|<tuple|unbound>|<pageref|auto-34>>

      <tuple|<tuple|primitive cnstraints>|<pageref|auto-45>>

      <tuple|<tuple|constraint networks>|<pageref|auto-46>>

      <tuple|<tuple|connectors>|<pageref|auto-47>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Modularity,
      Objects and State> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      3.1<space|2spc>Assignment and Local State
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7>

      <with|par-left|<quote|1tab>|3.1.1<space|2spc>Local State Variables
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|<quote|1tab>|3.1.2<space|2spc>The Benefits of
      Introducing Assignment <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-15>>

      <with|par-left|<quote|1tab>|3.1.3<space|2spc>The Cost of Introducing
      Assignment <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-19>>

      <with|par-left|<quote|2tab>|Sameness and Change
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-21>>

      <with|par-left|<quote|2tab>|Pitfalls of imperactive programming
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-25>>

      3.2<space|2spc>The Environment Model of Evaluation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-27>

      <with|par-left|<quote|1tab>|3.2.1<space|2spc>The Rules for Evaluation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-36>>

      <with|par-left|<quote|1tab>|3.2.2<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-38>>

      3.3<space|2spc>Modeling with Mutable Data
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-39>

      <with|par-left|<quote|1tab>|3.3.1<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-40>>

      <with|par-left|<quote|1tab>|3.3.2<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-41>>

      <with|par-left|<quote|1tab>|3.3.3<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-42>>

      <with|par-left|<quote|1tab>|3.3.4<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-43>>

      <with|par-left|<quote|1tab>|3.3.5<space|2spc>Propagation of Constraints
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-44>>

      <with|par-left|<quote|2tab>|Using the constraint system
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-49>>

      <with|par-left|<quote|2tab>|Implementing the constraint system
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-50>>

      <with|par-left|<quote|2tab>|Representing connectors
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-51>>

      3.4<space|2spc>Concurrency: Time Is of the Essence
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-52>
    </associate>
  </collection>
</auxiliary>