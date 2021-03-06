# sigma: summation of a series
(def sigma (func (term a next b)
    (def iter (func (i result)
        (if (> i b)
            result
            (iter (next i) (+ (term i) result)))))
    (iter a 0)))

# Higher order functions

# sum_int: sum of integers in range [a, b]
(def sum_int (func (a b)
    (def id (func (x) x))
    (def incr (func (x) (+ x 1)))
    (sigma id a incr b)))

# sum_cubes: sum of cubes
(def sum_cubes (func (a b)
    (def cube (func (x) (* x x x)))
    (def incr (func (x) (+ x 1)))
    (sigma cube a incr b)))

# pi_sum: slowly converges to Pi/8
(def pi_sum (func (a b)
    (def pi_term (func (x) (/ 1 (* x (+ x 2)))))
    (def pi_next (func (x) (+ x 4)))
    (sigma pi_term a pi_next b)))

# integral: approximate integral of f between limits a and b
(def integral (func (f a b dx)
    (def add_dx (func (x) (+ x dx)))
    (* (sigma f (+ a (/ dx 2)) add_dx b) dx)))


# Tests

(def si (sum_int 1 10))
(if (== si 55)
    (println "OK -- Sum of integers in range [1, 10]: " si)
    (println "FAIL -- Sum of integers in range [1, 10]: " si))

(def sc (sum_cubes 1 10))
(if (== sc 3025)
    (println "OK -- Sum of cubes of integers in range [1, 10]: " sc)
    (println "FAIL -- Sum of cubes of integers in range [1, 10]: " sc))

(def ps (* 8 (pi_sum 1 2000)))
(if (< (abs (- PI ps)) 0.01)
    (println "OK -- Approximate value of Pi: " ps)
    (println "FAIL -- Approximate value of Pi: " ps))

(def cube (func (x) (* x x x)))
(def i1 (integral cube 0 1 0.01))
(def i2 (integral cube 0 1 0.001))
(if (< (abs (- 0.25 i2)) 0.001)
    (println "OK -- Intergral of f(x) = x^3 on the interval 0..1 is " i2)
    (println "FAIL -- Intergral of f(x) = x^3 on the interval 0..1 is " i2))
