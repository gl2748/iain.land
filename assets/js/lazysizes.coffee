###! lazysizes - v2.0.0 ###

!((a, b) ->
  c = b(a, a.document)
  a.lazySizes = c
  'object' == typeof module and module.exports and (module.exports = c)
  return
)(window, (a, b) ->
  'use strict'
  if b.getElementsByClassName
    c = undefined
    d = b.documentElement
    e = a.Date
    f = a.HTMLPictureElement
    g = 'addEventListener'
    h = 'getAttribute'
    i = a[g]
    j = a.setTimeout
    k = a.requestAnimationFrame or j
    l = a.requestIdleCallback
    m = /^picture$/i
    n = [
      'load'
      'error'
      'lazyincluded'
      '_lazyloaded'
    ]
    o = {}
    p = Array::forEach

    q = (a, b) ->
      o[b] or (o[b] = new RegExp('(\\s|^)' + b + '(\\s|$)'))
      o[b].test(a[h]('class') or '') and o[b]

    r = (a, b) ->
      q(a, b) or a.setAttribute('class', (a[h]('class') or '').trim() + ' ' + b)
      return

    s = (a, b) ->
      `var c`
      c = undefined
      (c = q(a, b)) and a.setAttribute('class', (a[h]('class') or '').replace(c, ' '))
      return

    t = (a, b, c) ->
      `var d`
      d = if c then g else 'removeEventListener'
      c and t(a, b)
      n.forEach((c) ->
        a[d] c, b
        return
      )
      return

    u = (a, c, d, e, f) ->
      `var g`
      g = b.createEvent('CustomEvent')
      g.initCustomEvent(c, !e, !f, d or {})
      a.dispatchEvent(g)
      g

    v = (b, d) ->
      `var e`
      e = undefined
      if !f and (e = a.picturefill or c.pf) then e(
        reevaluate: !0
        elements: [ b ]) else d and d.src and (b.src = d.src)
      return

    w = (a, b) ->
      (getComputedStyle(a, null) or {})[b]

    x = (a, b, d) ->
      d = d or a.offsetWidth
      while d < c.minSize and b and !a._lazysizesWidth
        d = b.offsetWidth
        b = b.parentNode
      d

    y = do ->
      `var a`
      `var c`
      `var d`
      `var e`
      a = undefined
      c = undefined
      d = []

      e = ->
        `var b`
        b = undefined
        a = !0
        c = !1
        while d.length
          b = d.shift()
          b[0].apply(b[1], b[2])
        a = !1
        return

      (f) ->
        if a then f.apply(this, arguments) else d.push([
          f
          this
          arguments
        ])
        c or c = !0
        (if b.hidden then j else k)(e)

        return

    z = (a, b) ->
      if b then (->
        y a
        return
      ) else (->
        `var b`
        `var c`
        b = this
        c = arguments
        y (->
          a.apply b, c
          return
        )
        return
      )

    A = (a) ->
      `var b`
      `var c`
      `var d`
      `var f`
      `var g`
      `var h`
      `var i`
      b = undefined
      c = 0
      d = 125
      f = 999
      g = f

      h = ->
        b = !1
        c = e.now()
        a()
        return

      i = if l then (->
        l(h, timeout: g)
        g != f and (g = f)
        return
      ) else z((->
        j h
        return
      ), !0)
      (a) ->
        `var f`
        f = undefined
        (a = a == !0) and (g = 66)
        b or b = !0
        f = d - (e.now() - c)
        0 > f and (f = 0)
        if a or 9 > f and l then i() else j(i, f)

        return

    B = (a) ->
      `var b`
      `var c`
      `var d`
      `var f`
      `var g`
      b = undefined
      c = undefined
      d = 99

      f = ->
        b = null
        a()
        return

      g = ->
        `var a`
        a = e.now() - c
        if d > a then j(g, d - a) else (l or f)(f)
        return

      ->
        c = e.now()
        b or (b = j(g, d))
        return

    C = do ->
      `var f`
      `var k`
      `var l`
      `var n`
      `var o`
      `var x`
      `var C`
      f = undefined
      k = undefined
      l = undefined
      n = undefined
      o = undefined
      x = undefined
      C = undefined
      E = undefined
      F = undefined
      G = undefined
      H = undefined
      I = undefined
      J = undefined
      K = undefined
      L = undefined
      M = /^img$/i
      N = /^iframe$/i
      O = 'onscroll' of a and !/glebot/.test(navigator.userAgent)
      P = 0
      Q = 0
      R = 0
      S = 0

      T = (a) ->
        R--
        a and a.target and t(a.target, T)
        (!a or 0 > R or !a.target) and (R = 0)
        return

      U = (a, c) ->
        `var e`
        `var f`
        `var g`
        e = undefined
        f = a
        g = 'hidden' == w(b.body, 'visibility') or 'hidden' != w(a, 'visibility')
        F -= c
        I += c
        G -= c
        H += c
        while g and (f = f.offsetParent) and f != b.body and f != d
          g = (w(f, 'opacity') or 1) > 0
          g and 'visible' != w(f, 'overflow') and e = f.getBoundingClientRect()
          g = H > e.left and G < e.right and I > e.top - 1 and F < e.bottom + 1

        g

      V = ->
        `var a`
        `var b`
        `var e`
        `var g`
        `var i`
        `var j`
        `var m`
        `var n`
        `var p`
        a = undefined
        b = undefined
        e = undefined
        g = undefined
        i = undefined
        j = undefined
        m = undefined
        n = undefined
        p = undefined
        if (o = c.loadMode) and 8 > R and (a = f.length)
          b = 0
          S++
          null == K and 'expand' of c or (c.expand = if d.clientHeight > 500 then 500 else 400)
          J = c.expand
          K = J * c.expFactor

          if K > Q and 1 > R and S > 3 and o > 2 then Q = K
          S = 0
        else (Q = if o > 1 and S > 2 and 6 > R then J else P)
        while a > b
            if f[b] and !f[b]._lazyRace
              if O
                if (n = f[b][h]('data-expand')) and (j = 1 * n) or (j = Q)
                  p != j and C = innerWidth + j * L
                  E = innerHeight + j
                  m = -1 * j
                  p = j

                  e = f[b].getBoundingClientRect()
                  (I = e.bottom) >= m and (F = e.top) <= E and (H = e.right) >= m * L and (G = e.left) <= C and (I or H or G or F) and (l and 3 > R and !n and (3 > o or 4 > S) or U(f[b], j))

                  if ba(f[b])
                    i = !0
                    R > 9

                    break
                else
                  !i and l and !g and 4 > R and 4 > S and o > 2 and (k[0] or c.preloadAfterLoad) and (k[0] or !n and (I or H or G or F or 'auto' != f[b][h](c.sizesAttr))) and (g = k[0] or f[b])
              else
                ba f[b]
            b++
          g and !i and ba(g)
        return

      W = A(V)

      X = (a) ->
        r(a.target, c.loadedClass)
        s(a.target, c.loadingClass)
        t(a.target, Z)
        return

      Y = z(X)

      Z = (a) ->
        Y target: a.target
        return

      $ = (a, b) ->
        try
          a.contentWindow.location.replace b
        catch c
          a.src = b
        return

      _ = (a) ->
        `var b`
        `var d`
        `var e`
        b = undefined
        d = undefined
        e = a[h](c.srcsetAttr)
        (b = c.customMedia[a[h]('data-media') or a[h]('media')]) and a.setAttribute('media', b)
        e and a.setAttribute('srcset', e)
        b and d = a.parentNode
        d.insertBefore(a.cloneNode(), a)
        d.removeChild(a)

        return

      aa = z((a, b, d, e, f) ->
        `var g`
        `var i`
        `var k`
        `var l`
        `var o`
        `var q`
        g = undefined
        i = undefined
        k = undefined
        l = undefined
        o = undefined
        q = undefined
        (o = u(a, 'lazybeforeunveil', b)).defaultPrevented or e and (if d then r(a, c.autosizesClass) else a.setAttribute('sizes', e))
        i = a[h](c.srcsetAttr)
        g = a[h](c.srcAttr)
        f and k = a.parentNode
        l = k and m.test(k.nodeName or '')

        q = b.firesLoad or 'src' of a and (i or g or l)
        o = target: a
        q and t(a, T, !0)
        clearTimeout(n)
        n = j(T, 2500)
        r(a, c.loadingClass)
        t(a, Z, !0)

        l and p.call(k.getElementsByTagName('source'), _)
        if i then a.setAttribute('srcset', i) else g and !l and (if N.test(a.nodeName) then $(a, g) else (a.src = g))
        (i or l) and v(a, src: g)

        y(->
          a._lazyRace and delete a._lazyRace
          s(a, c.lazyClass)
          (!q or a.complete) and if q then T(o) else R--
          X(o)

          return
        )
        return
      )

      ba = (a) ->
        `var b`
        `var d`
        `var e`
        `var f`
        b = undefined
        d = M.test(a.nodeName)
        e = d and (a[h](c.sizesAttr) or a[h]('sizes'))
        f = 'auto' == e
        (!f and l or !d or !a.src and !a.srcset or a.complete or q(a, c.errorClass)) and b = u(a, 'lazyunveilread').detail
        f and D.updateElem(a, !0, a.offsetWidth)
        a._lazyRace = !0
        R++
        aa(a, b, f, e, d)
        return

      ca = ->
        `var a`
        if !l
          if e.now() - x < 999
            return undefined
          a = B(->
            c.loadMode = 3
            W()
            return
          )
          l = !0
          c.loadMode = 3
          W()
          i('scroll', (->
            3 == c.loadMode and (c.loadMode = 2)
            a()
            return
          ), !0)
        return

      {
        _: ->
          x = e.now()
          f = b.getElementsByClassName(c.lazyClass)
          k = b.getElementsByClassName(c.lazyClass + ' ' + c.preloadClass)
          L = c.hFac
          i('scroll', W, !0)
          i('resize', W, !0)
          if a.MutationObserver then new MutationObserver(W).observe(d,
            childList: !0
            subtree: !0
            attributes: !0) else d[g]('DOMNodeInserted', W, !0)
          d[g]('DOMAttrModified', W, !0)
          setInterval(W, 999)

          i('hashchange', W, !0)
          [
            'focus'
            'mouseover'
            'click'
            'load'
            'transitionend'
            'animationend'
            'webkitAnimationEnd'
          ].forEach((a) ->
            b[g] a, W, !0
            return
          )
          if /d$|^c/.test(b.readyState) then ca() else i('load', ca)
          b[g]('DOMContentLoaded', W)
          j(ca, 2e4)

          W(f.length > 0)
          return
        checkElems: W
        unveil: ba
      }
    D = do ->
      `var a`
      `var d`
      `var e`
      `var f`
      `var g`
      a = undefined
      d = z((a, b, c, d) ->
        `var e`
        `var f`
        `var g`
        e = undefined
        f = undefined
        g = undefined
        if a._lazysizesWidth = d
          d += 'px'
          a.setAttribute('sizes', d)
          m.test(b.nodeName or '')

          e = b.getElementsByTagName('source')
          f = 0
          g = e.length
          while g > f
            e[f].setAttribute 'sizes', d
            f++
        c.detail.dataAttr or v(a, c.detail)
        return
      )

      e = (a, b, c) ->
        `var e`
        `var f`
        e = undefined
        f = a.parentNode
        f and c = x(a, f, c)
        e = u(a, 'lazybeforesizes',
          width: c
          dataAttr: ! !b)
        e.defaultPrevented or c = e.detail.width
        c and c != a._lazysizesWidth and d(a, f, e, c)

        return

      f = ->
        `var b`
        `var c`
        b = undefined
        c = a.length
        if c
          b = 0
          while c > b
            e a[b]
            b++
        return

      g = B(f)
      {
        _: ->
          a = b.getElementsByClassName(c.autosizesClass)
          i('resize', g)
          return
        checkElems: g
        updateElem: e
      }

    E = ->
      E.i or E.i = !0
      D._()
      C._()
      return

    return do ->
      `var b`
      `var d`
      b = undefined
      d = 
        lazyClass: 'lazyload'
        loadedClass: 'lazyloaded'
        loadingClass: 'lazyloading'
        preloadClass: 'lazypreload'
        errorClass: 'lazyerror'
        autosizesClass: 'lazyautosizes'
        srcAttr: 'data-src'
        srcsetAttr: 'data-srcset'
        sizesAttr: 'data-sizes'
        minSize: 40
        customMedia: {}
        init: !0
        expFactor: 1.5
        hFac: .8
        loadMode: 2
      c = a.lazySizesConfig or a.lazysizesConfig or {}
      for b of d
        b of c or (c[b] = d[b])
      a.lazySizesConfig = c
      j(->
        c.init and E()
        return
      )
      return

    cfg: c
      autoSizer: D
      loader: C
      init: E
      uP: v
      aC: r
      rC: s
      hC: q
      fire: u
      gW: x
      rAF: y

  return
)
