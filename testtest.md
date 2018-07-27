
# Test

あいうえお




<iframe width="100%" height="300" src="//jsfiddle.net/kenokabe/hu1xqtao/embedded/result/" allowfullscreen="allowfullscreen" allowpaymentrequest frameborder="0"></iframe>



```javascript
//Debug/validation use-----------------
const equalJSON = a => b => JSON.stringify(a) === JSON.stringify(b);
const logEq = a => b => {
    const result = equalJSON(a)(b);
    console.log(result);
    return result;
};   //Debug/validation use-----------------
{
    const typedPrimitive = T => i => {
        const typeProperty = {
            enumerable: false,
            configurable: false,
            writable: false,
            value: true
        };
        const derived = Object(i);
        Object.setPrototypeOf(derived, Object(i));
        Object.defineProperty(derived, T, typeProperty);
        return derived;
    };

    const typedObject = T => i => {
        const handler = {
            get: (target, name) => name == T//must ==
                ? true : target[name]
        };
        return new Proxy(i, handler);
    };

    const typed = T => i => (i !== Object(i))//primitives
        ? typedPrimitive(T)(i)
        : typedObject(T)(i)

    const istype = T => i => i[T] === true;

    const Type = T => i => (i === T) || (i == null)
        ? i
        : typed(T)(i);

    const isType = T => i => (i === T)
        ? true
        : (i == null)
            ? false
            : istype(T)(i);



    const op = f => Type(op)(f);
    const opM = f => Type(opM)(f);

    //wild card op + lazy = fold!

    // const show = Symbol();


    const I = x => x;
    const L = x => y => x;
    const P = x => y => z => z(x)(y);

    const Left = L;
    const Right = L(I);
    const Pair = P;

    log("-------");

    const fold = f => left => right => left === I
        ? left(right)
        : f(left(fold(f)))(right);



    const plus = x => y => Number(x) + Number(y);
    const multiply = x => y => Number(x) * Number(y);


    const unit = (a) => [a];
    const join = ([a]) => [].concat(a);
    const flatUnit = a => join(unit(a));
    const concat = a => x => flatUnit(a)
        .concat(x);

    const addArray = a => b => {
        const aa = isType(addArray)(a)
            ? a : [a];
        return Type(addArray)([...aa, b]);
    };

    const concatStr = a => b => String(a) + String(b);

    const max = a => b => (a > b) ? a : b;
    const min = a => b => (a < b) ? a : b;



    const first = a => b => a;//???
    const last = a => b => b;

    const io = a => b => {
        log("a:" + a);
        log("b:" + b);
        return b;
    };
    //Head



    // 15
    /*
    log(
        M(1)(2)(3)(4)(5)(op(multiply))
    ); // 120
    log(
        M(1)(2)(3)(4)(5)(op(concatStr))
    ); // 12345
    log(
        M(1)(2)(3)(4)(5)(op(concat))
    ); // [ 1, 2, 3, 4, 5 ]
    log(
        M([1, 2])([3, 4])([5, 6])([7, 8])([9])(op(concat))
    );
    log(
        M([1, 2])([3, 4])([5, 6])([7, 8])([9])(op(addArray))
    ); // [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ], [ 7, 8 ], [ 9 ] ]

    log(
        M(1)(2)(3)(4)(5)(op(max))
    ); // 5
    log(
        M(1)(2)(3)(4)(5)(op(min))
    ); // 1
    log(
        M(1)(2)(3)(4)(5)(op(first))
    ); // 1
    log(
        M(1)(2)(3)(4)(5)(op(last))
    ); // 5

    log(//IO Monoid
        M(1)(2)(3)(4)(5)(op(io))
    ); // 5

 */
    function log(m) {
        console.log((m)); //IO
        return m;
    };


    const Last = op(Right);
    const First = op(fold(first));

    const toArray = op(fold(concat));

    const _M = x => y => isType(_M)(y)
        ? y// M(M(a)) = M(a)  //left identity
        : Type(_M)(
            z => Type(_M)(z === M
                ? _M(x)(y)// a(M) = a  //right identity
                : isType(op)(z)
                    ? M(Pair(x)(y)(z))
                    : isType(opM)(z)
                        ? Pair(x)(y)(z)//Mcomposing op
                        : isType(_M)(z)
                            ? _M(
                                Pair(x)(y)
                                    (Joint(z(Reverse)))
                            )
                            : _M(Pair(x)(y))(z)
            )
        );

    const M = Type(_M)(_M(I));

    const joint = acc => z => left => right => z === I
        ? (() => {
            log(right);
            return I;
        })()
        : (() => {
            log("===debug=============");

            left(Log);
            log(right);
            log("----------------");
            z(Log);

            return reverse(Pair(acc)(right))//<--accumlation
                (left(Left))// next left
                (left(Right));//next right

        })();

    const Joint = opM(joint(I));

    const inspect = left => right => left === I
        ? (() => {
            log(right);
            return I;
        })()
        : (() => {
            log(right);
            return left(inspect);
        })();
    const Log = op(inspect);
    log("-------");
    const a = (M(1));
    log(
        isType(_M)(a)
    );
    log(
        M(a) === a
    );
    log(
        M(M) === M
    );
    log(
        isType(_M)(a(M))
    );


    logEq(
        M(a)
    )(
        a
    );
    logEq(
        a
    )(
        a(M)
    );
    logEq(
        M
    )(
        (M)(M)
    );


    M(1)(M)(2)(M)
        (toArray)
        (Log);

    const sum = left => right => left === I
        ? right
        : plus(left(sum))(right);

    const reverse = acc => left => right => left === I
        ? Pair(acc)(right)
        : reverse(Pair(acc)(right))//<--accumlation
            (left(Left))// next left
            (left(Right));//next right

    const Reverse = opM(reverse(I));

    {
        log("----reverse------------");
        log(
            isType(_M)
                (M(1)(2)(3)
                    (Reverse)
                )
        );

        const a = M(1)(2)(3);

        const b = M(4)(5)(6);
        log("----------------");

        //  (a)(First)(Log);
        // (a)(Last)(Log);

        (a)(b)

    }

}
```

    -------
    -------
    true
    true
    true
    true
    true
    true
    true
    [ 1, 2 ]
    ----reverse------------
    true
    ----------------
    ===debug=============
    2
    1
    3
    ----------------
    4
    5
    6





    [Function]


