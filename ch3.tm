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
    <associate|%_fig_3.4|<tuple|3.3|?>>
    <associate|%_fig_3.5|<tuple|3.3|?>>
    <associate|%_idx_3074|<tuple|<with|mode|<quote|math>|\<bullet\>>|?>>
    <associate|%_idx_3076|<tuple|<with|mode|<quote|math>|\<bullet\>>|?>>
    <associate|%_idx_3078|<tuple|<with|mode|<quote|math>|\<bullet\>>|?>>
    <associate|%_idx_3088|<tuple|3.5|?>>
    <associate|%_idx_3090|<tuple|3.5|?>>
    <associate|%_idx_3092|<tuple|3.5|?>>
    <associate|%_thm_3.9|<tuple|3.5|?>>
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
    <associate|auto-38|<tuple|3.3|162>>
    <associate|auto-39|<tuple|3.2.2|162>>
    <associate|auto-4|<tuple|stream|147>>
    <associate|auto-40|<tuple|3.4|162>>
    <associate|auto-41|<tuple|3.5|162>>
    <associate|auto-42|<tuple|3.3|162>>
    <associate|auto-43|<tuple|3.3.1|162>>
    <associate|auto-44|<tuple|3.3.2|162>>
    <associate|auto-45|<tuple|3.3.3|163>>
    <associate|auto-46|<tuple|3.3.4|163>>
    <associate|auto-47|<tuple|3.3.5|163>>
    <associate|auto-48|<tuple|primitive cnstraints|163>>
    <associate|auto-49|<tuple|constraint networks|164>>
    <associate|auto-5|<tuple|environment model|147>>
    <associate|auto-50|<tuple|connectors|165>>
    <associate|auto-51|<tuple|3.6|168>>
    <associate|auto-52|<tuple|3.6|168>>
    <associate|auto-53|<tuple|3.6|?>>
    <associate|auto-54|<tuple|<with|mode|<quote|math>|\<bullet\>>|?>>
    <associate|auto-55|<tuple|3.4|?>>
    <associate|auto-6|<tuple|delayed evaluation|147>>
    <associate|auto-7|<tuple|3.1|147>>
    <associate|auto-8|<tuple|state variable|147>>
    <associate|auto-9|<tuple|local state variable|148>>
    <associate|call_footnote_Temp_343|<tuple|<with|mode|<quote|math>|\<bullet\>>|?>>
    <associate|call_footnote_Temp_345|<tuple|3.5|?>>
    <associate|fig:3.2|<tuple|3.2|162>>
    <associate|fig:3.28|<tuple|3.6|163>>
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