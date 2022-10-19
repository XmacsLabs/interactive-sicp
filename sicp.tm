<TeXmacs|2.1.3>

<style|<tuple|book|old-dots|old-lengths|comment|maxima>>

<\body>
  <\hide-preamble>
    <assign|paragraph-toc|<macro|name|>>
  </hide-preamble>

  <doc-data|<doc-title|Structure and Interpretation of Computer
  Programs>|<doc-author|<author-data|<author-name|Harold
  Abelson>>>|<doc-author|<author-data|<author-name|Gerald Jay
  Sussman>>>|<doc-author|<author-data|<author-name|Julie Sussman>>>>

  <\table-of-contents|toc>
    <vspace*|1fn><with|font-series|bold|math-font-series|bold|1<space|2spc>Building
    Abstractions with Procedures> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-1><vspace|0.5fn>

    1.1<space|2spc>The Elements of Programming
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-12>

    <with|par-left|1tab|1.1.1<space|2spc>Expressions
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-15>>

    <with|par-left|1tab|1.1.2<space|2spc>Naming and the Environment
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-25>>

    <with|par-left|1tab|1.1.3<space|2spc>Evaluating Combinations
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-30>>

    <with|par-left|1tab|1.1.4<space|2spc>Compound Procedures
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-36>>

    <with|par-left|1tab|1.1.5<space|2spc>The Substitution Model for Procedure
    Application <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-39>>

    <with|par-left|1tab|1.1.6<space|2spc>Conditional Expressions and
    Predicates <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-45>>

    <with|par-left|1tab|1.1.7<space|2spc>Example: Square Roots by Newton's
    Method <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-51>>

    <with|par-left|1tab|1.1.8<space|2spc>Procedures as Black-Box Abstractions
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-52>>

    1.2<space|2spc>Procedures and the Processes They Generate
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-63>

    <with|par-left|1tab|1.2.1<space|2spc>Linear Recursion and Iteration
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-66>>

    <with|par-left|1tab|1.2.2<space|2spc>Tree Recursion
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-78>>

    <with|par-left|1tab|1.2.3<space|2spc>Orders of Growth
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-86>>

    <with|par-left|1tab|1.2.4<space|2spc>Exponentiation
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-88>>

    <with|par-left|1tab|1.2.5<space|2spc>Greatest Common Divisors
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-90>>

    <with|par-left|1tab|1.2.6<space|2spc>Example: Testing for Primality
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-92>>

    1.3<space|2spc>Formulating Abstractions with Higher-Order Procedures
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-100>

    <with|par-left|1tab|1.3.1<space|2spc>Procedures as Arguments
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-102>>

    <with|par-left|1tab|1.3.2<space|2spc>Constructing Procedures Using
    <with|font-family|tt|Lambda> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-106>>

    <with|par-left|1tab|1.3.3<space|2spc>Procedures as General Methods
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-107>>

    <with|par-left|1tab|1.3.4<space|2spc>Procedures as Returned Values
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-113>>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|2<space|2spc>Building
    Abstractions with Data> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-120><vspace|0.5fn>

    2.1<space|2spc>Introduction to Data Abstraction
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-121>

    <with|par-left|1tab|2.1.1<space|2spc>Example: Arithmetic Operations for
    Rational Numbers <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-125>>

    <with|par-left|1tab|2.1.2<space|2spc>Abstraction Barriers
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-130>>

    <with|par-left|1tab|2.1.3<space|2spc>What Is Meant by Data?
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-133>>

    <with|par-left|1tab|2.1.4<space|2spc>Extended Exercise: Interval
    Arithmetic <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-139>>

    2.2<space|2spc>Hierarchical Data and the Closure Property
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-141>

    <with|par-left|1tab|2.2.1<space|2spc>Representing Sequences
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-148>>

    <with|par-left|1tab|2.2.2<space|2spc>Hierarchical Structures
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-158>>

    <with|par-left|1tab|2.2.3<space|2spc>Sequences as Conventional Interfaces
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-163>>

    <with|par-left|1tab|2.2.4<space|2spc>Example: A Picture Language
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-173>>

    2.3<space|2spc>Symbolic Data <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-185>

    <with|par-left|1tab|2.3.1<space|2spc>Quotation
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-186>>

    <with|par-left|1tab|2.3.2<space|2spc>Example: Symbolic Differentiation
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-188>>

    <with|par-left|1tab|2.3.3<space|2spc>Example: Representing Sets
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-189>>

    <with|par-left|1tab|2.3.4<space|2spc>Example: Huffman Encoding Trees
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-195>>

    2.4<space|2spc>Multiple Representations for Abstract Data
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-203>

    <with|par-left|1tab|2.4.1<space|2spc>Representations for Complex Numbers
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-209>>

    <with|par-left|1tab|2.4.2<space|2spc>Tagged data
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-211>>

    <with|par-left|1tab|2.4.3<space|2spc>Data-Directed Programming and
    Additivity <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-214>>

    2.5<space|2spc>Systems with Generic Operations
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-221>

    <with|par-left|1tab|2.5.1<space|2spc>Generic Arithmetic Operations
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-223>>

    <with|par-left|1tab|2.5.2<space|2spc>Combining Data of Different Types
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-226>>

    <with|par-left|1tab|2.5.3<space|2spc>Example: Symbolic Algebra
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-235>>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|3<space|2spc>Modularity,
    Objects and State> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-243><vspace|0.5fn>

    3.1<space|2spc>Assignment and Local State
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-249>

    <with|par-left|1tab|3.1.1<space|2spc>Local State Variables
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-253>>

    <with|par-left|1tab|3.1.2<space|2spc>The Benefits of Introducing
    Assignment <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-257>>

    <with|par-left|1tab|3.1.3<space|2spc>The Cost of Introducing Assignment
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-261>>

    <with|par-left|2tab|Sameness and Change
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-263>>

    <with|par-left|2tab|Pitfalls of imperactive programming
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-267>>

    3.2<space|2spc>The Environment Model of Evaluation
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-269>

    <with|par-left|1tab|3.2.1<space|2spc>The Rules for Evaluation
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-278>>

    <with|par-left|1tab|3.2.2<space|2spc>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-279>>

    3.3<space|2spc> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-280>

    <with|par-left|1tab|3.3.1<space|2spc>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-281>>

    <with|par-left|1tab|3.3.2<space|2spc>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-282>>

    <with|par-left|1tab|3.3.3<space|2spc>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-283>>

    <with|par-left|1tab|3.3.4<space|2spc>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-284>>

    <with|par-left|1tab|3.3.5<space|2spc>Propagation of Constraints
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-285>>

    <with|par-left|2tab|Using the constraint system
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-290>>

    <with|par-left|2tab|Implementing the constraint system
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-291>>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|Index>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-292><vspace|0.5fn>
  </table-of-contents>

  <include|ch1.tm>

  <include|ch2.tm>

  <include|ch3.tm>

  <\the-index|idx>
    <index+1|abstract models|<pageref|auto-135>>

    <index+1|abstraction barriers|<pageref|auto-131>>

    <index+1|accumulator|<pageref|auto-168>, <pageref|auto-256>>

    <index+1|additive|<pageref|auto-216>>

    <index+1|additively|<pageref|auto-204>>

    <index+1|algebraic specification|<pageref|auto-136>>

    <index+1|aliasing|<pageref|auto-265>>

    <index+1|application-order evaluation|<pageref|auto-43>>

    <index+1|arguments|<pageref|auto-21>>

    <index+1|assignment operator|<pageref|auto-252>>

    <index+1|average damping|<pageref|auto-110>>

    <index+1|balanced|<pageref|auto-162>>

    <index+1|bindings|<pageref|auto-272>>

    <index+1|binds|<pageref|auto-57>>

    <index+1|binomial coefficients|<pageref|auto-85>>

    <index+1|block structure|<pageref|auto-61>>

    <index+1|bound variable|<pageref|auto-56>>

    <index+1|box-and-pointer notation|<pageref|auto-142>>

    <index+1|B-trees|<pageref|auto-191>>

    <index+1|bugs|<pageref|auto-6>>

    <index+1|capturing|<pageref|auto-60>>

    <index+1|Carmichael numbers|<pageref|auto-96>>

    <index+1|case analysis|<pageref|auto-46>>

    <index+1|Church numerals|<pageref|auto-138>>

    <index+1|clauses|<pageref|auto-47>>

    <index+1|closure property|<pageref|auto-146>>

    <index+1|coerce|<pageref|auto-234>>

    <index+1|coercion|<pageref|auto-227>>

    <index+1|combinations|<pageref|auto-18>>

    <index+1|comments|<pageref|auto-171>>

    <index+1|composition|<pageref|auto-116>>

    <index+1|compound procedure|<pageref|auto-38>>

    <index+1|computational process|<pageref|auto-2>>

    <index+1|congruent modulo|<pageref|auto-93>>

    <index+1|connectors|<pageref|auto-288>>

    <index+1|consequent expression|<pageref|auto-49>>

    <index+1|constraint networks|<pageref|auto-287>>

    <index+1|constructors|<pageref|auto-124>>

    <index+1|continued fraction|<pageref|auto-111>>

    <index+1|conventional interfaces|<pageref|auto-164>>

    <index+1|data|<pageref|auto-3>, <pageref|auto-134>>

    <index+1|data abstraction|<pageref|auto-122>>

    <index+1|data directed programming|<pageref|auto-217>>

    <index+1|data-directed|<pageref|auto-207>>

    <index+1|debug|<pageref|auto-8>>

    <index+1|deferred operations|<pageref|auto-69>>

    <index+1|delayed evaluation|<pageref|auto-248>>

    <index+1|dense|<pageref|auto-239>>

    <index+1|dispatching on type|<pageref|auto-215>>

    <index+1|dotted-tail notation|<pageref|auto-156>>

    <index+1|empty list|<pageref|auto-154>>

    <index+1|encapsulated|<pageref|auto-254>>

    <index+1|enclosing environment|<pageref|auto-273>>

    <index+1|enumerator|<pageref|auto-165>>

    <index+1|environment|<pageref|auto-28>>

    <index+1|environment model|<pageref|auto-247>>

    <index+1|environments|<pageref|auto-270>>

    <index+1|Euclid's Algorithm|<pageref|auto-91>>

    <index+1|evaluating|<pageref|auto-17>>

    <index+1|expression|<pageref|auto-16>>

    <index+1|filter|<pageref|auto-105>, <pageref|auto-166>>

    <index+1|first-class|<pageref|auto-115>>

    <index+1|fixed point|<pageref|auto-109>>

    <index+1|fixed-length|<pageref|auto-196>>

    <index+1|frame coordinate map|<pageref|auto-182>>

    <index+1|frames|<pageref|auto-271>>

    <index+1|free|<pageref|auto-58>>

    <index+1|functional programming|<pageref|auto-262>>

    <index+1|generic procedures|<pageref|auto-202>, <pageref|auto-205>>

    <index+1|glitches|<pageref|auto-7>>

    <index+1|global|<pageref|auto-65>, <pageref|auto-274>>

    <index+1|global environment|<pageref|auto-29>>

    <index+1|golden ratio|<pageref|auto-81>>

    <index+1|half interval method|<pageref|auto-108>>

    <index+1|hiding principle|<pageref|auto-255>>

    <index+1|hierarchical|<pageref|auto-147>>

    <index+1|hierarchy of types|<pageref|auto-228>>

    <index+1|higher-order procedures|<pageref|auto-101>>

    <index+1|Horner's rule|<pageref|auto-170>>

    <index+1|imperative programming|<pageref|auto-268>>

    <index+1|indeterminates|<pageref|auto-236>>

    <index+1|integers|<pageref|auto-13>>

    <index+1|interpreter|<pageref|auto-10>>

    <index+1|invariant quantity|<pageref|auto-89>>

    <index+1|iterative improvement|<pageref|auto-119>>

    <index+1|iterative process|<pageref|auto-72>>

    <index+1|key|<pageref|auto-194>>

    <index+1|k-term finite continued fraction|<pageref|auto-112>>

    <index+1|lexical scoping|<pageref|auto-62>>

    <index+1|linear iterative process|<pageref|auto-74>>

    <index+1|linear recursive process|<pageref|auto-71>>

    <index+1|list|<pageref|auto-151>, <pageref|auto-152>, <pageref|auto-157>>

    <index+1|list structure|<pageref|auto-153>>

    <index+1|list-structured|<pageref|auto-129>>

    <index+1|local evolution|<pageref|auto-64>>

    <index+1|local state variable|<pageref|auto-251>>

    <index+1|map|<pageref|auto-167>>

    <index+1|memoization|<pageref|auto-83>>

    <index+1|message passing|<pageref|auto-137>, <pageref|auto-220>>

    <index+1|Miller-Rabin test|<pageref|auto-99>>

    <index+1|modular|<pageref|auto-244>>

    <index+1|modulo|<pageref|auto-95>>

    <index+1|Monte Carlo integration|<pageref|auto-260>>

    <index+1|Monte Carlo simulation|<pageref|auto-259>>

    <index+1|Newton's method|<pageref|auto-114>>

    <index+1|n-fold smoothed function|<pageref|auto-118>>

    <index+1|nil|<pageref|auto-155>>

    <index+1|normal order evaluation|<pageref|auto-42>>

    <index+1|object|<pageref|auto-245>>

    <index+1|operands|<pageref|auto-20>>

    <index+1|operator|<pageref|auto-19>>

    <index+1|order of growth|<pageref|auto-87>>

    <index+1|ordinary|<pageref|auto-224>>

    <index+1|package|<pageref|auto-219>>

    <index+1|painter|<pageref|auto-175>>

    <index+1|pair|<pageref|auto-127>, <pageref|auto-128>>

    <index+1|Pascal's triangle|<pageref|auto-84>>

    <index+1|pointer|<pageref|auto-143>>

    <index+1|poly|<pageref|auto-238>>

    <index+1|predicate|<pageref|auto-48>, <pageref|auto-50>>

    <index+1|prefix|<pageref|auto-199>>

    <index+1|prefix code|<pageref|auto-200>>

    <index+1|prefix notation|<pageref|auto-22>>

    <index+1|pretty-printing|<pageref|auto-23>>

    <index+1|primitive cnstraints|<pageref|auto-286>>

    <index+1|probabilistic algorithms|<pageref|auto-97>>

    <index+1|procedural abstraction|<pageref|auto-55>>

    <index+1|procedure|<pageref|auto-76>>

    <index+1|procedure definitions|<pageref|auto-37>>

    <index+1|procedures|<pageref|auto-11>>

    <index+1|process|<pageref|auto-75>>

    <index+1|program|<pageref|auto-4>>

    <index+1|programming languages|<pageref|auto-5>>

    <index+1|pseudodivision|<pageref|auto-241>>

    <index+1|pseudo-random|<pageref|auto-258>>

    <index+1|pseudoremainder|<pageref|auto-242>>

    <index+1|read-eval-print loop|<pageref|auto-24>>

    <index+1|real numbers|<pageref|auto-14>>

    <index+1|recursive|<pageref|auto-31>, <pageref|auto-53>>

    <index+1|recursive process|<pageref|auto-70>>

    <index+1|recusion equations|<pageref|auto-9>>

    <index+1|red-black trees|<pageref|auto-192>>

    <index+1|referentially transparent|<pageref|auto-264>>

    <index+1|remainder of|<pageref|auto-94>>

    <index+1|robust|<pageref|auto-184>>

    <index+1|RSA algorithm|<pageref|auto-98>>

    <index+1|scope|<pageref|auto-59>>

    <index+1|selectors|<pageref|auto-123>>

    <index+1|separator code|<pageref|auto-198>>

    <index+1|sequence|<pageref|auto-150>>

    <index+1|sequences|<pageref|auto-104>>

    <index+1|side-effect bugs|<pageref|auto-266>>

    <index+1|smoothing|<pageref|auto-117>>

    <index+1|sparse|<pageref|auto-240>>

    <index+1|special forms|<pageref|auto-34>>

    <index+1|state variable|<pageref|auto-250>>

    <index+1|state variables|<pageref|auto-73>>

    <index+1|stratified design|<pageref|auto-183>>

    <index+1|stream|<pageref|auto-246>>

    <index+1|stream processing|<pageref|auto-44>>

    <index+1|substitution|<pageref|auto-41>>

    <index+1|substitution model|<pageref|auto-40>>

    <index+1|subtype|<pageref|auto-229>>

    <index+1|summation of a series|<pageref|auto-103>>

    <index+1|supertype|<pageref|auto-230>>

    <index+1|syntactic sugar|<pageref|auto-35>>

    <index+1|tabulation|<pageref|auto-82>>

    <index+1|tail-recursive|<pageref|auto-77>>

    <index+1|tower|<pageref|auto-231>>

    <index+1|tree accumulation|<pageref|auto-32>>

    <index+1|tree recursion|<pageref|auto-79>>

    <index+1|trees|<pageref|auto-160>>

    <index+1|type tag|<pageref|auto-212>>

    <index+1|type tags|<pageref|auto-206>>

    <index+1|unbound|<pageref|auto-276>>

    <index+1|univariate polynomials|<pageref|auto-237>>

    <index+1|value|<pageref|auto-27>>

    <index+1|value of a variable|<pageref|auto-275>>

    <index+1|values|<pageref|auto-187>>

    <index+1|variable|<pageref|auto-26>>

    <index+1|variable-length|<pageref|auto-197>>

    <index+1|width|<pageref|auto-140>>

    <index+1|wishful thinking|<pageref|auto-126>>
  </the-index>
</body>

<\initial>
  <\collection>
    <associate|global-title|sicp.tm>
    <associate|info-flag|minimal>
    <associate|page-medium|paper>
    <associate|par-first|0tab>
    <associate|par-par-sep|1fn>
    <associate|preamble|false>
    <associate|project-flag|true>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|#1.2.6|<tuple|1.2.6|39|ch1.tm>>
    <associate|%_idx_102|<tuple|1.3|8|ch1.tm>>
    <associate|%_idx_104|<tuple|1.3|8|ch1.tm>>
    <associate|%_idx_106|<tuple|1.3|8|ch1.tm>>
    <associate|%_idx_32|<tuple|interpreter|8|ch1.tm>>
    <associate|%_idx_34|<tuple|interpreter|8|ch1.tm>>
    <associate|%_idx_36|<tuple|1.1|8|ch1.tm>>
    <associate|%_idx_46|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_48|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_50|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_52|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_54|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_56|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_58|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_60|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_62|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_64|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_66|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_68|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_70|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_72|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_74|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_76|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_78|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_80|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_82|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_84|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_86|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_88|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_90|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_92|<tuple|1.2|8|ch1.tm>>
    <associate|%_idx_94|<tuple|1.2|8|ch1.tm>>
    <associate|1.1|<tuple|1.1|9|ch1.tm>>
    <associate|1.1.3|<tuple|1.1.3|12|ch1.tm>>
    <associate|1.1.4|<tuple|1.1.4|14|ch1.tm>>
    <associate|1.1.7|<tuple|1.1.7|21|ch1.tm>>
    <associate|1.1.8|<tuple|1.1.8|24|ch1.tm>>
    <associate|1.2.1|<tuple|1.2.1|27|ch1.tm>>
    <associate|1.2.2|<tuple|1.2.2|31|ch1.tm>>
    <associate|1.2.4|<tuple|1.2.4|35|ch1.tm>>
    <associate|1.3|<tuple|1.3|43|ch1.tm>>
    <associate|1.3.1|<tuple|1.3.1|44|ch1.tm>>
    <associate|1.3.3|<tuple|1.3.3|51|ch1.tm>>
    <associate|2.2.1|<tuple|2.2.1|71|ch2.tm>>
    <associate|2.2.2|<tuple|2.2.2|77|ch2.tm>>
    <associate|2.2.3|<tuple|2.2.3|81|ch2.tm>>
    <associate|2.3.2|<tuple|2.3.2|103|ch2.tm>>
    <associate|DOCF58|<tuple|1.57|53|ch1.tm>>
    <associate|Exercise-1_002e10|<tuple|1.31|30|ch1.tm>>
    <associate|Exercise-1_002e11|<tuple|memoization|34|ch1.tm>>
    <associate|Exercise-1_002e12|<tuple|memoization|34|ch1.tm>>
    <associate|Exercise-1_002e13|<tuple|binomial coefficients|34|ch1.tm>>
    <associate|Exercise-1_002e14|<tuple|1.36|35|ch1.tm>>
    <associate|Exercise-1_002e15|<tuple|1.36|35|ch1.tm>>
    <associate|Exercise-1_002e16|<tuple|1.39|37|ch1.tm>>
    <associate|Exercise-1_002e17|<tuple|invariant quantity|37|ch1.tm>>
    <associate|Exercise-1_002e18|<tuple|invariant quantity|37|ch1.tm>>
    <associate|Exercise-1_002e19|<tuple|1.40|37|ch1.tm>>
    <associate|Exercise-1_002e20|<tuple|1.43|39|ch1.tm>>
    <associate|Exercise-1_002e21|<tuple|RSA algorithm|42|ch1.tm>>
    <associate|Exercise-1_002e22|<tuple|RSA algorithm|42|ch1.tm>>
    <associate|Exercise-1_002e23|<tuple|RSA algorithm|42|ch1.tm>>
    <associate|Exercise-1_002e24|<tuple|RSA algorithm|42|ch1.tm>>
    <associate|Exercise-1_002e25|<tuple|RSA algorithm|43|ch1.tm>>
    <associate|Exercise-1_002e26|<tuple|RSA algorithm|43|ch1.tm>>
    <associate|Exercise-1_002e27|<tuple|RSA algorithm|43|ch1.tm>>
    <associate|Exercise-1_002e28|<tuple|RSA algorithm|43|ch1.tm>>
    <associate|Exercise-1_002e29|<tuple|1.50|46|ch1.tm>>
    <associate|Exercise-1_002e30|<tuple|1.50|46|ch1.tm>>
    <associate|Exercise-1_002e31|<tuple|1.50|47|ch1.tm>>
    <associate|Exercise-1_002e32|<tuple|b|47|ch1.tm>>
    <associate|Exercise-1_002e33|<tuple|b|47|ch1.tm>>
    <associate|Exercise-1_002e34|<tuple|1.54|51|ch1.tm>>
    <associate|Exercise-1_002e35|<tuple|average damping|54|ch1.tm>>
    <associate|Exercise-1_002e36|<tuple|average damping|54|ch1.tm>>
    <associate|Exercise-1_002e37|<tuple|average damping|54|ch1.tm>>
    <associate|Exercise-1_002e38|<tuple|2|55|ch1.tm>>
    <associate|Exercise-1_002e39|<tuple|2|55|ch1.tm>>
    <associate|Exercise-1_002e40|<tuple|1.66|58|ch1.tm>>
    <associate|Exercise-1_002e41|<tuple|1.66|58|ch1.tm>>
    <associate|Exercise-1_002e42|<tuple|1.66|58|ch1.tm>>
    <associate|Exercise-1_002e43|<tuple|composition|59|ch1.tm>>
    <associate|Exercise-1_002e44|<tuple|composition|59|ch1.tm>>
    <associate|Exercise-1_002e45|<tuple|n-fold smoothed function|59|ch1.tm>>
    <associate|Exercise-1_002e46|<tuple|n-fold smoothed function|59|ch1.tm>>
    <associate|Exercise-1_002e9|<tuple|1.31|30|ch1.tm>>
    <associate|Figure1.1|<tuple|1.1|13|ch1.tm>>
    <associate|auto-1|<tuple|1|7|ch1.tm>>
    <associate|auto-10|<tuple|interpreter|8|ch1.tm>>
    <associate|auto-100|<tuple|1.3|43|ch1.tm>>
    <associate|auto-101|<tuple|higher-order procedures|44|ch1.tm>>
    <associate|auto-102|<tuple|1.3.1|44|ch1.tm>>
    <associate|auto-103|<tuple|summation of a series|45|ch1.tm>>
    <associate|auto-104|<tuple|sequences|47|ch1.tm>>
    <associate|auto-105|<tuple|filter|47|ch1.tm>>
    <associate|auto-106|<tuple|1.3.2|48|ch1.tm>>
    <associate|auto-107|<tuple|1.3.3|51|ch1.tm>>
    <associate|auto-108|<tuple|half interval method|51|ch1.tm>>
    <associate|auto-109|<tuple|fixed point|53|ch1.tm>>
    <associate|auto-11|<tuple|procedures|8|ch1.tm>>
    <associate|auto-110|<tuple|average damping|54|ch1.tm>>
    <associate|auto-111|<tuple|continued fraction|54|ch1.tm>>
    <associate|auto-112|<tuple|k-term finite continued fraction|54|ch1.tm>>
    <associate|auto-113|<tuple|1.3.4|55|ch1.tm>>
    <associate|auto-114|<tuple|Newton's method|56|ch1.tm>>
    <associate|auto-115|<tuple|first-class|58|ch1.tm>>
    <associate|auto-116|<tuple|composition|58|ch1.tm>>
    <associate|auto-117|<tuple|smoothing|59|ch1.tm>>
    <associate|auto-118|<tuple|n-fold smoothed function|59|ch1.tm>>
    <associate|auto-119|<tuple|iterative improvement|59|ch1.tm>>
    <associate|auto-12|<tuple|1.1|9|ch1.tm>>
    <associate|auto-120|<tuple|2|61|ch2.tm>>
    <associate|auto-121|<tuple|2.1|61|ch2.tm>>
    <associate|auto-122|<tuple|data abstraction|61|ch2.tm>>
    <associate|auto-123|<tuple|selectors|61|ch2.tm>>
    <associate|auto-124|<tuple|constructors|61|ch2.tm>>
    <associate|auto-125|<tuple|2.1.1|61|ch2.tm>>
    <associate|auto-126|<tuple|wishful thinking|62|ch2.tm>>
    <associate|auto-127|<tuple|pair|62|ch2.tm>>
    <associate|auto-128|<tuple|pair|63|ch2.tm>>
    <associate|auto-129|<tuple|list-structured|63|ch2.tm>>
    <associate|auto-13|<tuple|integers|9|ch1.tm>>
    <associate|auto-130|<tuple|2.1.2|64|ch2.tm>>
    <associate|auto-131|<tuple|abstraction barriers|64|ch2.tm>>
    <associate|auto-132|<tuple|2.1|65|ch2.tm>>
    <associate|auto-133|<tuple|2.1.3|66|ch2.tm>>
    <associate|auto-134|<tuple|data|66|ch2.tm>>
    <associate|auto-135|<tuple|abstract models|66|ch2.tm>>
    <associate|auto-136|<tuple|algebraic specification|66|ch2.tm>>
    <associate|auto-137|<tuple|message passing|67|ch2.tm>>
    <associate|auto-138|<tuple|Church numerals|67|ch2.tm>>
    <associate|auto-139|<tuple|2.1.4|68|ch2.tm>>
    <associate|auto-14|<tuple|real numbers|9|ch1.tm>>
    <associate|auto-140|<tuple|width|69|ch2.tm>>
    <associate|auto-141|<tuple|2.2|70|ch2.tm>>
    <associate|auto-142|<tuple|box-and-pointer notation|70|ch2.tm>>
    <associate|auto-143|<tuple|pointer|70|ch2.tm>>
    <associate|auto-144|<tuple|2.2|70|ch2.tm>>
    <associate|auto-145|<tuple|2.3|70|ch2.tm>>
    <associate|auto-146|<tuple|closure property|71|ch2.tm>>
    <associate|auto-147|<tuple|hierarchical|71|ch2.tm>>
    <associate|auto-148|<tuple|2.2.1|71|ch2.tm>>
    <associate|auto-149|<tuple|2.4|71|ch2.tm>>
    <associate|auto-15|<tuple|1.1.1|9|ch1.tm>>
    <associate|auto-150|<tuple|sequence|71|ch2.tm>>
    <associate|auto-151|<tuple|list|71|ch2.tm>>
    <associate|auto-152|<tuple|list|71|ch2.tm>>
    <associate|auto-153|<tuple|list structure|71|ch2.tm>>
    <associate|auto-154|<tuple|empty list|72|ch2.tm>>
    <associate|auto-155|<tuple|nil|72|ch2.tm>>
    <associate|auto-156|<tuple|dotted-tail notation|74|ch2.tm>>
    <associate|auto-157|<tuple|list|74|ch2.tm>>
    <associate|auto-158|<tuple|2.2.2|77|ch2.tm>>
    <associate|auto-159|<tuple|2.5|77|ch2.tm>>
    <associate|auto-16|<tuple|expression|9|ch1.tm>>
    <associate|auto-160|<tuple|trees|77|ch2.tm>>
    <associate|auto-161|<tuple|2.6|78|ch2.tm>>
    <associate|auto-162|<tuple|balanced|80|ch2.tm>>
    <associate|auto-163|<tuple|2.2.3|81|ch2.tm>>
    <associate|auto-164|<tuple|conventional interfaces|81|ch2.tm>>
    <associate|auto-165|<tuple|enumerator|82|ch2.tm>>
    <associate|auto-166|<tuple|filter|82|ch2.tm>>
    <associate|auto-167|<tuple|map|82|ch2.tm>>
    <associate|auto-168|<tuple|accumulator|82|ch2.tm>>
    <associate|auto-169|<tuple|2.7|82|ch2.tm>>
    <associate|auto-17|<tuple|evaluating|9|ch1.tm>>
    <associate|auto-170|<tuple|Horner's rule|85|ch2.tm>>
    <associate|auto-171|<tuple|comments|88|ch2.tm>>
    <associate|auto-172|<tuple|2.8|89|ch2.tm>>
    <associate|auto-173|<tuple|2.2.4|90|ch2.tm>>
    <associate|auto-174|<tuple|2.9|90|ch2.tm>>
    <associate|auto-175|<tuple|painter|90|ch2.tm>>
    <associate|auto-176|<tuple|2.10|91|ch2.tm>>
    <associate|auto-177|<tuple|2.11|92|ch2.tm>>
    <associate|auto-178|<tuple|2.12|92|ch2.tm>>
    <associate|auto-179|<tuple|2.13|93|ch2.tm>>
    <associate|auto-18|<tuple|combinations|10|ch1.tm>>
    <associate|auto-180|<tuple|2.14|94|ch2.tm>>
    <associate|auto-181|<tuple|2.15|95|ch2.tm>>
    <associate|auto-182|<tuple|frame coordinate map|95|ch2.tm>>
    <associate|auto-183|<tuple|stratified design|99|ch2.tm>>
    <associate|auto-184|<tuple|robust|99|ch2.tm>>
    <associate|auto-185|<tuple|2.3|100|ch2.tm>>
    <associate|auto-186|<tuple|2.3.1|100|ch2.tm>>
    <associate|auto-187|<tuple|values|100|ch2.tm>>
    <associate|auto-188|<tuple|2.3.2|103|ch2.tm>>
    <associate|auto-189|<tuple|2.3.3|107|ch2.tm>>
    <associate|auto-19|<tuple|operator|10|ch1.tm>>
    <associate|auto-190|<tuple|2.16|110|ch2.tm>>
    <associate|auto-191|<tuple|B-trees|111|ch2.tm>>
    <associate|auto-192|<tuple|red-black trees|111|ch2.tm>>
    <associate|auto-193|<tuple|2.17|111|ch2.tm>>
    <associate|auto-194|<tuple|key|112|ch2.tm>>
    <associate|auto-195|<tuple|2.3.4|113|ch2.tm>>
    <associate|auto-196|<tuple|fixed-length|113|ch2.tm>>
    <associate|auto-197|<tuple|variable-length|113|ch2.tm>>
    <associate|auto-198|<tuple|separator code|114|ch2.tm>>
    <associate|auto-199|<tuple|prefix|114|ch2.tm>>
    <associate|auto-2|<tuple|computational process|7|ch1.tm>>
    <associate|auto-20|<tuple|operands|10|ch1.tm>>
    <associate|auto-200|<tuple|prefix code|114|ch2.tm>>
    <associate|auto-201|<tuple|2.18|114|ch2.tm>>
    <associate|auto-202|<tuple|generic procedures|116|ch2.tm>>
    <associate|auto-203|<tuple|2.4|119|ch2.tm>>
    <associate|auto-204|<tuple|additively|119|ch2.tm>>
    <associate|auto-205|<tuple|generic procedures|120|ch2.tm>>
    <associate|auto-206|<tuple|type tags|120|ch2.tm>>
    <associate|auto-207|<tuple|data-directed|120|ch2.tm>>
    <associate|auto-208|<tuple|2.19|120|ch2.tm>>
    <associate|auto-209|<tuple|2.4.1|120|ch2.tm>>
    <associate|auto-21|<tuple|arguments|10|ch1.tm>>
    <associate|auto-210|<tuple|2.20|121|ch2.tm>>
    <associate|auto-211|<tuple|2.4.2|123|ch2.tm>>
    <associate|auto-212|<tuple|type tag|123|ch2.tm>>
    <associate|auto-213|<tuple|2.21|125|ch2.tm>>
    <associate|auto-214|<tuple|2.4.3|125|ch2.tm>>
    <associate|auto-215|<tuple|dispatching on type|125|ch2.tm>>
    <associate|auto-216|<tuple|additive|126|ch2.tm>>
    <associate|auto-217|<tuple|data directed programming|126|ch2.tm>>
    <associate|auto-218|<tuple|2.22|126|ch2.tm>>
    <associate|auto-219|<tuple|package|127|ch2.tm>>
    <associate|auto-22|<tuple|prefix notation|10|ch1.tm>>
    <associate|auto-220|<tuple|message passing|130|ch2.tm>>
    <associate|auto-221|<tuple|2.5|131|ch2.tm>>
    <associate|auto-222|<tuple|2.23|131|ch2.tm>>
    <associate|auto-223|<tuple|2.5.1|131|ch2.tm>>
    <associate|auto-224|<tuple|ordinary|132|ch2.tm>>
    <associate|auto-225|<tuple|2.24|134|ch2.tm>>
    <associate|auto-226|<tuple|2.5.2|135|ch2.tm>>
    <associate|auto-227|<tuple|coercion|136|ch2.tm>>
    <associate|auto-228|<tuple|hierarchy of types|137|ch2.tm>>
    <associate|auto-229|<tuple|subtype|137|ch2.tm>>
    <associate|auto-23|<tuple|pretty-printing|11|ch1.tm>>
    <associate|auto-230|<tuple|supertype|137|ch2.tm>>
    <associate|auto-231|<tuple|tower|137|ch2.tm>>
    <associate|auto-232|<tuple|2.25|137|ch2.tm>>
    <associate|auto-233|<tuple|2.26|139|ch2.tm>>
    <associate|auto-234|<tuple|coerce|139|ch2.tm>>
    <associate|auto-235|<tuple|2.5.3|140|ch2.tm>>
    <associate|auto-236|<tuple|indeterminates|140|ch2.tm>>
    <associate|auto-237|<tuple|univariate polynomials|140|ch2.tm>>
    <associate|auto-238|<tuple|poly|141|ch2.tm>>
    <associate|auto-239|<tuple|dense|143|ch2.tm>>
    <associate|auto-24|<tuple|read-eval-print loop|11|ch1.tm>>
    <associate|auto-240|<tuple|sparse|143|ch2.tm>>
    <associate|auto-241|<tuple|pseudodivision|147|ch2.tm>>
    <associate|auto-242|<tuple|pseudoremainder|147|ch2.tm>>
    <associate|auto-243|<tuple|3|149|ch3.tm>>
    <associate|auto-244|<tuple|modular|149|ch3.tm>>
    <associate|auto-245|<tuple|object|149|ch3.tm>>
    <associate|auto-246|<tuple|stream|149|ch3.tm>>
    <associate|auto-247|<tuple|environment model|149|ch3.tm>>
    <associate|auto-248|<tuple|delayed evaluation|149|ch3.tm>>
    <associate|auto-249|<tuple|3.1|149|ch3.tm>>
    <associate|auto-25|<tuple|1.1.2|11|ch1.tm>>
    <associate|auto-250|<tuple|state variable|149|ch3.tm>>
    <associate|auto-251|<tuple|local state variable|150|ch3.tm>>
    <associate|auto-252|<tuple|assignment operator|150|ch3.tm>>
    <associate|auto-253|<tuple|3.1.1|150|ch3.tm>>
    <associate|auto-254|<tuple|encapsulated|152|ch3.tm>>
    <associate|auto-255|<tuple|hiding principle|152|ch3.tm>>
    <associate|auto-256|<tuple|accumulator|154|ch3.tm>>
    <associate|auto-257|<tuple|3.1.2|154|ch3.tm>>
    <associate|auto-258|<tuple|pseudo-random|155|ch3.tm>>
    <associate|auto-259|<tuple|Monte Carlo simulation|155|ch3.tm>>
    <associate|auto-26|<tuple|variable|11|ch1.tm>>
    <associate|auto-260|<tuple|Monte Carlo integration|156|ch3.tm>>
    <associate|auto-261|<tuple|3.1.3|157|ch3.tm>>
    <associate|auto-262|<tuple|functional programming|157|ch3.tm>>
    <associate|auto-263|<tuple|3.9|159|ch3.tm>>
    <associate|auto-264|<tuple|referentially transparent|159|ch3.tm>>
    <associate|auto-265|<tuple|aliasing|160|ch3.tm>>
    <associate|auto-266|<tuple|side-effect bugs|160|ch3.tm>>
    <associate|auto-267|<tuple|side-effect bugs|161|ch3.tm>>
    <associate|auto-268|<tuple|imperative programming|161|ch3.tm>>
    <associate|auto-269|<tuple|3.2|162|ch3.tm>>
    <associate|auto-27|<tuple|value|11|ch1.tm>>
    <associate|auto-270|<tuple|environments|162|ch3.tm>>
    <associate|auto-271|<tuple|frames|162|ch3.tm>>
    <associate|auto-272|<tuple|bindings|162|ch3.tm>>
    <associate|auto-273|<tuple|enclosing environment|162|ch3.tm>>
    <associate|auto-274|<tuple|global|162|ch3.tm>>
    <associate|auto-275|<tuple|value of a variable|162|ch3.tm>>
    <associate|auto-276|<tuple|unbound|162|ch3.tm>>
    <associate|auto-277|<tuple|3.1|162|ch3.tm>>
    <associate|auto-278|<tuple|3.2.1|162|ch3.tm>>
    <associate|auto-279|<tuple|3.2.2|163|ch3.tm>>
    <associate|auto-28|<tuple|environment|12|ch1.tm>>
    <associate|auto-280|<tuple|3.3|163|ch3.tm>>
    <associate|auto-281|<tuple|3.3.1|163|ch3.tm>>
    <associate|auto-282|<tuple|3.3.2|163|ch3.tm>>
    <associate|auto-283|<tuple|3.3.3|163|ch3.tm>>
    <associate|auto-284|<tuple|3.3.4|163|ch3.tm>>
    <associate|auto-285|<tuple|3.3.5|163|ch3.tm>>
    <associate|auto-286|<tuple|primitive cnstraints|163|ch3.tm>>
    <associate|auto-287|<tuple|constraint networks|164|ch3.tm>>
    <associate|auto-288|<tuple|connectors|164|ch3.tm>>
    <associate|auto-289|<tuple|3.2|164|ch3.tm>>
    <associate|auto-29|<tuple|global environment|12|ch1.tm>>
    <associate|auto-290|<tuple|3.2|164|ch3.tm>>
    <associate|auto-291|<tuple|3.2|165|ch3.tm>>
    <associate|auto-292|<tuple|<with|mode|<quote|math>|\<bullet\>>|169>>
    <associate|auto-3|<tuple|data|7|ch1.tm>>
    <associate|auto-30|<tuple|1.1.3|12|ch1.tm>>
    <associate|auto-31|<tuple|recursive|13|ch1.tm>>
    <associate|auto-32|<tuple|tree accumulation|13|ch1.tm>>
    <associate|auto-33|<tuple|1.1|13|ch1.tm>>
    <associate|auto-34|<tuple|special forms|14|ch1.tm>>
    <associate|auto-35|<tuple|syntactic sugar|14|ch1.tm>>
    <associate|auto-36|<tuple|1.1.4|14|ch1.tm>>
    <associate|auto-37|<tuple|procedure definitions|14|ch1.tm>>
    <associate|auto-38|<tuple|compound procedure|14|ch1.tm>>
    <associate|auto-39|<tuple|1.1.5|16|ch1.tm>>
    <associate|auto-4|<tuple|program|7|ch1.tm>>
    <associate|auto-40|<tuple|substitution model|16|ch1.tm>>
    <associate|auto-41|<tuple|substitution|17|ch1.tm>>
    <associate|auto-42|<tuple|normal order evaluation|17|ch1.tm>>
    <associate|auto-43|<tuple|application-order evaluation|17|ch1.tm>>
    <associate|auto-44|<tuple|stream processing|17|ch1.tm>>
    <associate|auto-45|<tuple|1.1.6|18|ch1.tm>>
    <associate|auto-46|<tuple|case analysis|18|ch1.tm>>
    <associate|auto-47|<tuple|clauses|18|ch1.tm>>
    <associate|auto-48|<tuple|predicate|18|ch1.tm>>
    <associate|auto-49|<tuple|consequent expression|18|ch1.tm>>
    <associate|auto-5|<tuple|programming languages|7|ch1.tm>>
    <associate|auto-50|<tuple|predicate|18|ch1.tm>>
    <associate|auto-51|<tuple|1.1.7|21|ch1.tm>>
    <associate|auto-52|<tuple|1.1.8|24|ch1.tm>>
    <associate|auto-53|<tuple|recursive|24|ch1.tm>>
    <associate|auto-54|<tuple|1.2|24|ch1.tm>>
    <associate|auto-55|<tuple|procedural abstraction|24|ch1.tm>>
    <associate|auto-56|<tuple|bound variable|25|ch1.tm>>
    <associate|auto-57|<tuple|binds|25|ch1.tm>>
    <associate|auto-58|<tuple|free|25|ch1.tm>>
    <associate|auto-59|<tuple|scope|25|ch1.tm>>
    <associate|auto-6|<tuple|bugs|7|ch1.tm>>
    <associate|auto-60|<tuple|capturing|25|ch1.tm>>
    <associate|auto-61|<tuple|block structure|26|ch1.tm>>
    <associate|auto-62|<tuple|lexical scoping|26|ch1.tm>>
    <associate|auto-63|<tuple|1.2|27|ch1.tm>>
    <associate|auto-64|<tuple|local evolution|27|ch1.tm>>
    <associate|auto-65|<tuple|global|27|ch1.tm>>
    <associate|auto-66|<tuple|1.2.1|27|ch1.tm>>
    <associate|auto-67|<tuple|1.3|28|ch1.tm>>
    <associate|auto-68|<tuple|1.4|29|ch1.tm>>
    <associate|auto-69|<tuple|deferred operations|29|ch1.tm>>
    <associate|auto-7|<tuple|glitches|7|ch1.tm>>
    <associate|auto-70|<tuple|recursive process|29|ch1.tm>>
    <associate|auto-71|<tuple|linear recursive process|29|ch1.tm>>
    <associate|auto-72|<tuple|iterative process|29|ch1.tm>>
    <associate|auto-73|<tuple|state variables|29|ch1.tm>>
    <associate|auto-74|<tuple|linear iterative process|29|ch1.tm>>
    <associate|auto-75|<tuple|process|30|ch1.tm>>
    <associate|auto-76|<tuple|procedure|30|ch1.tm>>
    <associate|auto-77|<tuple|tail-recursive|30|ch1.tm>>
    <associate|auto-78|<tuple|1.2.2|31|ch1.tm>>
    <associate|auto-79|<tuple|tree recursion|31|ch1.tm>>
    <associate|auto-8|<tuple|debug|7|ch1.tm>>
    <associate|auto-80|<tuple|1.5|31|ch1.tm>>
    <associate|auto-81|<tuple|golden ratio|32|ch1.tm>>
    <associate|auto-82|<tuple|tabulation|34|ch1.tm>>
    <associate|auto-83|<tuple|memoization|34|ch1.tm>>
    <associate|auto-84|<tuple|Pascal's triangle|34|ch1.tm>>
    <associate|auto-85|<tuple|binomial coefficients|34|ch1.tm>>
    <associate|auto-86|<tuple|1.2.3|34|ch1.tm>>
    <associate|auto-87|<tuple|order of growth|34|ch1.tm>>
    <associate|auto-88|<tuple|1.2.4|35|ch1.tm>>
    <associate|auto-89|<tuple|invariant quantity|37|ch1.tm>>
    <associate|auto-9|<tuple|recusion equations|7|ch1.tm>>
    <associate|auto-90|<tuple|1.2.5|38|ch1.tm>>
    <associate|auto-91|<tuple|Euclid's Algorithm|38|ch1.tm>>
    <associate|auto-92|<tuple|1.2.6|39|ch1.tm>>
    <associate|auto-93|<tuple|congruent modulo|40|ch1.tm>>
    <associate|auto-94|<tuple|remainder of|40|ch1.tm>>
    <associate|auto-95|<tuple|modulo|40|ch1.tm>>
    <associate|auto-96|<tuple|Carmichael numbers|41|ch1.tm>>
    <associate|auto-97|<tuple|probabilistic algorithms|42|ch1.tm>>
    <associate|auto-98|<tuple|RSA algorithm|42|ch1.tm>>
    <associate|auto-99|<tuple|Miller-Rabin test|43|ch1.tm>>
    <associate|define_fib|<tuple|tree recursion|31|ch1.tm>>
    <associate|define_square|<tuple|procedure definitions|14|ch1.tm>>
    <associate|ex1.5|<tuple|1.5|20|ch1.tm>>
    <associate|ex1.7|<tuple|1.7|23|ch1.tm>>
    <associate|ex2.12|<tuple|2.12|69|ch2.tm>>
    <associate|ex2.2|<tuple|2.2|65|ch2.tm>>
    <associate|ex2.21|<tuple|2.21|76|ch2.tm>>
    <associate|ex2.3|<tuple|2.3|66|ch2.tm>>
    <associate|ex2.30|<tuple|2.30|80|ch2.tm>>
    <associate|ex2.79|<tuple|2.79|135|ch2.tm>>
    <associate|ex2.83|<tuple|2.83|139|ch2.tm>>
    <associate|fig1.2|<tuple|1.2|24|ch1.tm>>
    <associate|fig1.3|<tuple|1.3|28|ch1.tm>>
    <associate|fig1.4|<tuple|1.4|29|ch1.tm>>
    <associate|fig1.5|<tuple|1.5|31|ch1.tm>>
    <associate|fig2.1|<tuple|2.1|65|ch2.tm>>
    <associate|fig2.10|<tuple|2.10|91|ch2.tm>>
    <associate|fig2.11|<tuple|2.11|92|ch2.tm>>
    <associate|fig2.12|<tuple|2.12|92|ch2.tm>>
    <associate|fig2.13|<tuple|2.13|93|ch2.tm>>
    <associate|fig2.18|<tuple|2.18|114|ch2.tm>>
    <associate|fig2.19|<tuple|2.19|120|ch2.tm>>
    <associate|fig2.2|<tuple|2.2|70|ch2.tm>>
    <associate|fig2.20|<tuple|2.20|121|ch2.tm>>
    <associate|fig2.21|<tuple|2.21|125|ch2.tm>>
    <associate|fig2.22|<tuple|2.22|126|ch2.tm>>
    <associate|fig2.23|<tuple|2.23|131|ch2.tm>>
    <associate|fig2.24|<tuple|2.24|134|ch2.tm>>
    <associate|fig2.25|<tuple|2.25|137|ch2.tm>>
    <associate|fig2.26|<tuple|2.26|139|ch2.tm>>
    <associate|fig2.3|<tuple|2.3|70|ch2.tm>>
    <associate|fig2.4|<tuple|2.4|71|ch2.tm>>
    <associate|fig2.5|<tuple|2.5|77|ch2.tm>>
    <associate|fig2.6|<tuple|2.6|78|ch2.tm>>
    <associate|fig2.7|<tuple|2.7|82|ch2.tm>>
    <associate|fig2.8|<tuple|2.8|89|ch2.tm>>
    <associate|fig2.9|<tuple|2.9|90|ch2.tm>>
    <associate|footnote-1.1|<tuple|1.1|8|ch1.tm>>
    <associate|footnote-1.10|<tuple|1.10|13|ch1.tm>>
    <associate|footnote-1.11|<tuple|1.11|14|ch1.tm>>
    <associate|footnote-1.12|<tuple|1.12|14|ch1.tm>>
    <associate|footnote-1.13|<tuple|1.13|15|ch1.tm>>
    <associate|footnote-1.14|<tuple|1.14|15|ch1.tm>>
    <associate|footnote-1.15|<tuple|1.15|17|ch1.tm>>
    <associate|footnote-1.16|<tuple|1.16|17|ch1.tm>>
    <associate|footnote-1.17|<tuple|1.17|18|ch1.tm>>
    <associate|footnote-1.18|<tuple|1.18|18|ch1.tm>>
    <associate|footnote-1.19|<tuple|1.19|19|ch1.tm>>
    <associate|footnote-1.2|<tuple|1.2|8|ch1.tm>>
    <associate|footnote-1.20|<tuple|1.20|21|ch1.tm>>
    <associate|footnote-1.21|<tuple|1.21|21|ch1.tm>>
    <associate|footnote-1.22|<tuple|1.22|22|ch1.tm>>
    <associate|footnote-1.23|<tuple|1.23|22|ch1.tm>>
    <associate|footnote-1.24|<tuple|1.24|23|ch1.tm>>
    <associate|footnote-1.25|<tuple|1.25|24|ch1.tm>>
    <associate|footnote-1.26|<tuple|1.26|25|ch1.tm>>
    <associate|footnote-1.27|<tuple|1.27|26|ch1.tm>>
    <associate|footnote-1.28|<tuple|1.28|27|ch1.tm>>
    <associate|footnote-1.29|<tuple|1.29|28|ch1.tm>>
    <associate|footnote-1.3|<tuple|1.3|8|ch1.tm>>
    <associate|footnote-1.30|<tuple|1.30|29|ch1.tm>>
    <associate|footnote-1.31|<tuple|1.31|30|ch1.tm>>
    <associate|footnote-1.32|<tuple|1.32|32|ch1.tm>>
    <associate|footnote-1.33|<tuple|1.33|33|ch1.tm>>
    <associate|footnote-1.34|<tuple|1.34|34|ch1.tm>>
    <associate|footnote-1.35|<tuple|1.35|34|ch1.tm>>
    <associate|footnote-1.36|<tuple|1.36|35|ch1.tm>>
    <associate|footnote-1.37|<tuple|1.37|36|ch1.tm>>
    <associate|footnote-1.38|<tuple|1.38|37|ch1.tm>>
    <associate|footnote-1.39|<tuple|1.39|37|ch1.tm>>
    <associate|footnote-1.4|<tuple|1.4|9|ch1.tm>>
    <associate|footnote-1.40|<tuple|1.40|37|ch1.tm>>
    <associate|footnote-1.41|<tuple|1.41|37|ch1.tm>>
    <associate|footnote-1.42|<tuple|1.42|38|ch1.tm>>
    <associate|footnote-1.43|<tuple|1.43|39|ch1.tm>>
    <associate|footnote-1.44|<tuple|1.44|40|ch1.tm>>
    <associate|footnote-1.45|<tuple|1.45|40|ch1.tm>>
    <associate|footnote-1.46|<tuple|1.46|41|ch1.tm>>
    <associate|footnote-1.47|<tuple|1.47|41|ch1.tm>>
    <associate|footnote-1.48|<tuple|1.48|42|ch1.tm>>
    <associate|footnote-1.49|<tuple|1.49|44|ch1.tm>>
    <associate|footnote-1.5|<tuple|1.5|10|ch1.tm>>
    <associate|footnote-1.50|<tuple|1.50|46|ch1.tm>>
    <associate|footnote-1.51|<tuple|1.51|47|ch1.tm>>
    <associate|footnote-1.52|<tuple|1.52|47|ch1.tm>>
    <associate|footnote-1.53|<tuple|1.53|49|ch1.tm>>
    <associate|footnote-1.54|<tuple|1.54|51|ch1.tm>>
    <associate|footnote-1.55|<tuple|1.55|52|ch1.tm>>
    <associate|footnote-1.56|<tuple|1.56|52|ch1.tm>>
    <associate|footnote-1.57|<tuple|1.57|53|ch1.tm>>
    <associate|footnote-1.58|<tuple|1.58|53|ch1.tm>>
    <associate|footnote-1.59|<tuple|1.59|55|ch1.tm>>
    <associate|footnote-1.6|<tuple|1.6|11|ch1.tm>>
    <associate|footnote-1.60|<tuple|1.60|56|ch1.tm>>
    <associate|footnote-1.61|<tuple|1.61|56|ch1.tm>>
    <associate|footnote-1.62|<tuple|1.62|56|ch1.tm>>
    <associate|footnote-1.63|<tuple|1.63|57|ch1.tm>>
    <associate|footnote-1.64|<tuple|1.64|58|ch1.tm>>
    <associate|footnote-1.65|<tuple|1.65|58|ch1.tm>>
    <associate|footnote-1.66|<tuple|1.66|58|ch1.tm>>
    <associate|footnote-1.7|<tuple|1.7|11|ch1.tm>>
    <associate|footnote-1.8|<tuple|1.8|11|ch1.tm>>
    <associate|footnote-1.9|<tuple|1.9|12|ch1.tm>>
    <associate|footnote-2.1|<tuple|2.1|62|ch2.tm>>
    <associate|footnote-2.10|<tuple|2.10|75|ch2.tm>>
    <associate|footnote-2.11|<tuple|2.11|75|ch2.tm>>
    <associate|footnote-2.12|<tuple|2.12|78|ch2.tm>>
    <associate|footnote-2.13|<tuple|2.13|83|ch2.tm>>
    <associate|footnote-2.14|<tuple|2.14|85|ch2.tm>>
    <associate|footnote-2.15|<tuple|2.15|85|ch2.tm>>
    <associate|footnote-2.16|<tuple|2.16|86|ch2.tm>>
    <associate|footnote-2.17|<tuple|2.17|87|ch2.tm>>
    <associate|footnote-2.18|<tuple|2.18|87|ch2.tm>>
    <associate|footnote-2.19|<tuple|2.19|88|ch2.tm>>
    <associate|footnote-2.2|<tuple|2.2|63|ch2.tm>>
    <associate|footnote-2.20|<tuple|2.20|88|ch2.tm>>
    <associate|footnote-2.21|<tuple|2.21|90|ch2.tm>>
    <associate|footnote-2.22|<tuple|2.22|91|ch2.tm>>
    <associate|footnote-2.23|<tuple|2.23|95|ch2.tm>>
    <associate|footnote-2.24|<tuple|2.24|95|ch2.tm>>
    <associate|footnote-2.25|<tuple|2.25|96|ch2.tm>>
    <associate|footnote-2.26|<tuple|2.26|96|ch2.tm>>
    <associate|footnote-2.27|<tuple|2.27|97|ch2.tm>>
    <associate|footnote-2.28|<tuple|2.28|98|ch2.tm>>
    <associate|footnote-2.29|<tuple|2.29|98|ch2.tm>>
    <associate|footnote-2.3|<tuple|2.3|63|ch2.tm>>
    <associate|footnote-2.30|<tuple|2.30|99|ch2.tm>>
    <associate|footnote-2.31|<tuple|2.31|100|ch2.tm>>
    <associate|footnote-2.32|<tuple|2.32|101|ch2.tm>>
    <associate|footnote-2.33|<tuple|2.33|101|ch2.tm>>
    <associate|footnote-2.34|<tuple|2.34|101|ch2.tm>>
    <associate|footnote-2.35|<tuple|2.35|102|ch2.tm>>
    <associate|footnote-2.36|<tuple|2.36|107|ch2.tm>>
    <associate|footnote-2.37|<tuple|2.37|110|ch2.tm>>
    <associate|footnote-2.38|<tuple|2.38|110|ch2.tm>>
    <associate|footnote-2.39|<tuple|2.39|111|ch2.tm>>
    <associate|footnote-2.4|<tuple|2.4|66|ch2.tm>>
    <associate|footnote-2.40|<tuple|2.40|112|ch2.tm>>
    <associate|footnote-2.41|<tuple|2.41|115|ch2.tm>>
    <associate|footnote-2.42|<tuple|2.42|120|ch2.tm>>
    <associate|footnote-2.43|<tuple|2.43|122|ch2.tm>>
    <associate|footnote-2.44|<tuple|2.44|127|ch2.tm>>
    <associate|footnote-2.45|<tuple|2.45|127|ch2.tm>>
    <associate|footnote-2.46|<tuple|2.46|128|ch2.tm>>
    <associate|footnote-2.47|<tuple|2.47|130|ch2.tm>>
    <associate|footnote-2.48|<tuple|2.48|135|ch2.tm>>
    <associate|footnote-2.49|<tuple|2.49|136|ch2.tm>>
    <associate|footnote-2.5|<tuple|2.5|71|ch2.tm>>
    <associate|footnote-2.50|<tuple|2.50|137|ch2.tm>>
    <associate|footnote-2.51|<tuple|2.51|138|ch2.tm>>
    <associate|footnote-2.52|<tuple|2.52|140|ch2.tm>>
    <associate|footnote-2.53|<tuple|2.53|140|ch2.tm>>
    <associate|footnote-2.54|<tuple|2.54|141|ch2.tm>>
    <associate|footnote-2.55|<tuple|2.55|142|ch2.tm>>
    <associate|footnote-2.56|<tuple|2.56|143|ch2.tm>>
    <associate|footnote-2.57|<tuple|2.57|144|ch2.tm>>
    <associate|footnote-2.58|<tuple|2.58|144|ch2.tm>>
    <associate|footnote-2.59|<tuple|2.59|146|ch2.tm>>
    <associate|footnote-2.6|<tuple|2.6|71|ch2.tm>>
    <associate|footnote-2.60|<tuple|2.60|147|ch2.tm>>
    <associate|footnote-2.61|<tuple|2.61|148|ch2.tm>>
    <associate|footnote-2.7|<tuple|2.7|71|ch2.tm>>
    <associate|footnote-2.8|<tuple|2.8|72|ch2.tm>>
    <associate|footnote-2.9|<tuple|2.9|72|ch2.tm>>
    <associate|footnote-3.1|<tuple|3.1|150|ch3.tm>>
    <associate|footnote-3.10|<tuple|3.10|160|ch3.tm>>
    <associate|footnote-3.11|<tuple|3.11|161|ch3.tm>>
    <associate|footnote-3.12|<tuple|3.12|163|ch3.tm>>
    <associate|footnote-3.2|<tuple|3.2|151|ch3.tm>>
    <associate|footnote-3.3|<tuple|3.3|151|ch3.tm>>
    <associate|footnote-3.4|<tuple|3.4|152|ch3.tm>>
    <associate|footnote-3.5|<tuple|3.5|152|ch3.tm>>
    <associate|footnote-3.6|<tuple|3.6|155|ch3.tm>>
    <associate|footnote-3.7|<tuple|3.7|155|ch3.tm>>
    <associate|footnote-3.8|<tuple|3.8|157|ch3.tm>>
    <associate|footnote-3.9|<tuple|3.9|158|ch3.tm>>
    <associate|footnr-1.1|<tuple|1.1|8|ch1.tm>>
    <associate|footnr-1.10|<tuple|1.10|13|ch1.tm>>
    <associate|footnr-1.11|<tuple|syntactic sugar|14|ch1.tm>>
    <associate|footnr-1.12|<tuple|1.12|14|ch1.tm>>
    <associate|footnr-1.13|<tuple|1.13|15|ch1.tm>>
    <associate|footnr-1.14|<tuple|1.14|15|ch1.tm>>
    <associate|footnr-1.15|<tuple|substitution|17|ch1.tm>>
    <associate|footnr-1.16|<tuple|stream processing|17|ch1.tm>>
    <associate|footnr-1.17|<tuple|1.17|18|ch1.tm>>
    <associate|footnr-1.18|<tuple|1.18|18|ch1.tm>>
    <associate|footnr-1.19|<tuple|1.19|19|ch1.tm>>
    <associate|footnr-1.2|<tuple|1.2|8|ch1.tm>>
    <associate|footnr-1.20|<tuple|1.20|21|ch1.tm>>
    <associate|footnr-1.21|<tuple|1.21|21|ch1.tm>>
    <associate|footnr-1.22|<tuple|1.22|22|ch1.tm>>
    <associate|footnr-1.23|<tuple|1.23|22|ch1.tm>>
    <associate|footnr-1.24|<tuple|1.24|23|ch1.tm>>
    <associate|footnr-1.25|<tuple|1.25|24|ch1.tm>>
    <associate|footnr-1.26|<tuple|1.26|25|ch1.tm>>
    <associate|footnr-1.27|<tuple|1.27|26|ch1.tm>>
    <associate|footnr-1.28|<tuple|1.28|27|ch1.tm>>
    <associate|footnr-1.29|<tuple|1.29|28|ch1.tm>>
    <associate|footnr-1.3|<tuple|1.3|8|ch1.tm>>
    <associate|footnr-1.30|<tuple|1.30|29|ch1.tm>>
    <associate|footnr-1.31|<tuple|1.31|30|ch1.tm>>
    <associate|footnr-1.32|<tuple|1.32|32|ch1.tm>>
    <associate|footnr-1.33|<tuple|1.33|33|ch1.tm>>
    <associate|footnr-1.34|<tuple|memoization|34|ch1.tm>>
    <associate|footnr-1.35|<tuple|binomial coefficients|34|ch1.tm>>
    <associate|footnr-1.36|<tuple|1.36|35|ch1.tm>>
    <associate|footnr-1.37|<tuple|1.37|36|ch1.tm>>
    <associate|footnr-1.38|<tuple|1.38|37|ch1.tm>>
    <associate|footnr-1.39|<tuple|1.39|37|ch1.tm>>
    <associate|footnr-1.4|<tuple|real numbers|9|ch1.tm>>
    <associate|footnr-1.40|<tuple|1.40|37|ch1.tm>>
    <associate|footnr-1.41|<tuple|1.41|37|ch1.tm>>
    <associate|footnr-1.42|<tuple|1.42|38|ch1.tm>>
    <associate|footnr-1.43|<tuple|1.43|39|ch1.tm>>
    <associate|footnr-1.44|<tuple|1.44|40|ch1.tm>>
    <associate|footnr-1.45|<tuple|1.45|40|ch1.tm>>
    <associate|footnr-1.46|<tuple|1.46|41|ch1.tm>>
    <associate|footnr-1.47|<tuple|Carmichael numbers|41|ch1.tm>>
    <associate|footnr-1.48|<tuple|RSA algorithm|42|ch1.tm>>
    <associate|footnr-1.49|<tuple|1.49|44|ch1.tm>>
    <associate|footnr-1.5|<tuple|1.5|10|ch1.tm>>
    <associate|footnr-1.50|<tuple|1.50|46|ch1.tm>>
    <associate|footnr-1.51|<tuple|sequences|47|ch1.tm>>
    <associate|footnr-1.52|<tuple|1.52|47|ch1.tm>>
    <associate|footnr-1.53|<tuple|1.53|49|ch1.tm>>
    <associate|footnr-1.54|<tuple|1.54|51|ch1.tm>>
    <associate|footnr-1.55|<tuple|1.55|52|ch1.tm>>
    <associate|footnr-1.56|<tuple|1.56|52|ch1.tm>>
    <associate|footnr-1.57|<tuple|1.57|53|ch1.tm>>
    <associate|footnr-1.58|<tuple|1.58|53|ch1.tm>>
    <associate|footnr-1.59|<tuple|1.59|55|ch1.tm>>
    <associate|footnr-1.6|<tuple|1.6|11|ch1.tm>>
    <associate|footnr-1.60|<tuple|1.60|56|ch1.tm>>
    <associate|footnr-1.61|<tuple|1.61|56|ch1.tm>>
    <associate|footnr-1.62|<tuple|1.62|56|ch1.tm>>
    <associate|footnr-1.63|<tuple|1.63|57|ch1.tm>>
    <associate|footnr-1.64|<tuple|1.64|58|ch1.tm>>
    <associate|footnr-1.65|<tuple|1.65|58|ch1.tm>>
    <associate|footnr-1.66|<tuple|1.66|58|ch1.tm>>
    <associate|footnr-1.7|<tuple|1.7|11|ch1.tm>>
    <associate|footnr-1.8|<tuple|1.8|11|ch1.tm>>
    <associate|footnr-1.9|<tuple|1.9|12|ch1.tm>>
    <associate|footnr-2.1|<tuple|2.1|62|ch2.tm>>
    <associate|footnr-2.10|<tuple|2.10|75|ch2.tm>>
    <associate|footnr-2.11|<tuple|2.11|75|ch2.tm>>
    <associate|footnr-2.12|<tuple|2.12|78|ch2.tm>>
    <associate|footnr-2.13|<tuple|2.13|83|ch2.tm>>
    <associate|footnr-2.14|<tuple|2.14|85|ch2.tm>>
    <associate|footnr-2.15|<tuple|2.15|85|ch2.tm>>
    <associate|footnr-2.16|<tuple|2.16|86|ch2.tm>>
    <associate|footnr-2.17|<tuple|2.17|87|ch2.tm>>
    <associate|footnr-2.18|<tuple|2.18|87|ch2.tm>>
    <associate|footnr-2.19|<tuple|2.19|88|ch2.tm>>
    <associate|footnr-2.2|<tuple|2.2|63|ch2.tm>>
    <associate|footnr-2.20|<tuple|comments|88|ch2.tm>>
    <associate|footnr-2.21|<tuple|2.21|90|ch2.tm>>
    <associate|footnr-2.22|<tuple|2.22|91|ch2.tm>>
    <associate|footnr-2.23|<tuple|2.23|95|ch2.tm>>
    <associate|footnr-2.24|<tuple|2.24|95|ch2.tm>>
    <associate|footnr-2.25|<tuple|2.25|96|ch2.tm>>
    <associate|footnr-2.26|<tuple|2.26|96|ch2.tm>>
    <associate|footnr-2.27|<tuple|2.27|97|ch2.tm>>
    <associate|footnr-2.28|<tuple|2.28|98|ch2.tm>>
    <associate|footnr-2.29|<tuple|2.29|98|ch2.tm>>
    <associate|footnr-2.3|<tuple|2.3|63|ch2.tm>>
    <associate|footnr-2.30|<tuple|2.30|99|ch2.tm>>
    <associate|footnr-2.31|<tuple|2.31|100|ch2.tm>>
    <associate|footnr-2.32|<tuple|2.32|101|ch2.tm>>
    <associate|footnr-2.33|<tuple|2.33|101|ch2.tm>>
    <associate|footnr-2.34|<tuple|2.34|101|ch2.tm>>
    <associate|footnr-2.35|<tuple|2.35|102|ch2.tm>>
    <associate|footnr-2.36|<tuple|<with|mode|<quote|math>|\<bullet\>>|107|ch2.tm>>
    <associate|footnr-2.37|<tuple|2.37|110|ch2.tm>>
    <associate|footnr-2.38|<tuple|2.38|110|ch2.tm>>
    <associate|footnr-2.39|<tuple|red-black trees|111|ch2.tm>>
    <associate|footnr-2.4|<tuple|algebraic specification|66|ch2.tm>>
    <associate|footnr-2.40|<tuple|2.40|112|ch2.tm>>
    <associate|footnr-2.41|<tuple|2.41|115|ch2.tm>>
    <associate|footnr-2.42|<tuple|2.42|120|ch2.tm>>
    <associate|footnr-2.43|<tuple|2.43|122|ch2.tm>>
    <associate|footnr-2.44|<tuple|2.44|127|ch2.tm>>
    <associate|footnr-2.45|<tuple|2.45|127|ch2.tm>>
    <associate|footnr-2.46|<tuple|2.46|128|ch2.tm>>
    <associate|footnr-2.47|<tuple|2.47|130|ch2.tm>>
    <associate|footnr-2.48|<tuple|2.48|135|ch2.tm>>
    <associate|footnr-2.49|<tuple|2.49|136|ch2.tm>>
    <associate|footnr-2.5|<tuple|2.5|71|ch2.tm>>
    <associate|footnr-2.50|<tuple|2.50|137|ch2.tm>>
    <associate|footnr-2.51|<tuple|2.51|138|ch2.tm>>
    <associate|footnr-2.52|<tuple|2.52|140|ch2.tm>>
    <associate|footnr-2.53|<tuple|2.53|140|ch2.tm>>
    <associate|footnr-2.54|<tuple|2.54|141|ch2.tm>>
    <associate|footnr-2.55|<tuple|2.55|142|ch2.tm>>
    <associate|footnr-2.56|<tuple|2.56|143|ch2.tm>>
    <associate|footnr-2.57|<tuple|2.57|144|ch2.tm>>
    <associate|footnr-2.58|<tuple|2.58|144|ch2.tm>>
    <associate|footnr-2.59|<tuple|2.59|146|ch2.tm>>
    <associate|footnr-2.6|<tuple|2.6|71|ch2.tm>>
    <associate|footnr-2.60|<tuple|2.60|147|ch2.tm>>
    <associate|footnr-2.61|<tuple|2.61|148|ch2.tm>>
    <associate|footnr-2.7|<tuple|list structure|71|ch2.tm>>
    <associate|footnr-2.8|<tuple|2.8|72|ch2.tm>>
    <associate|footnr-2.9|<tuple|2.9|72|ch2.tm>>
    <associate|footnr-3.1|<tuple|3.1|150|ch3.tm>>
    <associate|footnr-3.10|<tuple|side-effect bugs|160|ch3.tm>>
    <associate|footnr-3.11|<tuple|3.11|161|ch3.tm>>
    <associate|footnr-3.12|<tuple|3.12|163|ch3.tm>>
    <associate|footnr-3.2|<tuple|3.2|151|ch3.tm>>
    <associate|footnr-3.3|<tuple|3.3|151|ch3.tm>>
    <associate|footnr-3.4|<tuple|hiding principle|152|ch3.tm>>
    <associate|footnr-3.5|<tuple|3.5|152|ch3.tm>>
    <associate|footnr-3.6|<tuple|pseudo-random|155|ch3.tm>>
    <associate|footnr-3.7|<tuple|3.7|155|ch3.tm>>
    <associate|footnr-3.8|<tuple|3.8|157|ch3.tm>>
    <associate|footnr-3.9|<tuple|3.9|158|ch3.tm>>
    <associate|index-Euclidean-ring|<tuple|2.59|146|ch2.tm>>
    <associate|index-generic-procedures|<tuple|2.41|116|ch2.tm>>
    <associate|index-integerizing-factor|<tuple|2.60|147|ch2.tm>>
    <associate|index-invariant-quantity|<tuple|1.39|37|ch1.tm>>
    <associate|index-quote|<tuple|2.3.1|100|ch2.tm>>
    <associate|index-rational-functions|<tuple|2.92|146|ch2.tm>>
    <associate|index-stack|<tuple|1.30|29|ch1.tm>>
    <associate|part:ch1.tm|<tuple|?|7>>
    <associate|part:ch2.tm|<tuple|iterative improvement|59>>
    <associate|part:ch3.tm|<tuple|2.61|149>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1.1>|>
        Tree representation, showing the value of each subcombination.
      </surround>|<pageref|auto-33>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|1.2>|>
        Procedural decomposition of the <with|mode|<quote|prog>|prog-language|<quote|scheme>|font-family|<quote|rm>|sqrt>
        program
      </surround>|<pageref|auto-54>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|1.3>|>
        A linear recursive process for computing 6!.
      </surround>|<pageref|auto-67>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|1.4>|>
        A linear iterative process for computing 6!.
      </surround>|<pageref|auto-68>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|1.5>|>
        The tree-recursive process generated in computing
        <with|font-family|<quote|tt>|(fib 5)>.
      </surround>|<pageref|auto-80>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.1>|>
        Data-abstraction barriers in the rational-number package.
      </surround>|<pageref|auto-132>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.2>|>
        Box-and-pointer representation of <with|font-family|<quote|tt>|(cons
        1 2)>.
      </surround>|<pageref|auto-144>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.3>|>
        Two ways to combine 1, 2, 3, and 4 using pairs.
      </surround>|<pageref|auto-145>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.4>|>
        The sequence 1, 2, 3, 4 represented as a chain of pairs.
      </surround>|<pageref|auto-149>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.5>|>
        Structure formed by <with|font-family|<quote|tt>|(cons (list 1 2)
        (list 3 4))>.
      </surround>|<pageref|auto-159>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.6>|>
        The list structure in <locus|<id|%2723AC118-203AEEAF8--6960F647>|<link|hyperlink|<id|%2723AC118-203AEEAF8--6960F647>|<url|#fig2.5>>|Figure
        2.5> viewed as a tree.
      </surround>|<pageref|auto-161>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.7>|>
        The signal-flow plans for the procedures
        <with|font-family|<quote|tt>|sum-odd-squares> (top) and
        <with|font-family|<quote|tt>|even-fibs> (bottom) reveal the
        commonality between the two programs.
      </surround>|<pageref|auto-169>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.8>|>
        A solution to the eight-queens puzzle.
      </surround>|<pageref|auto-172>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.9>|>
        Designs generated with the picture language.
      </surround>|<pageref|auto-174>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.10>|>
        Images produced by the <with|font-family|<quote|tt>|wave> painter,
        with respect to four different frames. The frames, shown with dotted
        lines, are not part of the images.
      </surround>|<pageref|auto-176>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.11>|>
        Images of William Barton Rogers, founder and first president of
        <rigid|MIT>, painted with respect to the same four frames as in
        <locus|<id|%2723AC118-2019B9938-3E13695D>|<link|hyperlink|<id|%2723AC118-2019B9938-3E13695D>|<url|#fig2.10>>|Figure
        2.10> (original image from Wikimedia Commons).
      </surround>|<pageref|auto-177>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.12>|>
        Creating a complex figure, starting from the
        <with|font-family|<quote|tt>|wave> painter of
        <locus|<id|%2723AC118-200D5CF48-3E13695D>|<link|hyperlink|<id|%2723AC118-200D5CF48-3E13695D>|<url|#fig2.10>>|Figure
        2.10>.
      </surround>|<pageref|auto-178>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.13>|>
        Recursive plans for <with|font-family|<quote|tt>|right-split> and
        <with|font-family|<quote|tt>|corner-split>.
      </surround>|<pageref|auto-179>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.14>|>
        The recursive operations <with|font-family|<quote|tt>|right-split>
        and <with|font-family|<quote|tt>|corner-split> applied to the
        painters <with|font-family|<quote|tt>|wave> and
        <with|font-family|<quote|tt>|rogers>. Combining four
        <with|font-family|<quote|tt>|corner-split> figures produces symmetric
        <with|font-family|<quote|tt>|square-limit> designs as shown in
        <locus|<id|%2723AC118-201ADD610--6960F643>|<link|hyperlink|<id|%2723AC118-201ADD610--6960F643>|<url|#fig2.9>>|Figure
        2.9>.
      </surround>|<pageref|auto-180>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.15>|>
        \ A frame is described by three vectors \V an origin and two edges.
      </surround>|<pageref|auto-181>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.16>|>
        Various binary trees that represent the set
        <with|mode|<quote|math>|<around*|{|1,3,5,7,9,11|}>>.
      </surround>|<pageref|auto-190>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.17>|>
        Unbalanced tree produced by adjoining 1 through 7 in sequence.
      </surround>|<pageref|auto-193>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.18>|>
        A Huffman encoding tree.
      </surround>|<pageref|auto-201>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.19>|>
        Data-abstraction barriers in the complex-number system.
      </surround>|<pageref|auto-208>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.20>|>
        Complex numbers as points in the plane.
      </surround>|<pageref|auto-210>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.21>|>
        Structure of the generic complex-arithmetic system.
      </surround>|<pageref|auto-213>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.22>|>
        Table of operations for the complex-number system.
      </surround>|<pageref|auto-218>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.23>|>
        Generic arithmetic system.
      </surround>|<pageref|auto-222>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.24>|>
        Representation of 3 + 4<with|font-shape|<quote|italic>|i>
        <no-break><specific|screen|<resize|<move|<with|color|<quote|#A0A0FF>|->|-0.3em|>|0em||0em|>>in
        rectangular form.
      </surround>|<pageref|auto-225>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.25>|>
        A tower of types.
      </surround>|<pageref|auto-232>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2.26>|>
        Relations among types of geometric figures.
      </surround>|<pageref|auto-233>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|3.1>|>
        The simple environment structure
      </surround>|<pageref|auto-277>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|3.2>|>
        The relation <with|mode|<quote|math>|9*C = 5*(F - 32)> expressed as a
        constraint network.
      </surround>|<pageref|auto-289>>
    </associate>
    <\associate|idx>
      <tuple|<tuple|computational process>|<pageref|auto-2>>

      <tuple|<tuple|data>|<pageref|auto-3>>

      <tuple|<tuple|program>|<pageref|auto-4>>

      <tuple|<tuple|programming languages>|<pageref|auto-5>>

      <tuple|<tuple|bugs>|<pageref|auto-6>>

      <tuple|<tuple|glitches>|<pageref|auto-7>>

      <tuple|<tuple|debug>|<pageref|auto-8>>

      <tuple|<tuple|recusion equations>|<pageref|auto-9>>

      <tuple|<tuple|interpreter>|<pageref|auto-10>>

      <tuple|<tuple|procedures>|<pageref|auto-11>>

      <tuple|<tuple|integers>|<pageref|auto-13>>

      <tuple|<tuple|real numbers>|<pageref|auto-14>>

      <tuple|<tuple|expression>|<pageref|auto-16>>

      <tuple|<tuple|evaluating>|<pageref|auto-17>>

      <tuple|<tuple|combinations>|<pageref|auto-18>>

      <tuple|<tuple|operator>|<pageref|auto-19>>

      <tuple|<tuple|operands>|<pageref|auto-20>>

      <tuple|<tuple|arguments>|<pageref|auto-21>>

      <tuple|<tuple|prefix notation>|<pageref|auto-22>>

      <tuple|<tuple|pretty-printing>|<pageref|auto-23>>

      <tuple|<tuple|read-eval-print loop>|<pageref|auto-24>>

      <tuple|<tuple|variable>|<pageref|auto-26>>

      <tuple|<tuple|value>|<pageref|auto-27>>

      <tuple|<tuple|environment>|<pageref|auto-28>>

      <tuple|<tuple|global environment>|<pageref|auto-29>>

      <tuple|<tuple|recursive>|<pageref|auto-31>>

      <tuple|<tuple|tree accumulation>|<pageref|auto-32>>

      <tuple|<tuple|special forms>|<pageref|auto-34>>

      <tuple|<tuple|syntactic sugar>|<pageref|auto-35>>

      <tuple|<tuple|procedure definitions>|<pageref|auto-37>>

      <tuple|<tuple|compound procedure>|<pageref|auto-38>>

      <tuple|<tuple|substitution model>|<pageref|auto-40>>

      <tuple|<tuple|substitution>|<pageref|auto-41>>

      <tuple|<tuple|normal order evaluation>|<pageref|auto-42>>

      <tuple|<tuple|application-order evaluation>|<pageref|auto-43>>

      <tuple|<tuple|stream processing>|<pageref|auto-44>>

      <tuple|<tuple|case analysis>|<pageref|auto-46>>

      <tuple|<tuple|clauses>|<pageref|auto-47>>

      <tuple|<tuple|predicate>|<pageref|auto-48>>

      <tuple|<tuple|consequent expression>|<pageref|auto-49>>

      <tuple|<tuple|predicate>|<pageref|auto-50>>

      <tuple|<tuple|recursive>|<pageref|auto-53>>

      <tuple|<tuple|procedural abstraction>|<pageref|auto-55>>

      <tuple|<tuple|bound variable>|<pageref|auto-56>>

      <tuple|<tuple|binds>|<pageref|auto-57>>

      <tuple|<tuple|free>|<pageref|auto-58>>

      <tuple|<tuple|scope>|<pageref|auto-59>>

      <tuple|<tuple|capturing>|<pageref|auto-60>>

      <tuple|<tuple|block structure>|<pageref|auto-61>>

      <tuple|<tuple|lexical scoping>|<pageref|auto-62>>

      <tuple|<tuple|local evolution>|<pageref|auto-64>>

      <tuple|<tuple|global>|<pageref|auto-65>>

      <tuple|<tuple|deferred operations>|<pageref|auto-69>>

      <tuple|<tuple|recursive process>|<pageref|auto-70>>

      <tuple|<tuple|linear recursive process>|<pageref|auto-71>>

      <tuple|<tuple|iterative process>|<pageref|auto-72>>

      <tuple|<tuple|state variables>|<pageref|auto-73>>

      <tuple|<tuple|linear iterative process>|<pageref|auto-74>>

      <tuple|<tuple|process>|<pageref|auto-75>>

      <tuple|<tuple|procedure>|<pageref|auto-76>>

      <tuple|<tuple|tail-recursive>|<pageref|auto-77>>

      <tuple|<tuple|tree recursion>|<pageref|auto-79>>

      <tuple|<tuple|golden ratio>|<pageref|auto-81>>

      <tuple|<tuple|tabulation>|<pageref|auto-82>>

      <tuple|<tuple|memoization>|<pageref|auto-83>>

      <tuple|<tuple|Pascal's triangle>|<pageref|auto-84>>

      <tuple|<tuple|binomial coefficients>|<pageref|auto-85>>

      <tuple|<tuple|order of growth>|<pageref|auto-87>>

      <tuple|<tuple|invariant quantity>|<pageref|auto-89>>

      <tuple|<tuple|Euclid's Algorithm>|<pageref|auto-91>>

      <tuple|<tuple|congruent modulo>|<pageref|auto-93>>

      <tuple|<tuple|remainder of>|<pageref|auto-94>>

      <tuple|<tuple|modulo>|<pageref|auto-95>>

      <tuple|<tuple|Carmichael numbers>|<pageref|auto-96>>

      <tuple|<tuple|probabilistic algorithms>|<pageref|auto-97>>

      <tuple|<tuple|RSA algorithm>|<pageref|auto-98>>

      <tuple|<tuple|Miller-Rabin test>|<pageref|auto-99>>

      <tuple|<tuple|higher-order procedures>|<pageref|auto-101>>

      <tuple|<tuple|summation of a series>|<pageref|auto-103>>

      <tuple|<tuple|sequences>|<pageref|auto-104>>

      <tuple|<tuple|filter>|<pageref|auto-105>>

      <tuple|<tuple|half interval method>|<pageref|auto-108>>

      <tuple|<tuple|fixed point>|<pageref|auto-109>>

      <tuple|<tuple|average damping>|<pageref|auto-110>>

      <tuple|<tuple|continued fraction>|<pageref|auto-111>>

      <tuple|<tuple|k-term finite continued fraction>|<pageref|auto-112>>

      <tuple|<tuple|Newton's method>|<pageref|auto-114>>

      <tuple|<tuple|first-class>|<pageref|auto-115>>

      <tuple|<tuple|composition>|<pageref|auto-116>>

      <tuple|<tuple|smoothing>|<pageref|auto-117>>

      <tuple|<tuple|n-fold smoothed function>|<pageref|auto-118>>

      <tuple|<tuple|iterative improvement>|<pageref|auto-119>>

      <tuple|<tuple|data abstraction>|<pageref|auto-122>>

      <tuple|<tuple|selectors>|<pageref|auto-123>>

      <tuple|<tuple|constructors>|<pageref|auto-124>>

      <tuple|<tuple|wishful thinking>|<pageref|auto-126>>

      <tuple|<tuple|pair>|<pageref|auto-127>>

      <tuple|<tuple|pair>|<pageref|auto-128>>

      <tuple|<tuple|list-structured>|<pageref|auto-129>>

      <tuple|<tuple|abstraction barriers>|<pageref|auto-131>>

      <tuple|<tuple|data>|<pageref|auto-134>>

      <tuple|<tuple|abstract models>|<pageref|auto-135>>

      <tuple|<tuple|algebraic specification>|<pageref|auto-136>>

      <tuple|<tuple|message passing>|<pageref|auto-137>>

      <tuple|<tuple|Church numerals>|<pageref|auto-138>>

      <tuple|<tuple|width>|<pageref|auto-140>>

      <tuple|<tuple|box-and-pointer notation>|<pageref|auto-142>>

      <tuple|<tuple|pointer>|<pageref|auto-143>>

      <tuple|<tuple|closure property>|<pageref|auto-146>>

      <tuple|<tuple|hierarchical>|<pageref|auto-147>>

      <tuple|<tuple|sequence>|<pageref|auto-150>>

      <tuple|<tuple|list>|<pageref|auto-151>>

      <tuple|<tuple|list>|<pageref|auto-152>>

      <tuple|<tuple|list structure>|<pageref|auto-153>>

      <tuple|<tuple|empty list>|<pageref|auto-154>>

      <tuple|<tuple|nil>|<pageref|auto-155>>

      <tuple|<tuple|dotted-tail notation>|<pageref|auto-156>>

      <tuple|<tuple|list>|<pageref|auto-157>>

      <tuple|<tuple|trees>|<pageref|auto-160>>

      <tuple|<tuple|balanced>|<pageref|auto-162>>

      <tuple|<tuple|conventional interfaces>|<pageref|auto-164>>

      <tuple|<tuple|enumerator>|<pageref|auto-165>>

      <tuple|<tuple|filter>|<pageref|auto-166>>

      <tuple|<tuple|map>|<pageref|auto-167>>

      <tuple|<tuple|accumulator>|<pageref|auto-168>>

      <tuple|<tuple|Horner's rule>|<pageref|auto-170>>

      <tuple|<tuple|comments>|<pageref|auto-171>>

      <tuple|<tuple|painter>|<pageref|auto-175>>

      <tuple|<tuple|frame coordinate map>|<pageref|auto-182>>

      <tuple|<tuple|stratified design>|<pageref|auto-183>>

      <tuple|<tuple|robust>|<pageref|auto-184>>

      <tuple|<tuple|values>|<pageref|auto-187>>

      <tuple|<tuple|B-trees>|<pageref|auto-191>>

      <tuple|<tuple|red-black trees>|<pageref|auto-192>>

      <tuple|<tuple|key>|<pageref|auto-194>>

      <tuple|<tuple|fixed-length>|<pageref|auto-196>>

      <tuple|<tuple|variable-length>|<pageref|auto-197>>

      <tuple|<tuple|separator code>|<pageref|auto-198>>

      <tuple|<tuple|prefix>|<pageref|auto-199>>

      <tuple|<tuple|prefix code>|<pageref|auto-200>>

      <tuple|<tuple|generic procedures>|<pageref|auto-202>>

      <tuple|<tuple|additively>|<pageref|auto-204>>

      <tuple|<tuple|generic procedures>|<pageref|auto-205>>

      <tuple|<tuple|type tags>|<pageref|auto-206>>

      <tuple|<tuple|data-directed>|<pageref|auto-207>>

      <tuple|<tuple|type tag>|<pageref|auto-212>>

      <tuple|<tuple|dispatching on type>|<pageref|auto-215>>

      <tuple|<tuple|additive>|<pageref|auto-216>>

      <tuple|<tuple|data directed programming>|<pageref|auto-217>>

      <tuple|<tuple|package>|<pageref|auto-219>>

      <tuple|<tuple|message passing>|<pageref|auto-220>>

      <tuple|<tuple|ordinary>|<pageref|auto-224>>

      <tuple|<tuple|coercion>|<pageref|auto-227>>

      <tuple|<tuple|hierarchy of types>|<pageref|auto-228>>

      <tuple|<tuple|subtype>|<pageref|auto-229>>

      <tuple|<tuple|supertype>|<pageref|auto-230>>

      <tuple|<tuple|tower>|<pageref|auto-231>>

      <tuple|<tuple|coerce>|<pageref|auto-234>>

      <tuple|<tuple|indeterminates>|<pageref|auto-236>>

      <tuple|<tuple|univariate polynomials>|<pageref|auto-237>>

      <tuple|<tuple|poly>|<pageref|auto-238>>

      <tuple|<tuple|dense>|<pageref|auto-239>>

      <tuple|<tuple|sparse>|<pageref|auto-240>>

      <tuple|<tuple|pseudodivision>|<pageref|auto-241>>

      <tuple|<tuple|pseudoremainder>|<pageref|auto-242>>

      <tuple|<tuple|modular>|<pageref|auto-244>>

      <tuple|<tuple|object>|<pageref|auto-245>>

      <tuple|<tuple|stream>|<pageref|auto-246>>

      <tuple|<tuple|environment model>|<pageref|auto-247>>

      <tuple|<tuple|delayed evaluation>|<pageref|auto-248>>

      <tuple|<tuple|state variable>|<pageref|auto-250>>

      <tuple|<tuple|local state variable>|<pageref|auto-251>>

      <tuple|<tuple|assignment operator>|<pageref|auto-252>>

      <tuple|<tuple|encapsulated>|<pageref|auto-254>>

      <tuple|<tuple|hiding principle>|<pageref|auto-255>>

      <tuple|<tuple|accumulator>|<pageref|auto-256>>

      <tuple|<tuple|pseudo-random>|<pageref|auto-258>>

      <tuple|<tuple|Monte Carlo simulation>|<pageref|auto-259>>

      <tuple|<tuple|Monte Carlo integration>|<pageref|auto-260>>

      <tuple|<tuple|functional programming>|<pageref|auto-262>>

      <tuple|<tuple|referentially transparent>|<pageref|auto-264>>

      <tuple|<tuple|aliasing>|<pageref|auto-265>>

      <tuple|<tuple|side-effect bugs>|<pageref|auto-266>>

      <tuple|<tuple|imperative programming>|<pageref|auto-268>>

      <tuple|<tuple|environments>|<pageref|auto-270>>

      <tuple|<tuple|frames>|<pageref|auto-271>>

      <tuple|<tuple|bindings>|<pageref|auto-272>>

      <tuple|<tuple|enclosing environment>|<pageref|auto-273>>

      <tuple|<tuple|global>|<pageref|auto-274>>

      <tuple|<tuple|value of a variable>|<pageref|auto-275>>

      <tuple|<tuple|unbound>|<pageref|auto-276>>

      <tuple|<tuple|primitive cnstraints>|<pageref|auto-286>>

      <tuple|<tuple|constraint networks>|<pageref|auto-287>>

      <tuple|<tuple|connectors>|<pageref|auto-288>>
    </associate>
    <\associate|parts>
      <tuple|ch1.tm|chapter-nr|0|section-nr|0|subsection-nr|0>

      <tuple|ch2.tm|chapter-nr|1|section-nr|3|subsection-nr|4>

      <tuple|ch3.tm|chapter-nr|2|section-nr|5|subsection-nr|3>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Building
      Abstractions with Procedures> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      1.1<space|2spc>The Elements of Programming
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>

      <with|par-left|<quote|1tab>|1.1.1<space|2spc>Expressions
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-15>>

      <with|par-left|<quote|1tab>|1.1.2<space|2spc>Naming and the Environment
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-25>>

      <with|par-left|<quote|1tab>|1.1.3<space|2spc>Evaluating Combinations
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-30>>

      <with|par-left|<quote|1tab>|1.1.4<space|2spc>Compound Procedures
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-36>>

      <with|par-left|<quote|1tab>|1.1.5<space|2spc>The Substitution Model for
      Procedure Application <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-39>>

      <with|par-left|<quote|1tab>|1.1.6<space|2spc>Conditional Expressions
      and Predicates <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-45>>

      <with|par-left|<quote|1tab>|1.1.7<space|2spc>Example: Square Roots by
      Newton's Method <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-51>>

      <with|par-left|<quote|1tab>|1.1.8<space|2spc>Procedures as Black-Box
      Abstractions <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-52>>

      1.2<space|2spc>Procedures and the Processes They Generate
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-63>

      <with|par-left|<quote|1tab>|1.2.1<space|2spc>Linear Recursion and
      Iteration <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-66>>

      <with|par-left|<quote|1tab>|1.2.2<space|2spc>Tree Recursion
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-78>>

      <with|par-left|<quote|1tab>|1.2.3<space|2spc>Orders of Growth
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-86>>

      <with|par-left|<quote|1tab>|1.2.4<space|2spc>Exponentiation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-88>>

      <with|par-left|<quote|1tab>|1.2.5<space|2spc>Greatest Common Divisors
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-90>>

      <with|par-left|<quote|1tab>|1.2.6<space|2spc>Example: Testing for
      Primality <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-92>>

      1.3<space|2spc>Formulating Abstractions with Higher-Order Procedures
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-100>

      <with|par-left|<quote|1tab>|1.3.1<space|2spc>Procedures as Arguments
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-102>>

      <with|par-left|<quote|1tab>|1.3.2<space|2spc>Constructing Procedures
      Using <with|font-family|<quote|tt>|Lambda>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-106>>

      <with|par-left|<quote|1tab>|1.3.3<space|2spc>Procedures as General
      Methods <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-107>>

      <with|par-left|<quote|1tab>|1.3.4<space|2spc>Procedures as Returned
      Values <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-113>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Building
      Abstractions with Data> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-120><vspace|0.5fn>

      2.1<space|2spc>Introduction to Data Abstraction
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-121>

      <with|par-left|<quote|1tab>|2.1.1<space|2spc>Example: Arithmetic
      Operations for Rational Numbers <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-125>>

      <with|par-left|<quote|1tab>|2.1.2<space|2spc>Abstraction Barriers
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-130>>

      <with|par-left|<quote|1tab>|2.1.3<space|2spc>What Is Meant by Data?
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-133>>

      <with|par-left|<quote|1tab>|2.1.4<space|2spc>Extended Exercise:
      Interval Arithmetic <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-139>>

      2.2<space|2spc>Hierarchical Data and the Closure Property
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-141>

      <with|par-left|<quote|1tab>|2.2.1<space|2spc>Representing Sequences
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-148>>

      <with|par-left|<quote|1tab>|2.2.2<space|2spc>Hierarchical Structures
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-158>>

      <with|par-left|<quote|1tab>|2.2.3<space|2spc>Sequences as Conventional
      Interfaces <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-163>>

      <with|par-left|<quote|1tab>|2.2.4<space|2spc>Example: A Picture
      Language <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-173>>

      2.3<space|2spc>Symbolic Data <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-185>

      <with|par-left|<quote|1tab>|2.3.1<space|2spc>Quotation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-186>>

      <with|par-left|<quote|1tab>|2.3.2<space|2spc>Example: Symbolic
      Differentiation <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-188>>

      <with|par-left|<quote|1tab>|2.3.3<space|2spc>Example: Representing Sets
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-189>>

      <with|par-left|<quote|1tab>|2.3.4<space|2spc>Example: Huffman Encoding
      Trees <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-195>>

      2.4<space|2spc>Multiple Representations for Abstract Data
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-203>

      <with|par-left|<quote|1tab>|2.4.1<space|2spc>Representations for
      Complex Numbers <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-209>>

      <with|par-left|<quote|1tab>|2.4.2<space|2spc>Tagged data
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-211>>

      <with|par-left|<quote|1tab>|2.4.3<space|2spc>Data-Directed Programming
      and Additivity <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-214>>

      2.5<space|2spc>Systems with Generic Operations
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-221>

      <with|par-left|<quote|1tab>|2.5.1<space|2spc>Generic Arithmetic
      Operations <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-223>>

      <with|par-left|<quote|1tab>|2.5.2<space|2spc>Combining Data of
      Different Types <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-226>>

      <with|par-left|<quote|1tab>|2.5.3<space|2spc>Example: Symbolic Algebra
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-235>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Modularity,
      Objects and State> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-243><vspace|0.5fn>

      3.1<space|2spc>Assignment and Local State
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-249>

      <with|par-left|<quote|1tab>|3.1.1<space|2spc>Local State Variables
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-253>>

      <with|par-left|<quote|1tab>|3.1.2<space|2spc>The Benefits of
      Introducing Assignment <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-257>>

      <with|par-left|<quote|1tab>|3.1.3<space|2spc>The Cost of Introducing
      Assignment <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-261>>

      <with|par-left|<quote|2tab>|Sameness and Change
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-263>>

      <with|par-left|<quote|2tab>|Pitfalls of imperactive programming
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-267>>

      3.2<space|2spc>The Environment Model of Evaluation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-269>

      <with|par-left|<quote|1tab>|3.2.1<space|2spc>The Rules for Evaluation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-278>>

      <with|par-left|<quote|1tab>|3.2.2<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-279>>

      3.3<space|2spc> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-280>

      <with|par-left|<quote|1tab>|3.3.1<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-281>>

      <with|par-left|<quote|1tab>|3.3.2<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-282>>

      <with|par-left|<quote|1tab>|3.3.3<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-283>>

      <with|par-left|<quote|1tab>|3.3.4<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-284>>

      <with|par-left|<quote|1tab>|3.3.5<space|2spc>Propagation of Constraints
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-285>>

      <with|par-left|<quote|2tab>|Using the constraint system
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-290>>

      <with|par-left|<quote|2tab>|Implementing the constraint system
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-291>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Index>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-292><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>