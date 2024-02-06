<TeXmacs|2.1.2>

<style|<tuple|course|british|smart-ref|preview-ref|doc>>

<\body>
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

  <\folded>
    <\exercise>
      Define a procedure that takes three numbers as arguments and returns
      the sum of the squares of the two larger numbers.
    </exercise>
  <|folded>
    <\solution*>
      \;

      <\session|scheme|default>
        <\unfolded-io|Scheme] >
          (define (ex3 a b c)

          \ \ (cond ((\<less\> a c) (ex3 c b a))

          \ \ \ \ \ \ \ \ ((\<less\> b c) (ex3 a c b))

          \ \ \ \ \ \ \ \ (else (+ (* a a) (* b b)))))
        <|unfolded-io>
          ex3
        </unfolded-io>

        <\unfolded-io|Scheme] >
          (ex3 1 2 3)
        <|unfolded-io>
          13
        </unfolded-io>

        <\unfolded-io|Scheme] >
          (ex3 1 3 2)
        <|unfolded-io>
          13
        </unfolded-io>

        <\unfolded-io|Scheme] >
          (ex3 2 1 3)
        <|unfolded-io>
          13
        </unfolded-io>

        <\unfolded-io|Scheme] >
          (ex3 2 3 1)
        <|unfolded-io>
          13
        </unfolded-io>

        <\unfolded-io|Scheme] >
          (ex3 3 1 2)
        <|unfolded-io>
          13
        </unfolded-io>

        <\unfolded-io|Scheme] >
          (ex3 3 2 1)
        <|unfolded-io>
          13
        </unfolded-io>

        <\input|Scheme] >
          \;
        </input>
      </session>
    </solution*>
  </folded>

  <\folded>
    <\exercise>
      \ Observe that our model of evaluation allows for combinations whose
      operators are compound expressions. Use this observation to describe
      the behavior of the following procedure:

      <\scm-code>
        (define (a-plus-abs-b a b)

        \ \ ((if (\<gtr\> b 0) + -) a b))
      </scm-code>
    </exercise>
  <|folded>
    <\solution*>
      \;

      <\scm-code>
        (a-plus-abs-b 3 4)

        ((if (\<gtr\> 4 0) + -) 3 4)

        (+ 3 4)

        7

        \;

        (a-plus-abs-b 3 -4)

        ((if (\<gtr\> -4 0) + -) 3 -4)

        (- 3 -4)

        7
      </scm-code>
    </solution*>
  </folded>

  <\folded>
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
  <|folded>
    <\solution*>
      \;

      <\description>
        <item*|normal order evaluation>

        <\scm-code>
          (test 0 (p))

          (if (= 0 0) 0 (p))

          0
        </scm-code>

        <item*|applicative order evaluation>

        <\scm-code>
          (test 0 (p))

          (test 0 (p))

          (test 0 (p))
        </scm-code>
      </description>
    </solution*>
  </folded>

  <\folded>
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

      Delighted, Alyssa uses <code*|new-if> to rewrite the square-root
      program:

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
  <|folded>
    <\session|scheme|default>
      <\unfolded-io|Scheme] >
        (define (square x) (* x x))
      <|unfolded-io>
        square
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (define (sqrt-iter guess x)

        \ \ (if (good-enough? guess x)

        \ \ \ \ \ \ guess

        \ \ \ \ \ \ (sqrt-iter (improve guess x)

        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ x)))
      <|unfolded-io>
        sqrt-iter
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (define (improve guess x)

        \ \ (average guess (/ x guess)))
      <|unfolded-io>
        improve
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (define (average x y)

        \ \ (/ (+ x y) 2))
      <|unfolded-io>
        average
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (define (good-enough? guess x)

        \ \ (\<less\> (abs (- (<hlink|square|#define_square> guess) x))
        0.001))
      <|unfolded-io>
        good-enough?
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (define (sqrt x)

        \ \ (sqrt-iter 1.0 x))
      <|unfolded-io>
        sqrt
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (sqrt 2)
      <|unfolded-io>
        1.4142156862745097
      </unfolded-io>

      \;

      Attempt to use <scm|new-if>:

      <\input|Scheme] >
        (define (new-if predicate then-clause else-clause)

        \ \ (cond (predicate then-clause)

        \ \ \ \ \ \ \ \ (else else-clause)))
      </input>

      <\input|Scheme] >
        (define (sqrt-iter guess x)

        \ \ (new-if (good-enough? guess x)

        \ \ \ \ \ \ guess

        \ \ \ \ \ \ (sqrt-iter (improve guess x)

        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ x)))
      </input>
    </session>
  </folded>

  <\folded>
    <\exercise>
      <label|ex1.7>The <code*|good-enough?> test used in computing square
      roots will not be very effective for finding the square roots of very
      small numbers. Also, in real computers, arithmetic operations are
      almost always performed with limited precision. This makes our test
      inadequate for very large numbers. Explain these statements, with
      examples showing how the test fails for small and large numbers. An
      alternative strategy for implementing <code*|good-enough?> is to watch
      how <code*|guess> changes from one iteration to the next and to stop
      when the change is a very small fraction of the guess. Design a
      square-root procedure that uses this kind of end test. Does this work
      better for small and large numbers?
    </exercise>
  <|folded>
    We can use <scm|debug-message> to print messages in
    <menu|Debug|Console|Debugging Console>.

    <\session|scheme|default>
      <\input>
        Scheme]\ 
      <|input>
        (debug-message "std" "hello\\n")
      </input>
    </session>

    <\session|scheme|default>
      <\unfolded-io|Scheme] >
        (define (square x) (* x x))
      <|unfolded-io>
        square
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (define (sqrt-iter guess x)

        \ \ (if (good-enough? guess x)

        \ \ \ \ \ \ guess

        \ \ \ \ \ \ (sqrt-iter (improve guess x)

        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ x)))
      <|unfolded-io>
        sqrt-iter
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (define (improve guess x)

        \ \ (average guess (/ x guess)))
      <|unfolded-io>
        improve
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (define (average x y)

        \ \ (/ (+ x y) 2))
      <|unfolded-io>
        average
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (define (good-enough? guess x)

        \ \ (debug-message "std" (string-append "guess: "
        (number-\<gtr\>string guess) "\\n"))

        \ \ (\<less\> (abs (- (<hlink|square|#define_square> guess) x))
        0.001))
      <|unfolded-io>
        good-enough?
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (define (sqrt x)

        \ \ (sqrt-iter 1.0 x))
      <|unfolded-io>
        sqrt
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (sqrt 0.000000001)
      <|unfolded-io>
        0.03125001065624928
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (sqrt 1000)
      <|unfolded-io>
        31.622782450701045
      </unfolded-io>

      <\input|Scheme] >
        \;
      </input>
    </session>
  </folded>

  <\exercise>
    Newton's method for cube roots is based on the fact that if <math|y> is
    an approximation to the cube root of <math|x>, then a better
    approximation is given by the value <math|<frac|x<around*|/|y<rsup|2>+2*y|\<nobracket\>>|3>>.
    Use this formula to implement a cube-root procedure analogous to the
    square-root procedure. (In Section 1.3.4 we will see how to implement
    Newton's method in general as an abstraction of these square-root and
    cube-root procedures.)
  </exercise>
</body>

<\initial>
  <\collection>
    <associate|page-medium|papyrus>
    <associate|page-screen-margin|false>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|7|?>>
    <associate|ex1.5|<tuple|5|1>>
    <associate|ex1.7|<tuple|7|2>>
  </collection>
</references>