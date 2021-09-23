<TeXmacs|2.1>

<style|<tuple|book|old-dots|old-lengths|comment|maxima>>

<\body>
  <\hide-preamble>
    <assign|paragraph-toc|<macro|name|>>
  </hide-preamble>

  <doc-data|<doc-title|Structure and Interpretation of Computer
  programs>|<doc-author|<author-data|<author-name|Harold
  Abelson>>>|<doc-author|<author-data|<author-name|Gerald Jay
  Sussman>>>|<doc-author|<author-data|<author-name|Julie Sussman>>>>

  <\table-of-contents|toc>
    <vspace*|1fn><with|font-series|bold|math-font-series|bold|List of
    figures> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-1><vspace|0.5fn>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|1<space|2spc>Building
    Abstractions with Procedures> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-2><vspace|0.5fn>

    1.1<space|2spc>The Elements of Programming
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-13>

    <with|par-left|1tab|1.1.1<space|2spc>Expressions
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-16>>

    <with|par-left|1tab|1.1.2<space|2spc>Naming and the Environment
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-26>>

    <with|par-left|1tab|1.1.3<space|2spc>Evaluating Combinations
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-31>>

    <with|par-left|1tab|1.1.4<space|2spc>Compound Procedures
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-37>>

    <with|par-left|1tab|1.1.5<space|2spc>The Substitution Model for Procedure
    Application <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-40>>

    <with|par-left|1tab|1.1.6<space|2spc>Conditional Expressions and
    Predicates <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-46>>

    <with|par-left|1tab|1.1.7<space|2spc>Example: Square Roots by Newton's
    Method <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-52>>

    <with|par-left|1tab|1.1.8<space|2spc>Procedures as Black-Box Abstractions
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-53>>

    1.2<space|2spc>Procedures and the Processes They Generate
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-64>

    <with|par-left|1tab|1.2.1<space|2spc>Linear Recursion and Iteration
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-67>>

    <with|par-left|1tab|1.2.2<space|2spc>Tree Recursion
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-79>>

    <with|par-left|1tab|1.2.3<space|2spc>Orders of Growth
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-87>>

    <with|par-left|1tab|1.2.4<space|2spc>Exponentiation
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-89>>

    <with|par-left|1tab|1.2.5<space|2spc>Greatest Common Divisors
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-91>>

    <with|par-left|1tab|1.2.6<space|2spc>Example: Testing for Primality
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-93>>

    1.3<space|2spc>Formulating Abstractions with Higher-Order Procedures
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-101>

    <with|par-left|1tab|1.3.1<space|2spc>Procedures as Arguments
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-103>>

    <with|par-left|1tab|1.3.2<space|2spc>Constructing Procedures Using
    <with|font-family|tt|Lambda> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-107>>

    <with|par-left|1tab|1.3.3<space|2spc>Procedures as General Methods
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-108>>

    <with|par-left|1tab|1.3.4<space|2spc>Procedures as Returned Values
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-114>>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|Index>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-121><vspace|0.5fn>
  </table-of-contents>

  <\list-of-figures|figure>
    <glossary-1|<\surround|<hidden-binding|<tuple>|1.1>|>
      Tree representation, showing the value of each subcombination.
    </surround>|<pageref|auto-34>>

    <glossary-1|<\surround|<hidden-binding|<tuple>|1.2>|>
      Procedural decomposition of the <with|mode|prog|prog-language|scheme|font-family|rm|sqrt>
      program
    </surround>|<pageref|auto-55>>

    <glossary-1|<\surround|<hidden-binding|<tuple>|1.3>|>
      A linear recursive process for computing 6!.
    </surround>|<pageref|auto-68>>

    <glossary-1|<\surround|<hidden-binding|<tuple>|1.4>|>
      A linear iterative process for computing 6!.
    </surround>|<pageref|auto-69>>

    <glossary-1|<\surround|<hidden-binding|<tuple>|1.5>|>
      The tree-recursive process generated in computing
      <with|font-family|tt|(fib 5)>.
    </surround>|<pageref|auto-81>>
  </list-of-figures>

  <include|ch1.tm>

  <\the-index|idx>
    <index+1|application-order evaluation|<pageref|auto-44>>

    <index+1|arguments|<pageref|auto-22>>

    <index+1|average damping|<pageref|auto-111>>

    <index+1|binds|<pageref|auto-58>>

    <index+1|binomial coefficients|<pageref|auto-86>>

    <index+1|block structure|<pageref|auto-62>>

    <index+1|bound variable|<pageref|auto-57>>

    <index+1|bugs|<pageref|auto-7>>

    <index+1|capturing|<pageref|auto-61>>

    <index+1|Carmichael numbers|<pageref|auto-97>>

    <index+1|case analysis|<pageref|auto-47>>

    <index+1|clauses|<pageref|auto-48>>

    <index+1|combinations|<pageref|auto-19>>

    <index+1|composition|<pageref|auto-117>>

    <index+1|compound procedure|<pageref|auto-39>>

    <index+1|computational process|<pageref|auto-3>>

    <index+1|congruent modulo|<pageref|auto-94>>

    <index+1|consequent expression|<pageref|auto-50>>

    <index+1|continued fraction|<pageref|auto-112>>

    <index+1|data|<pageref|auto-4>>

    <index+1|debug|<pageref|auto-9>>

    <index+1|deferred operations|<pageref|auto-70>>

    <index+1|environment|<pageref|auto-29>>

    <index+1|Euclid's Algorithm|<pageref|auto-92>>

    <index+1|evaluating|<pageref|auto-18>>

    <index+1|expression|<pageref|auto-17>>

    <index+1|filter|<pageref|auto-106>>

    <index+1|first-class|<pageref|auto-116>>

    <index+1|fixed point|<pageref|auto-110>>

    <index+1|free|<pageref|auto-59>>

    <index+1|glitches|<pageref|auto-8>>

    <index+1|global|<pageref|auto-66>>

    <index+1|global environment|<pageref|auto-30>>

    <index+1|golden ratio|<pageref|auto-82>>

    <index+1|half interval method|<pageref|auto-109>>

    <index+1|higher-order procedures|<pageref|auto-102>>

    <index+1|integers|<pageref|auto-14>>

    <index+1|interpreter|<pageref|auto-11>>

    <index+1|invariant quantity|<pageref|auto-90>>

    <index+1|iterative improvement|<pageref|auto-120>>

    <index+1|iterative process|<pageref|auto-73>>

    <index+1|k-term finite continued fraction|<pageref|auto-113>>

    <index+1|lexical scoping|<pageref|auto-63>>

    <index+1|linear iterative process|<pageref|auto-75>>

    <index+1|linear recursive process|<pageref|auto-72>>

    <index+1|local evolution|<pageref|auto-65>>

    <index+1|memoization|<pageref|auto-84>>

    <index+1|Miller-Rabin test|<pageref|auto-100>>

    <index+1|modulo|<pageref|auto-96>>

    <index+1|Newton's method|<pageref|auto-115>>

    <index+1|n-fold smoothed function|<pageref|auto-119>>

    <index+1|normal order evaluation|<pageref|auto-43>>

    <index+1|operands|<pageref|auto-21>>

    <index+1|operator|<pageref|auto-20>>

    <index+1|order of growth|<pageref|auto-88>>

    <index+1|Pascal's triangle|<pageref|auto-85>>

    <index+1|predicate|<pageref|auto-49>, <pageref|auto-51>>

    <index+1|prefix notation|<pageref|auto-23>>

    <index+1|pretty-printing|<pageref|auto-24>>

    <index+1|probabilistic algorithms|<pageref|auto-98>>

    <index+1|procedural abstraction|<pageref|auto-56>>

    <index+1|procedure|<pageref|auto-77>>

    <index+1|procedure definitions|<pageref|auto-38>>

    <index+1|procedures|<pageref|auto-12>>

    <index+1|process|<pageref|auto-76>>

    <index+1|program|<pageref|auto-5>>

    <index+1|programming languages|<pageref|auto-6>>

    <index+1|read-eval-print loop|<pageref|auto-25>>

    <index+1|real numbers|<pageref|auto-15>>

    <index+1|recursive|<pageref|auto-32>, <pageref|auto-54>>

    <index+1|recursive process|<pageref|auto-71>>

    <index+1|recusion equations|<pageref|auto-10>>

    <index+1|remainder of|<pageref|auto-95>>

    <index+1|RSA algorithm|<pageref|auto-99>>

    <index+1|scope|<pageref|auto-60>>

    <index+1|sequences|<pageref|auto-105>>

    <index+1|smoothing|<pageref|auto-118>>

    <index+1|special forms|<pageref|auto-35>>

    <index+1|state variables|<pageref|auto-74>>

    <index+1|stream processing|<pageref|auto-45>>

    <index+1|substitution|<pageref|auto-42>>

    <index+1|substitution model|<pageref|auto-41>>

    <index+1|summation of a series|<pageref|auto-104>>

    <index+1|syntactic sugar|<pageref|auto-36>>

    <index+1|tabulation|<pageref|auto-83>>

    <index+1|tail-recursive|<pageref|auto-78>>

    <index+1|tree accumulation|<pageref|auto-33>>

    <index+1|tree recursion|<pageref|auto-80>>

    <index+1|value|<pageref|auto-28>>

    <index+1|variable|<pageref|auto-27>>
  </the-index>
</body>

<\initial>
  <\collection>
    <associate|global-title|sicp.tm>
    <associate|info-flag|minimal>
    <associate|page-medium|paper>
    <associate|par-first|0tab>
    <associate|par-par-sep|1fn>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|#1.2.6|<tuple|1.2.6|41|ch1.tm>>
    <associate|%_idx_102|<tuple|1.3|10|ch1.tm>>
    <associate|%_idx_104|<tuple|1.3|10|ch1.tm>>
    <associate|%_idx_106|<tuple|1.3|10|ch1.tm>>
    <associate|%_idx_32|<tuple|interpreter|10|ch1.tm>>
    <associate|%_idx_34|<tuple|interpreter|10|ch1.tm>>
    <associate|%_idx_36|<tuple|1.1|10|ch1.tm>>
    <associate|%_idx_46|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_48|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_50|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_52|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_54|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_56|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_58|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_60|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_62|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_64|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_66|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_68|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_70|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_72|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_74|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_76|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_78|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_80|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_82|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_84|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_86|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_88|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_90|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_92|<tuple|1.2|10|ch1.tm>>
    <associate|%_idx_94|<tuple|1.2|10|ch1.tm>>
    <associate|1.1|<tuple|1.1|11|ch1.tm>>
    <associate|1.1.3|<tuple|1.1.3|14|ch1.tm>>
    <associate|1.1.4|<tuple|1.1.4|16|ch1.tm>>
    <associate|1.1.7|<tuple|1.1.7|23|ch1.tm>>
    <associate|1.1.8|<tuple|1.1.8|26|ch1.tm>>
    <associate|1.2.1|<tuple|1.2.1|29|ch1.tm>>
    <associate|1.2.2|<tuple|1.2.2|33|ch1.tm>>
    <associate|1.2.4|<tuple|1.2.4|37|ch1.tm>>
    <associate|1.3|<tuple|1.3|45|ch1.tm>>
    <associate|1.3.1|<tuple|1.3.1|46|ch1.tm>>
    <associate|1.3.3|<tuple|1.3.3|53|ch1.tm>>
    <associate|DOCF58|<tuple|1.57|55|ch1.tm>>
    <associate|Exercise-1_002e10|<tuple|1.31|32|ch1.tm>>
    <associate|Exercise-1_002e11|<tuple|memoization|36|ch1.tm>>
    <associate|Exercise-1_002e12|<tuple|memoization|36|ch1.tm>>
    <associate|Exercise-1_002e13|<tuple|binomial coefficients|36|ch1.tm>>
    <associate|Exercise-1_002e14|<tuple|1.36|37|ch1.tm>>
    <associate|Exercise-1_002e15|<tuple|1.36|37|ch1.tm>>
    <associate|Exercise-1_002e16|<tuple|1.39|39|ch1.tm>>
    <associate|Exercise-1_002e17|<tuple|invariant quantity|39|ch1.tm>>
    <associate|Exercise-1_002e18|<tuple|invariant quantity|39|ch1.tm>>
    <associate|Exercise-1_002e19|<tuple|1.40|39|ch1.tm>>
    <associate|Exercise-1_002e20|<tuple|1.43|41|ch1.tm>>
    <associate|Exercise-1_002e21|<tuple|RSA algorithm|44|ch1.tm>>
    <associate|Exercise-1_002e22|<tuple|RSA algorithm|44|ch1.tm>>
    <associate|Exercise-1_002e23|<tuple|RSA algorithm|44|ch1.tm>>
    <associate|Exercise-1_002e24|<tuple|RSA algorithm|44|ch1.tm>>
    <associate|Exercise-1_002e25|<tuple|RSA algorithm|44|ch1.tm>>
    <associate|Exercise-1_002e26|<tuple|RSA algorithm|44|ch1.tm>>
    <associate|Exercise-1_002e27|<tuple|RSA algorithm|45|ch1.tm>>
    <associate|Exercise-1_002e28|<tuple|RSA algorithm|45|ch1.tm>>
    <associate|Exercise-1_002e29|<tuple|1.50|48|ch1.tm>>
    <associate|Exercise-1_002e30|<tuple|1.50|48|ch1.tm>>
    <associate|Exercise-1_002e31|<tuple|1.50|48|ch1.tm>>
    <associate|Exercise-1_002e32|<tuple|b|49|ch1.tm>>
    <associate|Exercise-1_002e33|<tuple|b|49|ch1.tm>>
    <associate|Exercise-1_002e34|<tuple|1.54|52|ch1.tm>>
    <associate|Exercise-1_002e35|<tuple|average damping|55|ch1.tm>>
    <associate|Exercise-1_002e36|<tuple|average damping|56|ch1.tm>>
    <associate|Exercise-1_002e37|<tuple|average damping|56|ch1.tm>>
    <associate|Exercise-1_002e38|<tuple|2|56|ch1.tm>>
    <associate|Exercise-1_002e39|<tuple|2|56|ch1.tm>>
    <associate|Exercise-1_002e40|<tuple|1.66|60|ch1.tm>>
    <associate|Exercise-1_002e41|<tuple|1.66|60|ch1.tm>>
    <associate|Exercise-1_002e42|<tuple|1.66|60|ch1.tm>>
    <associate|Exercise-1_002e43|<tuple|composition|60|ch1.tm>>
    <associate|Exercise-1_002e44|<tuple|composition|60|ch1.tm>>
    <associate|Exercise-1_002e45|<tuple|n-fold smoothed function|60|ch1.tm>>
    <associate|Exercise-1_002e46|<tuple|n-fold smoothed function|60|ch1.tm>>
    <associate|Exercise-1_002e9|<tuple|1.31|32|ch1.tm>>
    <associate|Figure1.1|<tuple|1.1|15|ch1.tm>>
    <associate|auto-1|<tuple|?|7>>
    <associate|auto-10|<tuple|recusion equations|9|ch1.tm>>
    <associate|auto-100|<tuple|Miller-Rabin test|45|ch1.tm>>
    <associate|auto-101|<tuple|1.3|45|ch1.tm>>
    <associate|auto-102|<tuple|higher-order procedures|46|ch1.tm>>
    <associate|auto-103|<tuple|1.3.1|46|ch1.tm>>
    <associate|auto-104|<tuple|summation of a series|46|ch1.tm>>
    <associate|auto-105|<tuple|sequences|48|ch1.tm>>
    <associate|auto-106|<tuple|filter|49|ch1.tm>>
    <associate|auto-107|<tuple|1.3.2|49|ch1.tm>>
    <associate|auto-108|<tuple|1.3.3|53|ch1.tm>>
    <associate|auto-109|<tuple|half interval method|53|ch1.tm>>
    <associate|auto-11|<tuple|interpreter|10|ch1.tm>>
    <associate|auto-110|<tuple|fixed point|54|ch1.tm>>
    <associate|auto-111|<tuple|average damping|55|ch1.tm>>
    <associate|auto-112|<tuple|continued fraction|56|ch1.tm>>
    <associate|auto-113|<tuple|k-term finite continued fraction|56|ch1.tm>>
    <associate|auto-114|<tuple|1.3.4|56|ch1.tm>>
    <associate|auto-115|<tuple|Newton's method|57|ch1.tm>>
    <associate|auto-116|<tuple|first-class|59|ch1.tm>>
    <associate|auto-117|<tuple|composition|60|ch1.tm>>
    <associate|auto-118|<tuple|smoothing|60|ch1.tm>>
    <associate|auto-119|<tuple|n-fold smoothed function|60|ch1.tm>>
    <associate|auto-12|<tuple|procedures|10|ch1.tm>>
    <associate|auto-120|<tuple|iterative improvement|60|ch1.tm>>
    <associate|auto-121|<tuple|iterative improvement|61>>
    <associate|auto-13|<tuple|1.1|11|ch1.tm>>
    <associate|auto-14|<tuple|integers|11|ch1.tm>>
    <associate|auto-15|<tuple|real numbers|11|ch1.tm>>
    <associate|auto-16|<tuple|1.1.1|11|ch1.tm>>
    <associate|auto-17|<tuple|expression|11|ch1.tm>>
    <associate|auto-18|<tuple|evaluating|11|ch1.tm>>
    <associate|auto-19|<tuple|combinations|12|ch1.tm>>
    <associate|auto-2|<tuple|1|9|ch1.tm>>
    <associate|auto-20|<tuple|operator|12|ch1.tm>>
    <associate|auto-21|<tuple|operands|12|ch1.tm>>
    <associate|auto-22|<tuple|arguments|12|ch1.tm>>
    <associate|auto-23|<tuple|prefix notation|12|ch1.tm>>
    <associate|auto-24|<tuple|pretty-printing|13|ch1.tm>>
    <associate|auto-25|<tuple|read-eval-print loop|13|ch1.tm>>
    <associate|auto-26|<tuple|1.1.2|13|ch1.tm>>
    <associate|auto-27|<tuple|variable|13|ch1.tm>>
    <associate|auto-28|<tuple|value|13|ch1.tm>>
    <associate|auto-29|<tuple|environment|14|ch1.tm>>
    <associate|auto-3|<tuple|computational process|9|ch1.tm>>
    <associate|auto-30|<tuple|global environment|14|ch1.tm>>
    <associate|auto-31|<tuple|1.1.3|14|ch1.tm>>
    <associate|auto-32|<tuple|recursive|14|ch1.tm>>
    <associate|auto-33|<tuple|tree accumulation|15|ch1.tm>>
    <associate|auto-34|<tuple|1.1|15|ch1.tm>>
    <associate|auto-35|<tuple|special forms|16|ch1.tm>>
    <associate|auto-36|<tuple|syntactic sugar|16|ch1.tm>>
    <associate|auto-37|<tuple|1.1.4|16|ch1.tm>>
    <associate|auto-38|<tuple|procedure definitions|16|ch1.tm>>
    <associate|auto-39|<tuple|compound procedure|16|ch1.tm>>
    <associate|auto-4|<tuple|data|9|ch1.tm>>
    <associate|auto-40|<tuple|1.1.5|18|ch1.tm>>
    <associate|auto-41|<tuple|substitution model|18|ch1.tm>>
    <associate|auto-42|<tuple|substitution|19|ch1.tm>>
    <associate|auto-43|<tuple|normal order evaluation|19|ch1.tm>>
    <associate|auto-44|<tuple|application-order evaluation|19|ch1.tm>>
    <associate|auto-45|<tuple|stream processing|19|ch1.tm>>
    <associate|auto-46|<tuple|1.1.6|20|ch1.tm>>
    <associate|auto-47|<tuple|case analysis|20|ch1.tm>>
    <associate|auto-48|<tuple|clauses|20|ch1.tm>>
    <associate|auto-49|<tuple|predicate|20|ch1.tm>>
    <associate|auto-5|<tuple|program|9|ch1.tm>>
    <associate|auto-50|<tuple|consequent expression|20|ch1.tm>>
    <associate|auto-51|<tuple|predicate|20|ch1.tm>>
    <associate|auto-52|<tuple|1.1.7|23|ch1.tm>>
    <associate|auto-53|<tuple|1.1.8|26|ch1.tm>>
    <associate|auto-54|<tuple|recursive|26|ch1.tm>>
    <associate|auto-55|<tuple|1.2|26|ch1.tm>>
    <associate|auto-56|<tuple|procedural abstraction|26|ch1.tm>>
    <associate|auto-57|<tuple|bound variable|27|ch1.tm>>
    <associate|auto-58|<tuple|binds|27|ch1.tm>>
    <associate|auto-59|<tuple|free|27|ch1.tm>>
    <associate|auto-6|<tuple|programming languages|9|ch1.tm>>
    <associate|auto-60|<tuple|scope|27|ch1.tm>>
    <associate|auto-61|<tuple|capturing|27|ch1.tm>>
    <associate|auto-62|<tuple|block structure|28|ch1.tm>>
    <associate|auto-63|<tuple|lexical scoping|28|ch1.tm>>
    <associate|auto-64|<tuple|1.2|29|ch1.tm>>
    <associate|auto-65|<tuple|local evolution|29|ch1.tm>>
    <associate|auto-66|<tuple|global|29|ch1.tm>>
    <associate|auto-67|<tuple|1.2.1|29|ch1.tm>>
    <associate|auto-68|<tuple|1.3|30|ch1.tm>>
    <associate|auto-69|<tuple|1.4|31|ch1.tm>>
    <associate|auto-7|<tuple|bugs|9|ch1.tm>>
    <associate|auto-70|<tuple|deferred operations|31|ch1.tm>>
    <associate|auto-71|<tuple|recursive process|31|ch1.tm>>
    <associate|auto-72|<tuple|linear recursive process|31|ch1.tm>>
    <associate|auto-73|<tuple|iterative process|31|ch1.tm>>
    <associate|auto-74|<tuple|state variables|31|ch1.tm>>
    <associate|auto-75|<tuple|linear iterative process|31|ch1.tm>>
    <associate|auto-76|<tuple|process|31|ch1.tm>>
    <associate|auto-77|<tuple|procedure|31|ch1.tm>>
    <associate|auto-78|<tuple|tail-recursive|32|ch1.tm>>
    <associate|auto-79|<tuple|1.2.2|33|ch1.tm>>
    <associate|auto-8|<tuple|glitches|9|ch1.tm>>
    <associate|auto-80|<tuple|tree recursion|33|ch1.tm>>
    <associate|auto-81|<tuple|1.5|33|ch1.tm>>
    <associate|auto-82|<tuple|golden ratio|34|ch1.tm>>
    <associate|auto-83|<tuple|tabulation|36|ch1.tm>>
    <associate|auto-84|<tuple|memoization|36|ch1.tm>>
    <associate|auto-85|<tuple|Pascal's triangle|36|ch1.tm>>
    <associate|auto-86|<tuple|binomial coefficients|36|ch1.tm>>
    <associate|auto-87|<tuple|1.2.3|36|ch1.tm>>
    <associate|auto-88|<tuple|order of growth|36|ch1.tm>>
    <associate|auto-89|<tuple|1.2.4|37|ch1.tm>>
    <associate|auto-9|<tuple|debug|9|ch1.tm>>
    <associate|auto-90|<tuple|invariant quantity|39|ch1.tm>>
    <associate|auto-91|<tuple|1.2.5|40|ch1.tm>>
    <associate|auto-92|<tuple|Euclid's Algorithm|40|ch1.tm>>
    <associate|auto-93|<tuple|1.2.6|41|ch1.tm>>
    <associate|auto-94|<tuple|congruent modulo|42|ch1.tm>>
    <associate|auto-95|<tuple|remainder of|42|ch1.tm>>
    <associate|auto-96|<tuple|modulo|42|ch1.tm>>
    <associate|auto-97|<tuple|Carmichael numbers|43|ch1.tm>>
    <associate|auto-98|<tuple|probabilistic algorithms|43|ch1.tm>>
    <associate|auto-99|<tuple|RSA algorithm|43|ch1.tm>>
    <associate|define_fib|<tuple|tree recursion|33|ch1.tm>>
    <associate|define_square|<tuple|procedure definitions|16|ch1.tm>>
    <associate|fig1.2|<tuple|1.2|26|ch1.tm>>
    <associate|fig1.3|<tuple|1.3|30|ch1.tm>>
    <associate|fig1.4|<tuple|1.4|31|ch1.tm>>
    <associate|fig1.5|<tuple|1.5|33|ch1.tm>>
    <associate|footnote-1.1|<tuple|1.1|10|ch1.tm>>
    <associate|footnote-1.10|<tuple|1.10|14|ch1.tm>>
    <associate|footnote-1.11|<tuple|1.11|16|ch1.tm>>
    <associate|footnote-1.12|<tuple|1.12|16|ch1.tm>>
    <associate|footnote-1.13|<tuple|1.13|17|ch1.tm>>
    <associate|footnote-1.14|<tuple|1.14|17|ch1.tm>>
    <associate|footnote-1.15|<tuple|1.15|19|ch1.tm>>
    <associate|footnote-1.16|<tuple|1.16|19|ch1.tm>>
    <associate|footnote-1.17|<tuple|1.17|20|ch1.tm>>
    <associate|footnote-1.18|<tuple|1.18|20|ch1.tm>>
    <associate|footnote-1.19|<tuple|1.19|21|ch1.tm>>
    <associate|footnote-1.2|<tuple|1.2|10|ch1.tm>>
    <associate|footnote-1.20|<tuple|1.20|23|ch1.tm>>
    <associate|footnote-1.21|<tuple|1.21|23|ch1.tm>>
    <associate|footnote-1.22|<tuple|1.22|24|ch1.tm>>
    <associate|footnote-1.23|<tuple|1.23|24|ch1.tm>>
    <associate|footnote-1.24|<tuple|1.24|25|ch1.tm>>
    <associate|footnote-1.25|<tuple|1.25|26|ch1.tm>>
    <associate|footnote-1.26|<tuple|1.26|27|ch1.tm>>
    <associate|footnote-1.27|<tuple|1.27|28|ch1.tm>>
    <associate|footnote-1.28|<tuple|1.28|29|ch1.tm>>
    <associate|footnote-1.29|<tuple|1.29|30|ch1.tm>>
    <associate|footnote-1.3|<tuple|1.3|10|ch1.tm>>
    <associate|footnote-1.30|<tuple|1.30|31|ch1.tm>>
    <associate|footnote-1.31|<tuple|1.31|32|ch1.tm>>
    <associate|footnote-1.32|<tuple|1.32|34|ch1.tm>>
    <associate|footnote-1.33|<tuple|1.33|35|ch1.tm>>
    <associate|footnote-1.34|<tuple|1.34|36|ch1.tm>>
    <associate|footnote-1.35|<tuple|1.35|36|ch1.tm>>
    <associate|footnote-1.36|<tuple|1.36|37|ch1.tm>>
    <associate|footnote-1.37|<tuple|1.37|38|ch1.tm>>
    <associate|footnote-1.38|<tuple|1.38|39|ch1.tm>>
    <associate|footnote-1.39|<tuple|1.39|39|ch1.tm>>
    <associate|footnote-1.4|<tuple|1.4|11|ch1.tm>>
    <associate|footnote-1.40|<tuple|1.40|39|ch1.tm>>
    <associate|footnote-1.41|<tuple|1.41|39|ch1.tm>>
    <associate|footnote-1.42|<tuple|1.42|40|ch1.tm>>
    <associate|footnote-1.43|<tuple|1.43|41|ch1.tm>>
    <associate|footnote-1.44|<tuple|1.44|42|ch1.tm>>
    <associate|footnote-1.45|<tuple|1.45|42|ch1.tm>>
    <associate|footnote-1.46|<tuple|1.46|42|ch1.tm>>
    <associate|footnote-1.47|<tuple|1.47|43|ch1.tm>>
    <associate|footnote-1.48|<tuple|1.48|43|ch1.tm>>
    <associate|footnote-1.49|<tuple|1.49|46|ch1.tm>>
    <associate|footnote-1.5|<tuple|1.5|11|ch1.tm>>
    <associate|footnote-1.50|<tuple|1.50|47|ch1.tm>>
    <associate|footnote-1.51|<tuple|1.51|48|ch1.tm>>
    <associate|footnote-1.52|<tuple|1.52|48|ch1.tm>>
    <associate|footnote-1.53|<tuple|1.53|50|ch1.tm>>
    <associate|footnote-1.54|<tuple|1.54|52|ch1.tm>>
    <associate|footnote-1.55|<tuple|1.55|53|ch1.tm>>
    <associate|footnote-1.56|<tuple|1.56|54|ch1.tm>>
    <associate|footnote-1.57|<tuple|1.57|55|ch1.tm>>
    <associate|footnote-1.58|<tuple|1.58|55|ch1.tm>>
    <associate|footnote-1.59|<tuple|1.59|57|ch1.tm>>
    <associate|footnote-1.6|<tuple|1.6|13|ch1.tm>>
    <associate|footnote-1.60|<tuple|1.60|57|ch1.tm>>
    <associate|footnote-1.61|<tuple|1.61|57|ch1.tm>>
    <associate|footnote-1.62|<tuple|1.62|58|ch1.tm>>
    <associate|footnote-1.63|<tuple|1.63|58|ch1.tm>>
    <associate|footnote-1.64|<tuple|1.64|59|ch1.tm>>
    <associate|footnote-1.65|<tuple|1.65|59|ch1.tm>>
    <associate|footnote-1.66|<tuple|1.66|59|ch1.tm>>
    <associate|footnote-1.7|<tuple|1.7|13|ch1.tm>>
    <associate|footnote-1.8|<tuple|1.8|13|ch1.tm>>
    <associate|footnote-1.9|<tuple|1.9|14|ch1.tm>>
    <associate|footnr-1.1|<tuple|1.1|10|ch1.tm>>
    <associate|footnr-1.10|<tuple|1.10|14|ch1.tm>>
    <associate|footnr-1.11|<tuple|syntactic sugar|16|ch1.tm>>
    <associate|footnr-1.12|<tuple|1.12|16|ch1.tm>>
    <associate|footnr-1.13|<tuple|1.13|17|ch1.tm>>
    <associate|footnr-1.14|<tuple|1.14|17|ch1.tm>>
    <associate|footnr-1.15|<tuple|substitution|19|ch1.tm>>
    <associate|footnr-1.16|<tuple|stream processing|19|ch1.tm>>
    <associate|footnr-1.17|<tuple|1.17|20|ch1.tm>>
    <associate|footnr-1.18|<tuple|1.18|20|ch1.tm>>
    <associate|footnr-1.19|<tuple|1.19|21|ch1.tm>>
    <associate|footnr-1.2|<tuple|1.2|10|ch1.tm>>
    <associate|footnr-1.20|<tuple|1.20|23|ch1.tm>>
    <associate|footnr-1.21|<tuple|1.21|23|ch1.tm>>
    <associate|footnr-1.22|<tuple|1.22|24|ch1.tm>>
    <associate|footnr-1.23|<tuple|1.23|24|ch1.tm>>
    <associate|footnr-1.24|<tuple|1.24|25|ch1.tm>>
    <associate|footnr-1.25|<tuple|1.25|26|ch1.tm>>
    <associate|footnr-1.26|<tuple|1.26|27|ch1.tm>>
    <associate|footnr-1.27|<tuple|1.27|28|ch1.tm>>
    <associate|footnr-1.28|<tuple|1.28|29|ch1.tm>>
    <associate|footnr-1.29|<tuple|1.29|30|ch1.tm>>
    <associate|footnr-1.3|<tuple|1.3|10|ch1.tm>>
    <associate|footnr-1.30|<tuple|1.30|31|ch1.tm>>
    <associate|footnr-1.31|<tuple|1.31|32|ch1.tm>>
    <associate|footnr-1.32|<tuple|1.32|34|ch1.tm>>
    <associate|footnr-1.33|<tuple|1.33|35|ch1.tm>>
    <associate|footnr-1.34|<tuple|memoization|36|ch1.tm>>
    <associate|footnr-1.35|<tuple|binomial coefficients|36|ch1.tm>>
    <associate|footnr-1.36|<tuple|1.36|37|ch1.tm>>
    <associate|footnr-1.37|<tuple|1.37|38|ch1.tm>>
    <associate|footnr-1.38|<tuple|1.38|39|ch1.tm>>
    <associate|footnr-1.39|<tuple|1.39|39|ch1.tm>>
    <associate|footnr-1.4|<tuple|real numbers|11|ch1.tm>>
    <associate|footnr-1.40|<tuple|1.40|39|ch1.tm>>
    <associate|footnr-1.41|<tuple|1.41|39|ch1.tm>>
    <associate|footnr-1.42|<tuple|1.42|40|ch1.tm>>
    <associate|footnr-1.43|<tuple|1.43|41|ch1.tm>>
    <associate|footnr-1.44|<tuple|1.44|42|ch1.tm>>
    <associate|footnr-1.45|<tuple|1.45|42|ch1.tm>>
    <associate|footnr-1.46|<tuple|1.46|42|ch1.tm>>
    <associate|footnr-1.47|<tuple|Carmichael numbers|43|ch1.tm>>
    <associate|footnr-1.48|<tuple|RSA algorithm|43|ch1.tm>>
    <associate|footnr-1.49|<tuple|1.49|46|ch1.tm>>
    <associate|footnr-1.5|<tuple|1.5|11|ch1.tm>>
    <associate|footnr-1.50|<tuple|1.50|47|ch1.tm>>
    <associate|footnr-1.51|<tuple|sequences|48|ch1.tm>>
    <associate|footnr-1.52|<tuple|1.52|48|ch1.tm>>
    <associate|footnr-1.53|<tuple|1.53|50|ch1.tm>>
    <associate|footnr-1.54|<tuple|1.54|52|ch1.tm>>
    <associate|footnr-1.55|<tuple|1.55|53|ch1.tm>>
    <associate|footnr-1.56|<tuple|1.56|54|ch1.tm>>
    <associate|footnr-1.57|<tuple|1.57|55|ch1.tm>>
    <associate|footnr-1.58|<tuple|1.58|55|ch1.tm>>
    <associate|footnr-1.59|<tuple|1.59|57|ch1.tm>>
    <associate|footnr-1.6|<tuple|1.6|13|ch1.tm>>
    <associate|footnr-1.60|<tuple|1.60|57|ch1.tm>>
    <associate|footnr-1.61|<tuple|1.61|57|ch1.tm>>
    <associate|footnr-1.62|<tuple|1.62|58|ch1.tm>>
    <associate|footnr-1.63|<tuple|1.63|58|ch1.tm>>
    <associate|footnr-1.64|<tuple|1.64|59|ch1.tm>>
    <associate|footnr-1.65|<tuple|1.65|59|ch1.tm>>
    <associate|footnr-1.66|<tuple|1.66|59|ch1.tm>>
    <associate|footnr-1.7|<tuple|1.7|13|ch1.tm>>
    <associate|footnr-1.8|<tuple|1.8|13|ch1.tm>>
    <associate|footnr-1.9|<tuple|1.9|14|ch1.tm>>
    <associate|index-invariant-quantity|<tuple|1.39|39|ch1.tm>>
    <associate|index-stack|<tuple|1.30|31|ch1.tm>>
    <associate|part:ch1.tm|<tuple|?|7>>
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
      </surround>|<pageref|auto-55>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|1.3>|>
        A linear recursive process for computing 6!.
      </surround>|<pageref|auto-68>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|1.4>|>
        A linear iterative process for computing 6!.
      </surround>|<pageref|auto-69>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|1.5>|>
        The tree-recursive process generated in computing
        <with|font-family|<quote|tt>|(fib 5)>.
      </surround>|<pageref|auto-81>>
    </associate>
    <\associate|idx>
      <tuple|<tuple|computational process>|<pageref|auto-3>>

      <tuple|<tuple|data>|<pageref|auto-4>>

      <tuple|<tuple|program>|<pageref|auto-5>>

      <tuple|<tuple|programming languages>|<pageref|auto-6>>

      <tuple|<tuple|bugs>|<pageref|auto-7>>

      <tuple|<tuple|glitches>|<pageref|auto-8>>

      <tuple|<tuple|debug>|<pageref|auto-9>>

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

      <tuple|<tuple|normal order evaluation>|<pageref|auto-43>>

      <tuple|<tuple|application-order evaluation>|<pageref|auto-44>>

      <tuple|<tuple|stream processing>|<pageref|auto-45>>

      <tuple|<tuple|case analysis>|<pageref|auto-47>>

      <tuple|<tuple|clauses>|<pageref|auto-48>>

      <tuple|<tuple|predicate>|<pageref|auto-49>>

      <tuple|<tuple|consequent expression>|<pageref|auto-50>>

      <tuple|<tuple|predicate>|<pageref|auto-51>>

      <tuple|<tuple|recursive>|<pageref|auto-54>>

      <tuple|<tuple|procedural abstraction>|<pageref|auto-56>>

      <tuple|<tuple|bound variable>|<pageref|auto-57>>

      <tuple|<tuple|binds>|<pageref|auto-58>>

      <tuple|<tuple|free>|<pageref|auto-59>>

      <tuple|<tuple|scope>|<pageref|auto-60>>

      <tuple|<tuple|capturing>|<pageref|auto-61>>

      <tuple|<tuple|block structure>|<pageref|auto-62>>

      <tuple|<tuple|lexical scoping>|<pageref|auto-63>>

      <tuple|<tuple|local evolution>|<pageref|auto-65>>

      <tuple|<tuple|global>|<pageref|auto-66>>

      <tuple|<tuple|deferred operations>|<pageref|auto-70>>

      <tuple|<tuple|recursive process>|<pageref|auto-71>>

      <tuple|<tuple|linear recursive process>|<pageref|auto-72>>

      <tuple|<tuple|iterative process>|<pageref|auto-73>>

      <tuple|<tuple|state variables>|<pageref|auto-74>>

      <tuple|<tuple|linear iterative process>|<pageref|auto-75>>

      <tuple|<tuple|process>|<pageref|auto-76>>

      <tuple|<tuple|procedure>|<pageref|auto-77>>

      <tuple|<tuple|tail-recursive>|<pageref|auto-78>>

      <tuple|<tuple|tree recursion>|<pageref|auto-80>>

      <tuple|<tuple|golden ratio>|<pageref|auto-82>>

      <tuple|<tuple|tabulation>|<pageref|auto-83>>

      <tuple|<tuple|memoization>|<pageref|auto-84>>

      <tuple|<tuple|Pascal's triangle>|<pageref|auto-85>>

      <tuple|<tuple|binomial coefficients>|<pageref|auto-86>>

      <tuple|<tuple|order of growth>|<pageref|auto-88>>

      <tuple|<tuple|invariant quantity>|<pageref|auto-90>>

      <tuple|<tuple|Euclid's Algorithm>|<pageref|auto-92>>

      <tuple|<tuple|congruent modulo>|<pageref|auto-94>>

      <tuple|<tuple|remainder of>|<pageref|auto-95>>

      <tuple|<tuple|modulo>|<pageref|auto-96>>

      <tuple|<tuple|Carmichael numbers>|<pageref|auto-97>>

      <tuple|<tuple|probabilistic algorithms>|<pageref|auto-98>>

      <tuple|<tuple|RSA algorithm>|<pageref|auto-99>>

      <tuple|<tuple|Miller-Rabin test>|<pageref|auto-100>>

      <tuple|<tuple|higher-order procedures>|<pageref|auto-102>>

      <tuple|<tuple|summation of a series>|<pageref|auto-104>>

      <tuple|<tuple|sequences>|<pageref|auto-105>>

      <tuple|<tuple|filter>|<pageref|auto-106>>

      <tuple|<tuple|half interval method>|<pageref|auto-109>>

      <tuple|<tuple|fixed point>|<pageref|auto-110>>

      <tuple|<tuple|average damping>|<pageref|auto-111>>

      <tuple|<tuple|continued fraction>|<pageref|auto-112>>

      <tuple|<tuple|k-term finite continued fraction>|<pageref|auto-113>>

      <tuple|<tuple|Newton's method>|<pageref|auto-115>>

      <tuple|<tuple|first-class>|<pageref|auto-116>>

      <tuple|<tuple|composition>|<pageref|auto-117>>

      <tuple|<tuple|smoothing>|<pageref|auto-118>>

      <tuple|<tuple|n-fold smoothed function>|<pageref|auto-119>>

      <tuple|<tuple|iterative improvement>|<pageref|auto-120>>
    </associate>
    <\associate|parts>
      <tuple|ch1.tm|chapter-nr|0|section-nr|0|subsection-nr|0>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|List
      of figures> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Building
      Abstractions with Procedures> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

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

      <with|par-left|<quote|1tab>|1.1.6<space|2spc>Conditional Expressions
      and Predicates <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-46>>

      <with|par-left|<quote|1tab>|1.1.7<space|2spc>Example: Square Roots by
      Newton's Method <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-52>>

      <with|par-left|<quote|1tab>|1.1.8<space|2spc>Procedures as Black-Box
      Abstractions <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-53>>

      1.2<space|2spc>Procedures and the Processes They Generate
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-64>

      <with|par-left|<quote|1tab>|1.2.1<space|2spc>Linear Recursion and
      Iteration <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-67>>

      <with|par-left|<quote|1tab>|1.2.2<space|2spc>Tree Recursion
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-79>>

      <with|par-left|<quote|1tab>|1.2.3<space|2spc>Orders of Growth
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-87>>

      <with|par-left|<quote|1tab>|1.2.4<space|2spc>Exponentiation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-89>>

      <with|par-left|<quote|1tab>|1.2.5<space|2spc>Greatest Common Divisors
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-91>>

      <with|par-left|<quote|1tab>|1.2.6<space|2spc>Example: Testing for
      Primality <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-93>>

      1.3<space|2spc>Formulating Abstractions with Higher-Order Procedures
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-101>

      <with|par-left|<quote|1tab>|1.3.1<space|2spc>Procedures as Arguments
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-103>>

      <with|par-left|<quote|1tab>|1.3.2<space|2spc>Constructing Procedures
      Using <with|font-family|<quote|tt>|Lambda>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-107>>

      <with|par-left|<quote|1tab>|1.3.3<space|2spc>Procedures as General
      Methods <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-108>>

      <with|par-left|<quote|1tab>|1.3.4<space|2spc>Procedures as Returned
      Values <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-114>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Index>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-121><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>