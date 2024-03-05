<TeXmacs|2.1.2>

<style|<tuple|exam|no-page-numbers|british|smart-ref>>

<\body>
  <\folded>
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
      procedure in evaluating <code*|(+ 4 5)>. Are these processes iterative
      or recursive?
    </exercise>
  <|folded>
    <\scm-code>
      (+ 4 5)

      (inc (+ 3 5))

      (inc (inc (+ 2 5)))

      (inc (inc (inc (+ 1 5))))

      (inc (inc (inc (inc (+ 0 5)))))

      (inc (inc (inc (inc 5))))

      (inc (inc (inc 6)))

      (inc (inc 7))

      (inc 8)

      9

      \;

      (+ 4 5)

      (+ 3 6)

      (+ 2 7)

      (+ 1 8)

      (+ 0 9)

      9
    </scm-code>
  </folded>

  <\folded>
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
  <|folded>
    <\session|scheme|default>
      <\folded-io|Scheme] >
        (define (A x y)

        \ \ (cond ((= y 0) 0)

        \ \ \ \ \ \ \ \ ((= x 0) (* 2 y))

        \ \ \ \ \ \ \ \ ((= y 1) 2)

        \ \ \ \ \ \ \ \ (else (A (- x 1)

        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (A x (- y 1))))))
      <|folded-io>
        A
      </folded-io>

      <\folded-io|Scheme] >
        (A 1 10)
      <|folded-io>
        1024
      </folded-io>

      <\folded-io|Scheme] >
        (A 2 4)
      <|folded-io>
        65536
      </folded-io>

      <\folded-io|Scheme] >
        (A 3 3)
      <|folded-io>
        65536
      </folded-io>

      <\input|Scheme] >
        \;
      </input>
    </session>

    <\wide-tabular>
      <tformat|<cwith|4|4|5|5|cell-background|pastel
      green>|<table|<row|<\cell>
        \;
      </cell>|<\cell>
        0
      </cell>|<\cell>
        1
      </cell>|<\cell>
        2
      </cell>|<\cell>
        3
      </cell>|<\cell>
        4
      </cell>|<\cell>
        5
      </cell>|<\cell>
        y
      </cell>>|<row|<\cell>
        0
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 0 0)
        </script-input|0>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 0 1)
        </script-input|2>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 0 2)
        </script-input|4>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 0 3)
        </script-input|6>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 0 4)
        </script-input|8>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 0 5)
        </script-input|10>
      </cell>|<\cell>
        f
      </cell>>|<row|<\cell>
        1
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 1 0)
        </script-input|0>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 1 1)
        </script-input|2>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 1 2)
        </script-input|4>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 1 3)
        </script-input|8>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 1 4)
        </script-input|16>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 1 5)
        </script-input|32>
      </cell>|<\cell>
        g
      </cell>>|<row|<\cell>
        2
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 2 0)
        </script-input|0>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 2 1)
        </script-input|2>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 2 2)
        </script-input|4>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 2 3)
        </script-input|16>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 2 4)
        </script-input|65536>
      </cell>|<\cell>
        <\script-input|scheme|default>
          (A 2 5)
        </script-input|>
      </cell>|<\cell>
        h
      </cell>>|<row|<\cell>
        x
      </cell>|<\cell>
        \;
      </cell>|<\cell>
        \;
      </cell>|<\cell>
        \;
      </cell>|<\cell>
        \;
      </cell>|<\cell>
        \;
      </cell>|<\cell>
        \;
      </cell>|<\cell>
        \;
      </cell>>>>
    </wide-tabular>

    <\equation*>
      f<around*|(|n|)>=2*n
    </equation*>

    <\equation*>
      g<around*|(|n|)>=<choice|<tformat|<table|<row|<cell|0>|<cell|,n=0>>|<row|<cell|2<rsup|n>>|<cell|,n\<gtr\>0>>>>>
    </equation*>

    <\equation*>
      h<around*|(|n|)>=<choice|<tformat|<table|<row|<cell|0>|<cell|,n=0>>|<row|<cell|2<rsup|2<rsup|n-1>>>|<cell|,n\<gtr\>0>>>>>
    </equation*>

    \;
  </folded>

  <\folded>
    <\exercise>
      A function <math|f> is defined by the rule that
      <math|f<around*|(|n|)>=n> if <math|n\<less\>3> and
      <math|f<around*|(|n|)>=f<around*|(|n-1|)>+2*f<around*|(|n-2|)>+3*f<around*|(|n-3|)>>
      if <math|n\<geq\>3>. Write a procedure that computes <math|f> by means
      of a recursive process. Write a procedure that computes <math|f> by
      means of an iterative process.
    </exercise>
  <|folded>
    <\equation*>
      f<around*|(|n|)>=<choice|<tformat|<table|<row|<cell|n>|<cell|,n\<less\>3>>|<row|<cell|f<around*|(|n-1|)>+2*f<around*|(|n-2|)>+3*f<around*|(|n-3|)>>|<cell|,n\<geqslant\>3>>>>>
    </equation*>

    <\session|scheme|default>
      <\unfolded-io|Scheme] >
        (define (f n)

        \ \ (if (\<less\> n 3)

        \ \ \ \ \ \ n

        \ \ \ \ \ \ (+ (f (- n 1))

        \ \ \ \ \ \ \ \ \ (* 2 (f (- n 2)))

        \ \ \ \ \ \ \ \ \ (* 3 (f (- n 3))))))
      <|unfolded-io>
        f
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (f 1)
      <|unfolded-io>
        1
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (f 2)
      <|unfolded-io>
        2
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (f 5)
      <|unfolded-io>
        25
      </unfolded-io>

      <\input|Scheme] >
        \;
      </input>
    </session>

    <\wide-tabular>
      <tformat|<table|<row|<\cell>
        0
      </cell>|<\cell>
        1
      </cell>|<\cell>
        2
      </cell>|<\cell>
        3
      </cell>|<\cell>
        4
      </cell>|<\cell>
        5
      </cell>|<\cell>
        6
      </cell>|<\cell>
        7
      </cell>>|<row|<\cell>
        0
      </cell>|<\cell>
        1
      </cell>|<\cell>
        2
      </cell>|<\cell>
        4
      </cell>|<\cell>
        11
      </cell>|<\cell>
        25
      </cell>|<\cell>
        \;
      </cell>|<\cell>
        \;
      </cell>>>>
    </wide-tabular>

    <\session|scheme|default>
      <\unfolded-io|Scheme] >
        (define (iter-f f0 f1 f2 i n)

        \ \ (if (\<less\> i n)

        \ \ \ \ \ \ (iter-f f1 f2 (+ (* 3 f0) (* 2 f1) f2) (+ i 1) n)

        \ \ \ \ \ \ f2))
      <|unfolded-io>
        iter-f
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (iter-f 0 1 2 2 2)
      <|unfolded-io>
        2
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (iter-f 0 1 2 2 5)
      <|unfolded-io>
        25
      </unfolded-io>

      <\input|Scheme] >
        \;
      </input>
    </session>
  </folded>

  <\folded>
    <\exercise>
      The following pattern of numbers is called <em|Pascal's
      triangle><glossary-explain|Pascal's
      triangle|\<#5E15\>\<#65AF\>\<#5361\>\<#4E09\>\<#89D2\>\<#5F62\>>.

      <\code>
        \ \ \ \ \ \ \ \ \ 1

        \ \ \ \ \ \ \ 1 \ \ 1

        \ \ \ \ \ 1 \ \ 2 \ \ 1

        \ \ \ 1 \ \ 3 \ \ 3 \ \ 1

        \ 1 \ \ 4 \ \ 6 \ \ 4 \ \ 1

        \ \ \ \ \ \ \ . . .
      </code>

      The numbers at the edge of the triangle are all 1, and each number
      inside the triangle is the sum of the two numbers above it.<\footnote>
        The elements of Pascal's triangle are called the <em|binomial
        coefficients><index|binomial coefficients>, because the
        <math|n<rsup|<with|mode|text|th>>> row consists of the coefficients
        of the terms in the expansion of <math|<around*|(|x+y|)><rsup|n>>.
        This pattern for computing the coefficients appeared in Blaise
        Pascal's 1653 seminal work on probability theory, <em|Trait� du
        triangle arithm�tique>. According to Knuth (1973), the same pattern
        appears in the <em|Szu-yuen Y�-chien> (\PThe Precious Mirror of the
        Four Elements\Q), published by the Chinese mathematician Chu
        Shih-chieh in 1303, in the works of the twelfth-century Persian poet
        and mathematician Omar Khayyam, and in the works of the
        twelfth-century Hindu mathematician Bh�scara �ch�rya.
      </footnote> Write a procedure that computes elements of Pascal's
      triangle by means of a recursive process.
    </exercise>
  <|folded>
    <tabular|<tformat|<table|<row|<cell|>|<cell|0>|<cell|1>|<cell|2>|<cell|3>|<cell|4>|<cell|b>>|<row|<cell|0>|<cell|1>|<cell|>|<cell|>|<cell|>|<cell|>|<cell|>>|<row|<cell|1>|<cell|1>|<cell|1>|<cell|>|<cell|>|<cell|>|<cell|>>|<row|<cell|2>|<cell|1>|<cell|2>|<cell|1>|<cell|>|<cell|>|<cell|>>|<row|<cell|3>|<cell|1>|<cell|3>|<cell|3>|<cell|1>|<cell|>|<cell|>>|<row|<cell|4>|<cell|1>|<cell|4>|<cell|6>|<cell|4>|<cell|1>|<cell|>>|<row|<cell|a>|<cell|>|<cell|>|<cell|>|<cell|>|<cell|>|<cell|>>>>>

    <\equation*>
      f<around*|(|a,b|)>=<choice|<tformat|<table|<row|<cell|1>|<cell|,a=0>>|<row|<cell|1>|<cell|,a=b>>|<row|<cell|f<around*|(|a-1,b|)>+f<around*|(|a-1,b-1|)>>|<cell|>>>>>
    </equation*>

    <\session|scheme|default>
      <\unfolded-io|Scheme] >
        (define (f a b)

        \ \ (cond ((= b 0) 1)

        \ \ \ \ \ \ \ \ ((= a b) 1)

        \ \ \ \ \ \ \ \ (else (+ (f (- a 1) b) (f (- a 1) (- b 1))))))
      <|unfolded-io>
        f
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (f 0 0)
      <|unfolded-io>
        1
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (f 2 1)
      <|unfolded-io>
        2
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (f 3 1)
      <|unfolded-io>
        3
      </unfolded-io>

      <\unfolded-io|Scheme] >
        (f 4 2)
      <|unfolded-io>
        6
      </unfolded-io>

      <\input|Scheme] >
        \;
      </input>
    </session>
  </folded>

  <\folded>
    <\exercise>
      <label|ex1.13>Prove that <math|<with|mode|text|Fib><around*|(|n|)>> is
      the closest integer to <math|\<varphi\><rsup|n><around*|/|<sqrt|5>|\<nobracket\>>>,
      where <math|\<varphi\>=<around*|(|1+<sqrt|5>|)><around*|/|2|\<nobracket\>>>.
      Hint: Let <math|\<psi\>=<around*|(|1-<sqrt|5>|)><around*|/|2|\<nobracket\>>>.
      Use induction and the definition of the Fibonacci numbers (see Section
      1.2.2) to prove that <math|<with|mode|text|Fib><around*|(|n|)>=<around*|(|\<varphi\><rsup|n>-\<psi\><rsup|n>|)><around*|/|<sqrt|5>|\<nobracket\>>>.
    </exercise>
  <|folded>
    <slink|https://www.zhihu.com/question/61973263>

    <\equation*>
      F<rsub|n> =<frac|1|<sqrt|5>><left|(><left|(><frac|1+<sqrt|5>|2><right|)><rsup|n>-<left|(><frac|1-<sqrt|5>|2><right|)><rsup|n><right|)>
    </equation*>

    <\aligned>
      <tformat|<table|<row|<cell|<frac|F<rsub|n>|F<rsub|n+1>>>|<cell|=<frac|<around*|(|<frac|1+<sqrt|5>|2>|)><rsup|n>-<around*|(|<frac|1-<sqrt|5>|2>|)><rsup|n>|<around*|(|<frac|1+<sqrt|5>|2>|)><rsup|n+1>-<around*|(|<frac|1-<sqrt|5>|2>|)><rsup|n+1>>=<frac|<frac|2|1+<sqrt|5>><around*|(|<frac|1+<sqrt|5>|2>|)><rsup|n+1>-<frac|2|1-<sqrt|5>><around*|(|<frac|1-<sqrt|5>|2>|)><rsup|n+1>|<around*|(|<frac|1+<sqrt|5>|2>|)><rsup|n+1>-<around*|(|<frac|1-<sqrt|5>|2>|)><rsup|n+1>>>>|<row|<cell|>|<cell|=<frac|<frac|<sqrt|5>-1|2><around*|(|<frac|1+<sqrt|5>|2>|)><rsup|n+1>-<around*|(|-<frac|1+<sqrt|5>|2>|)><around*|(|<frac|1-<sqrt|5>|2>|)><rsup|n+1>|<around*|(|<frac|1+<sqrt|5>|2>|)><rsup|n+1>-<around*|(|<frac|1-<sqrt|5>|2>|)><rsup|n+1>>>>|<row|<cell|>|<cell|=<frac|<frac|<sqrt|5>-1|2><around*|(|<frac|1+<sqrt|5>|2>|)><rsup|n+1>-<around*|(|<frac|<sqrt|5>-1|2>-<sqrt|5>|)><around*|(|<frac|1-<sqrt|5>|2>|)><rsup|n+1>|<around*|(|<frac|1+<sqrt|5>|2>|)><rsup|n+1>-<around*|(|<frac|1-<sqrt|5>|2>|)><rsup|n+1>>>>|<row|<cell|>|<cell|=<frac|<frac|<sqrt|5>-1|2><around*|(|<frac|1+<sqrt|5>|2>|)><rsup|n+1>-<frac|<sqrt|5>-1|2><around*|(|<frac|1-<sqrt|5>|2>|)><rsup|n+1>|<around*|(|<frac|1+<sqrt|5>|2>|)><rsup|n+1>-<around*|(|<frac|1-<sqrt|5>|2>|)><rsup|n+1>>+<frac|<sqrt|5><around*|(|<frac|1-<sqrt|5>|2>|)><rsup|n+1>|<around*|(|<frac|1+<sqrt|5>|2>|)><rsup|n+1>-<around*|(|<frac|1-<sqrt|5>|2>|)><rsup|n+1>>>>|<row|<cell|>|<cell|=<frac|<sqrt|5>-1|2>+<frac|<sqrt|5>|<around*|(|-<frac|3+<sqrt|5>|2>|)><rsup|n+1>-1>>>>>
    </aligned>
  </folded>
</body>

<\initial>
  <\collection>
    <associate|page-screen-margin|false>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|Pascal's triangle|?>>
    <associate|auto-2|<tuple|binomial coefficients|?>>
    <associate|ex1.13|<tuple|5|?>>
    <associate|footnote-1|<tuple|1|?>>
    <associate|footnr-1|<tuple|binomial coefficients|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|gly>
      <tuple|normal|Pascal's triangle|\<#5E15\>\<#65AF\>\<#5361\>\<#4E09\>\<#89D2\>\<#5F62\>|<pageref|auto-1>>
    </associate>
    <\associate|idx>
      <tuple|<tuple|binomial coefficients>|<pageref|auto-2>>
    </associate>
  </collection>
</auxiliary>