#import "@preview/ctheorems:1.1.3": *
#import "@preview/cetz:0.3.0"

#set text(lang: "ru")
#show: thmrules.with(qed-symbol: $square$)
#show math.integral: math.limits
#show math.sum: math.limits
#show math.integral: math.display
#show math.equation: math.display
#show link: underline.with(stroke: red)
#set figure.caption(separator: [:#h(1mm)])
#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}

#set page(width: 210mm, height: 297mm, margin: 1.5cm, numbering: none, number-align: right, header: [#counter(footnote).update(0)])
#set heading(numbering: "1.")

#let theorem = thmbox("теорема", "Теорема", fill: rgb("#98FB98"), stroke: 0.7pt).with(base_level: 0)
#let lemma = thmbox("лемма", "Лемма", fill: rgb("#D8BFD8"), stroke: 0.7pt).with(base_level: 0)
#let proposition = thmbox("предложение", "Предложение", fill: rgb("#FFC0CB"), stroke: 0.7pt).with(base_level: 0)
#let corollary = thmplain("следствие", "Следствие", stroke: 0.6pt, inset: 1em, radius: 0em).with(numbering: none)
#let definition = thmbox("определение", "Определение", fill: rgb("#ADD8E6"), stroke: 0.7pt).with(base_level: 0)

#let example = thmplain("пример", "Пример", stroke: 0.5pt, inset: 1em, radius: 0em).with(numbering: none)
#let fact = thmplain("факт", "Факт", stroke: 0.5pt, inset: 1em, radius: 0em).with(numbering: none)
#let proof = thmproof("доказательство", "Доказательство")

#let iff = $arrow.l.r.double.long$
#let ipath = "/Images/" //путь где картинки
#let author = rgb("#DC143C"); //цвет комментарий Павла Юрича
#let scal(fst,scn) = $angle.l fst, scn angle.r$ // скалярное произведение
#let svo = text(12pt)[#underline[_Свойства_]:\ ] //СВОйства
#let ru_alph(pattern: "а)") = { // Это всё для РУZZКОЙ нумерации
  let alphabet = "абвгдежзиклмнопрстуфхцчшщэюя".split("")
  let f(i) = {
    let letter = alphabet.at(i)
    let str = ""
    for char in pattern {
      if char == "а" {
        str += letter
      }
      else if char == "А" {
        str += upper(letter)
      }
      else {
        str += char
      }
    }
    str
  }
  f
}


//Конспект написан на основе лекций Сергея Витальевича Кислякова, прочитанных в осеннем семетре 2024-2025 учебного года. Конспект написан #link("https://t.me/ariviento")[Павлом Цыганенко].

#v(13cm)
#align(text(40pt, font: "Linux Biolinum O")[*АНАЛИЗ ФУРЬЕ*])
#v(-5mm)
#align(text(15pt, font: "Comfortaa")[_Сергей Витальевич Кисляков_])
//#v(37mm)
#align(right+bottom, image(ipath+"furry-on-cover.png", width: 30%))
#pagebreak()
//#align(center, text(20pt, font: "Comfortaa")[*СОДЕРЖАНИЕ*]) //C059 хорош
#set page(numbering: "1")
#counter(page).update(1)
//#align(center, text(17pt, font: "Roboto")[*Конспект за авторством Павла Цыганенко*])
#outline(title: "Содержание", indent: 1em,)
#pagebreak()

// Лекция 1 (04.09.2024)
= Основы
#definition[
  Топологическая группа -- наделённая топологией группа $G$, такая, что непрерывны отображения $ G times G -> G: quad (x,y) arrow.r.long.bar x y, $ $ G -> G: quad x arrow.r.long.bar x^(-1). $
]

Мы будем рассматривать только абелевы группы, более того, мы ограничимся рассмотрением таких групп как $ZZ$, $ZZ^n$, $RR$, $RR^n$, операцию в которых мы обозначаем страндартной аддитивной записью, то есть как $+$, группы $TT = {xi in CC bar.v |xi| = 1}$, $TT^n$ (с мультипликативной записью) и циклических групп $ZZ_k = {0,1,...,k-1}$.
Раз уж мы рассматриваем их как топологические группы, то следует определиться в какой топологии мы работаем. В группах $TT^n$ и $RR^n$ она будет стандартной, а в $ZZ^n$ и $ZZ_k$ дискретной. 

= Характеры
Пусть $G$ -- локально компактная абелева группа (у каждой точки есть окрестность, замыкание которой компактно).

#definition[
  Характером группы $G$ называется всякий непрерывный гомоморфизм $gamma: G -> TT$.
]
#box(stroke: (gradient.linear(..color.map.rainbow)), inset: 1em)[
#svo
+ $gamma(0) = 1$.
+ Если $gamma_1$, $gamma_2$ -- характеры, то $gamma_1 dot gamma_2$ тоже характер.
+ $inline(1/gamma) = overline(gamma)$ -- тоже характер.
+ $gamma(-x) = overline(gamma(x))$.
+ $gamma(x)gamma(-x) = gamma(0) = 1$.
]\
Отсюда следует, что характеры группы $G$ сами образуют группу относительно поточечного умножения. Единицей в этой группе является функция $gamma_0: G -> TT$, тождественно равная $1$.
Группа характеров $G$ обозначается как $hat(G)$ или $Gamma$. #text(author)[Так как шляпка в тайпсте не всегда отображается красиво, то я буду пользоваться и тем, и другим обозначением, так что не путайтесь.]
Давайте вычислим характеры основных наших групп.

== Характеры $ZZ$
Пусть $gamma$ -- характер $ZZ$ и $gamma(1)=zeta in TT$.
Тогда $gamma(n) = zeta^n #h(0.7em) forall n in ZZ$.\
Таким образом, характер $gamma$ определяется значением в точке $1$. Обратно, если $zeta in TT$, то формула $gamma(n)=zeta^n$ определяет характер $gamma_zeta$.
Заметив, что $ gamma_(zeta_1) dot gamma_(zeta_2) = gamma_(zeta_1 zeta_2) quad и quad gamma_(zeta^(-1))=(gamma_zeta)^(-1) $ мы понимаем, что $hat(ZZ)$ можно отождествить с $TT$.\
Нам будет часто удобно параметирзовать окружность отрезком $[-l,l]$:
$ x arrow.r.long.bar thick e^((i pi x)/l), quad x in [-l,l]. $
Да, точка $-1$ действительно параметирзуется дважды: значениями в $l$ и $-l$. Чаще всего мы будем брать $l$ равным $1$ или $pi$. Мы можем считать, что $x in RR$, тем самым возникает $2l$-периодическая функция, значения которой на любом отрезке длины $2l$ параметризуют окружность почти однозначно с точностью до двух точек.\
Характер $eta$, отвечающий точке $x in RR$ можно записать как $eta(n) = e^((i n pi x)/l)$ или как $eta(n) = e^(i n x)$, если $l = pi$.

== Характеры $ZZ_k$
Пусть $gamma in Gamma(ZZ_k)$. Положим $zeta = gamma(1)$. Как и прежде, $gamma(s) = zeta^s$, $s in ZZ$, однако $ 1 = gamma(0) = gamma"("underbrace(1+ dots + 1,k)")" = zeta^k, $
то есть $zeta$ -- корень $k$-ой степени из $1$. Как известно, такие корни тоже образуют циклическую группу порядка $k$, поэтому можем смело написать $Gamma(ZZ_k) = ZZ_k$.\
$ 1, #h(1mm) e^((2 pi i)/k), #h(1mm) ..., e^((2pi i t)/k), #h(1mm) ..., e^((2 pi i (k-1))/k) $ -- все корни $k$-ой степени из $1$. Характер $eta$, соответствующий точке $t in {0,dots,k-1}$ выражается как $ eta(s) = display(e^frac(2 pi i t s, k)), quad s in ZZ_k. $

== Характеры $RR$
В предыдущих примерах мы игнорировали непрерывность харакреров, так как любое отображение из пространства с дискретной топологией непрерывно.
#theorem[
Пусть $gamma: RR -> TT$ -- измеримый по Борелю гомоморфизм. Тогда $ exists! xi in RR quad gamma(x) = e^(i x xi), #h(2mm) x in RR. $
]
#proof[
+ Единственность.
  $ forall x in RR #h(2mm) e^(i x xi_1) = e^(i x xi_2) #h(2mm) arrow.l.r.double.long #h(2mm) forall x in RR #h(2mm) e^(i x (xi_1 - xi_2)) = 1. $
  Последнее выполнено тогда и только тогда, когда $x(xi_1 - xi_2)$ кратно $2 pi$ для всех $x in RR$, что, в свою очередь, бывает лишь при $xi_1 = xi_2$.
+ Существование. Раз $gamma$ измерима и ограничена и $|gamma(x)|=1$ всюду (хоть хватило бы и почти всюду), то существует $g in L^1(RR)$ (например годится $g(t) = chi_([0,1]) overline(gamma(t))$): $ integral_RR gamma(t)g(t) d t eq.not 0 $
  Приблизим $g$ функцией $h$ из класса $cal(D)(RR)$ (бесконечно дифференцируемые функции с компактным носителем), что можно сделать так как он плотен в $L^1(RR)$. Так как $ abs(integral_RR gamma(t)g(t) d t - integral_RR gamma(t) h(t) d t) <= integral_RR abs(g(t)-h(t)) d t, $
  можно считать, что $integral_RR gamma(t) h(t) d t eq.not 0$ (так как иначе правую часть можно сделать сколь угодно малой, а левая часть положительна).\
  Теперь проинтегрируем по $y$ равенство $gamma(x+y)h(y) = gamma(x)gamma(y)h(y)$:
  $ gamma(x) = (integral_RR gamma(x+y)h(y) d y)/(integral_RR gamma(y) h(y) d y) = ((gamma * h)(x))/(integral_RR gamma(y) h(y) d y). $
  В третьем семестре мы доказывали, что свёртка суммируемой и бесконечно дифференцируемой с компактным носителем бесконечно гладкая, поэтому $gamma in C^(infinity) (RR)$. Значит
  $ d/(d y) gamma(x+y) = d/(d y)(gamma(x) gamma(y)), $
  $ gamma'(x+y) = gamma(x) gamma'(y). $
  Положим в этом равенстве $y=0$, а также пусть $tau = gamma'(0)$. Тогда
  $ gamma'(x) = tau gamma(x) quad forall x in RR, $\
  откуда $gamma(x) = C e^(tau x)$ для всех $x in RR$. Из того что $gamma(0)=1$ следует, что $C=1$, а раз $abs(e^(tau x)) = 1$, то $tau = i xi, quad xi in RR$.
]
Заметим, что так как отображение $x arrow.r.long.bar e^(i x xi)$ заведомо является характером $RR$, то тем самым мы показали, что $Gamma(RR) = RR$. Отметим ещё одну популярную параметризацию $Gamma(RR)$:
$ Gamma(RR) = {x arrow.r.long.bar e^(2 pi i xi x)}_(xi in RR) $

== Характеры $TT$
Пусть $gamma$ -- характер группы $TT$. Определим $pi: RR -> TT$ -- простое вращение, $pi(s) = e^(i s)$.\
Пусть $eta(x) = gamma(pi(x))$, $x in RR$, тогда $eta in Gamma(RR)$, значит по теореме $exists! xi in RR: #h(2mm) eta(x) = e^(i xi x) #h(2mm) forall x in RR$, то есть $gamma(e^(i s)) = e^(i xi s) #h(2mm) forall s in RR$. Подставим $s = 2 pi k$: $ 1 = e^(2 pi i k xi), quad k in ZZ. $
Значит $k xi$ -- целое число для любого $k in ZZ$, а значит и $xi in ZZ$, ведь можно подставить $k = 1$. Тем самым, $ Gamma(TT) = ZZ. $

== Факты про характеры
Перечислим без доказательства пару утверждений.
- На $Gamma(G)$ можно стандартным образом ввести топологию равномерной сходимости на компактах, тем самым превратив её в локально компактную абелеву группу.\
  #theorem("Понтрягина о двойственности")[
    Для локально компактной абелевой группы $G$ имеется канонический изоморфизм $ G tilde.equiv Gamma(Gamma(G)), $
    заданный как $x arrow.r.long.bar (gamma arrow.r.long.bar gamma(x))$.
  ]
- $Gamma(G_1 times dots times G_n) = Gamma(G_1) times dots times Gamma(G_n)$.\
  Поэтому $Gamma(TT^n) = ZZ^n$ и $Gamma(RR^n) = RR^n$.\
  Все характеры на $RR^n$ имеют вид $ gamma(x_1,dots,x_n) = e^(2 pi i x_1 y_1) dot dots dot e^(2 pi i x_n y_n), $ где векторы $y = (y_1,dots,y_n)^T$ пробегают $RR^n$.\
  Для тора $TT^n$ все характеры имеют вид $ gamma(e^(i t_1),dots,e^(i t_n)) = product_(i = 1)^n e^(i k_i t_i) = e^(i angle.l k,t angle.r), quad t in RR^n, #h(2mm) k in ZZ^n. $

= Мера Хаара
//В основном дадим просто информацию.
#definition[
  Мера Хаара на локально компактной группе $G$ -- регулярная положительная борелевская мера $mu$ на $G$, конечная на компактах и инвариантная относительно сдвига: $ mu(E+x) = mu(E) quad forall E in cal(B)(G), #h(1mm) x in G. $
]
#theorem[
  Мера Хаара всегда сущестствует и любые две отличаются домножением на константу.
]
- На компактной группе меру Хаара обычно нормализуют так, что $mu(G) = 1$.
- На дискретной группе в качестве меры Хаара подходит считающая мера и обычно с ней больше ничего не делают.
- Группа $ZZ_k$ одновременно и компактна и дискретна, так что нам подходят оба варианта:
  - $(ZZ_k,m)$ -- мера каждой точки равна $inline(1/k)$.
  - $(ZZ_k,mu)$ -- мера каждой точки равна $1$.
- В $TT$ рассматривается нормированная мера Лебега $display((d theta)/(2 pi))$.
- То же самое в $TT^n$: $display((d theta_1 dots d theta_n)/(2 pi)^n)$.
- В $RR^n$ рассматривается обычная мера Лебега.

// Лекция 2 (11.09.2024)
= Свёртка
Пусть $G$ -- локально компактная абелева группа, $m$ -- мера Хаара на ней.
#definition[
  Свёртка двух измеримых функций $f$ и $g$ на $G$:
  $ (f * g)(x) = integral_G f(x-y)g(y) d m(y) $
  -- для тех $x$, для которых интеграл существует.
]
Большинство свойств свёртки уже знакомы нам из случая свёртки на $RR^n$, тем не менее, не помешает их вспомнить.

+ Пусть $1 <= p <= infinity$, #h(1mm) $f in L^(p)(G,m)$, #h(1mm) $g in L^(1)(G,m)$. Тогда свёртка $f * g$ существует почти всюду и $ norm(f * g)_(L^p) <= norm(f)_(L^p) dot norm(g)_(L^1). $
  #proof[
  - $p = infinity$. $ abs((f*g)(x)) <= integral_G abs(f(x-y)) dot abs(g(y)) d m(y) <= "ess"#h(0.7mm)"sup"(f) dot integral_G abs(g(y)) d m(y), $
    откуда $norm(f*g)_(L^infinity) <= norm(f)_(L^infinity) dot norm(g)_(L^1)$.
  - $p = 1$. $ integral_G abs((f*g)(x)) d m(x) = integral_G #h(0.5mm)lr(abs(integral_G f(x-y)g(y) d m(y))) #h(0.5mm) d m(x) <= $
    $ <= integral_G integral_G abs(f(x-y)) dot abs(g(y)) d m(y) d m(x) = integral_G abs(g(y)) integral_G abs(f(x-y)) d m(x) d m(y) = $
    $ = integral_G abs(g(y)) dot norm(f)_(L^1) d m(y) = norm(f)_(L^1) integral_G abs(g(y)) d m(y) = norm(f)_(L^1) dot norm(g)_(L^1). $
  - $1 < p < infinity$. $ norm(f * g)^p_(L^(p)) <= integral_G abs(integral_G f(x-y)g(y) d m(y))^p d m(x) <= $ $ <= integral_G abs(integral_G abs(f(x-y)) bold(1)(y) abs(g(y)) d m(y))^p d m(x) <= $ $ <= integral_G [(integral_G abs(f(x-y))^p abs(g(y)) d m(y))^(1/p) (integral_G bold(1)(y)^q abs(g(y)) d m(y))^(1/q)]^p d m(x) = $
  $ = integral_G integral_G abs(f(x-y))^p abs(g(y)) d m(y) d m(x) dot norm(g)^(p/q)_(L_(1)) = $
  $ = integral_G (integral_G abs(f(x-y))^p d m(x) ) abs(g(y)) d m(y) dot norm(g)^(p/q)_(L_(1)) = norm(f)^(p)_(L^(p)) dot norm(g)^(1 + p/q)_(L^(1)) = norm(f)^(p)_(L^(p)) dot norm(g)^(p)_(L^(1)) $
  Пояснения к вычислениям:
    - В третьей строке написано неравенство Гёльдера для меры $abs(g) d m$.
    - В пятой строчке менятеся порядок интегрирования по Тонелли -- Фубини.
    #v(2mm)
    - $display(1+ p/q = p(1/p + 1/q) = p)$.
  ]
+ $f * g = g * f$.\ Доказывается при помощи замены переменной и инвариантности меры при сдвигах.
+ $(f * g) * h = f * (g * h)$. \ Доказывается простой перестановкой интегралов и инвариантностью меры при сдвигах.
+ Если $f,g in L^2(G)$, то $f * g in L^(infinity)(G,m)$.
#proof[
  $ abs((f * g)(x)) <= integral_G abs(f(x-y)) abs(g(y)) d m(y) <= $ $ <= (integral_G abs(f(x-y))^2 d m(y))^(1/2) (integral_G abs(g(y)) d m(y))^(1/2) = norm(f)_(L^2) dot norm(g)_(L^2) $
]
Когда мера Хаара фиксирована или ясна из контекста, часто пишут $d y$ вместо $d m(y)$.\
Как устроена свёртка в $RR^n$ мы поняли в третьем семестре, теперь разберемся с другими нашими примерами, а конкретно с $ZZ$ и $TT$.
- На $ZZ$ мера Хаара считающая, то есть мера каждой точки -- единица.
  $ f in L^p (ZZ,m) #h(2mm) arrow.l.r.double.long #h(2mm) integral_ZZ abs(f(k))^p d m(k) < +infinity, $
  то есть просто $norm(f)_p^p = sum_(k in ZZ) abs(f(k))^p < +infinity$. Это пространство часто обозначают как $l^p = l^p (ZZ)$.\
  Пусть, например, $p=1$, тогда для $x = {x_n}$, $y = {y_n} in l^1$:
  $ (x * y)(k) = sum_(i in ZZ) x(k-i) y(i) = sum_(i in ZZ) x_(k-i) y_i. $
  $l^1$ со свёрткой является алгеброй с единицей: $ delta_0(k) = cases(
    1"," quad k = 0\
    0"," quad k eq.not 0
  ) $
- Теперь пусть $f$ и $g$ --  функции на окружности. Тогда $ (f * g)(xi) = (1/(2pi)) integral_(TT) f(xi eta^(-1)) g(eta) d eta, quad xi in TT. $

Понятно, что функции на окружности находятся во взаимно однозначном соответствии с\ $2 pi$-периодическими функциями на $RR$. Давайте поймём как их интегрировать.
#figure(rect[#image(ipath+"chzh.jpg", width: 25%)], caption: [май хонест риэкшон])
Пусть $I = [a,b]$ -- любой отрезок длины $2 pi$. Простое вращение отображает этот отрезок на $TT$ взаимно однозначно с точностью до концов (однако две точки -- множество меры ноль, в нашем случае). Ясно также, что при этом отображении мера Лебега на $I$ переходит в меру Лебега на $TT$, поэтому $ 1/(2 pi) integral_TT h(xi) d mu(xi) = 1/(2 pi) integral_a^b h(e^(i x)) d x. $
Соответственно, формула для свёртки превращается в формулу свёртки для $2 pi$ -- периодических функций на $RR$.
$ (u * v)(x) = 1/(2 pi) integral_a^b u(x-y) v(y) d y $
Несмотря на то, что $x-y$ может выйти за пределы отрезка $I$, всё в порядке из-за периодичности.\
В алгебрах $L^1 (RR^n)$ и $L^1 (TT^n)$ со свёрткой в качестве умножения нет единицы. Зато есть аппроксимативные единицы, мы видели их прежде и вновь поговорим про них позже, когда они понадобятся. Как раз при помощи свёртки с аппроксимативной единицей в третьем семестре мы доказывали, что функции класса $cal(D)(RR^n)$ плотны в $L^p (RR^n)$ при $1 <= p < +infinity$. Давайте теперь посмотрим что происходит на окружности.
#theorem[
  + $C^infinity (TT)$ плотно в $L^p (TT)$ при $1 <= p < +infinity$.
  + $C^infinity (TT)$ плотно в $C(TT)$ равномерно.
]
#proof[
  Докажем пункт 2. Пусть $f in C(TT)$, рассмотрим её как функцию на $[-pi,pi]$. Тогда $f(-pi) = f(pi) = c$. Достаточно приблизить функцию $h = f - c$ бесконечно дифференцируемой с компактным носителем, лежащим строго внутри отрезка $[-pi,pi]$, и дальше мы сможем продолжить её по периодичности на всю прямую.\
  Пусть $epsilon > 0$ и $abs(h(x)) < epsilon$ в $delta$-окрестностях точек $-pi$ и $pi$. Изменим в этих окрестностях функцию $h$, чтобы получилось вот так:
  $ tilde(h)(x) = cases(
  0" ," quad pi - abs(x) < delta/2,
  (pi - abs(x))h("sgn"(x) dot (pi-delta))" ," quad delta/2 <= pi - abs(x) <= delta,
  h(x)", " quad pi - abs(x) > delta) $
  Запись несколько мудрёная, на самом деле мы просто отступили на $inline(delta/2)$ от концов отрезка и достроили по линейности. Ясно, что $ abs(tilde(h)(t) - h(t)) < 2epsilon quad forall t in [-pi,pi]. $
  Теперь достаточно приблизить $tilde(h)$ вместо $h$. Продолжив функцию $tilde(h)$ нулём за пределы отрезка $[-pi,pi]$, мы получим непрерывную функцию на $RR$ с компактным носителем, лежащим строго внутри $[-pi,pi]$, в таком определении $tilde(h)$, как выше, это уже сделано. Теперь пусть $ g in cal(D)(RR), quad integral_RR g = 1, quad g_t (x) = 1/t #h(0.7mm) g(x/t). $
  В третьем семестре мы видели, что $tilde(h) * g_t arrow.long tilde(h)$, и свёртка лежит в нужном нам классе, откуда мы и получаем нужное приближение. Теперь разберёмся с первым пунктом. Но в нём всё ещё проще, потому что мы можем просто отрезать от функции по маленькому кусочку вблизи $-pi$ и $pi$ и с оставшейся частью проделать то же самое.
]

= Преобразование Фурье
Пусть $G$ -- локально компактная абелева группа с мерой Хаара $lambda$, $f in L^1 (lambda)$.
#definition[
  Преобразование Фурье функции $f$ -- функция на группе $Gamma = hat(G)$:
  $ (cal(F) f)(gamma) = hat(f)(gamma) = integral_G f(x) overline(gamma(x)) d lambda(x) = integral_G f(x) gamma(-x) d lambda(x). $
]
Напишем также формулу для обратного преобразования Фурье: $ caron(f)(gamma) = integral_G f(x) gamma(x) d lambda(x) = hat(f) (gamma^(-1)). $

#proposition[
  Если $f, #h(1mm) g in L^1 (G)$, то $hat(f*g) = hat(f) dot hat(g)$.
]
#proof[
  Пусть $gamma in Gamma$.
  $ hat(f * g)(gamma) = integral_G overline(gamma(x)) integral_G f(x-y) g(y) d y d x = $
  $ = integral_G integral_G overline(gamma(x-y)) dot overline(gamma(y)) dot f(x-y) g(y) d x d y = integral_G (integral_G overline(gamma(x-y)) f(x-y) d x) g(y) overline(gamma(y)) d y = $
  $ = integral_G (integral_G f(x) overline((gamma(x))) d x) g(y) overline(gamma(y)) d y = integral_G f(x) overline(gamma(x)) d x dot integral_G g(y) overline(gamma(y)) d y. $
]
Мы будем часто обсуждать равенство $(hat(f))^(or) = f$, которое, в общем, неверно, потому что $hat(f)$ попросту может быть несуммируемой функцией на $Gamma$ (хотя можно интерпретировать так, что станет верным, через какие-то ухищрения).
Заметим, что "$or$" в нём относится к группе $Gamma$ (меру Хаара на которой обозначим через $rho$):
$ caron(g) (x) = integral_Gamma g(y) gamma(x) d rho(gamma). $
Но подробнее об этом потом. А сейчас взглянём на примеры преобразования Фурье.

== Преобразование Фурье в $ZZ$
Пусть $f in L^1 (ZZ,m)$, где $m$ -- считающая мера. Как мы поняли раньше, $Gamma = TT$.
$ hat(f) (xi) = sum_(n in ZZ) f(n) xi^(-n), quad xi in TT $
Или в иной записи:
$ hat(f) (e^(i theta)) = sum_(n in ZZ) f(n) e^(-i n theta), $
$ caron(f) (e^(i theta)) = sum_(n in ZZ) f(n) e^(i n theta). $
Причём так как $sum_(n in ZZ) abs(f(x)) < +infinity$, то сходимость абсолютная.

== Преобразование Фурье в $TT$
Пусть $f in L^1(TT, inline((d theta)/(2 pi)))$. Ранее вы выяснили, что $hat(TT) = ZZ$. Тогда $hat(f)$ есть функция на $ZZ$, то есть двухсторонняя последовательность:
$ hat(f)(n) = 1/(2 pi) integral_(- pi)^(pi) f(e^(i t)) e^(-i n t) d t, quad n in ZZ. $

Формула $(hat(f))^(or) = f$ в этом случае не является буквально верной, но должна выглядеть так:
$ f(e^(i t)) = sum_(n in ZZ) hat(f)(n) e^(i n t). $
Этот ряд называется _рядом Фурье_, и составить его можно независимо от того, сходится он или нет.\
Перед тем, как двигаться дальше, стоит напомнить некоторый результат из функционального анализа, который нам ещё не раз понадобится.
#theorem("Стоуна-Вейерштрасса")[
  Пусть $K$ -- компакт, $B$ -- самосопряжённая подалгебра в $C(K)$, содержащая константы и разделяющая точки: $ k_1, k_2 in K, #h(2mm) k_1 eq.not k_2 #h(4mm) arrow.double #h(4mm) exists h in B : h(k_1) eq.not h(k_2). $
  Тогда алгебра $B$ плотна в $C(K)$ в смысле равномерной сходимости.
]<stoun>
#theorem("о единственности")[
  Если $f in L^1 (TT)$ и $hat(f)(n) = 0$ для всех $n in ZZ$, то $f = 0$.
]
#proof[
  $ Phi(g) = 1/(2 pi) integral_TT f(t) g(t) d t $ -- линейный непрерывный функционал на $C(TT)$. По условию он обращается в ноль на всех экспонентах $t arrow.r.long.bar e^(- i n t)$.\
  Линейная оболочка этих экспонент -- самосопряжённая подалгебра в $C(TT)$, содержащая функцию 1 и разделяющая точки окружности (ведь уже функция $e^(i t)$ разделяет). По #link(<stoun>)[теореме Стоуна-Вейерштрасса] она плотна в $C(TT)$. Следовательно, $Phi = 0$, а тогда $f = 0$.
]

== Преобразование Фурье в $RR$
Пусть $f in L^1 (RR)$, #h(1mm) $xi in hat(RR) = RR$, тогда $ hat(f)(xi) = integral_(-infinity)^(+infinity) f(x) e^(-2 pi i x xi) d x. $
Формула обращения (верная далеко не всегда), должна выглядеть так: $ f(x) = integral_(-infinity)^(+infinity) hat(f)(xi) e^(2 pi i x xi) d xi. $

== Преобразование Фурье в $RR^n$
Пусть $f in L^1 (RR^n)$, #h(1mm) $xi in Gamma(RR^n) = RR^n$, тогда $ hat(f)(xi) = integral_(RR^n) f(x) e^(-2 pi i angle.l x, xi angle.r) d x. $

#example[
  Рассмотрим функцию $f = chi_([-1,1])$ в $RR$, тогда $ hat(f)(xi) = integral_(-1)^(1) e^(-2 pi i x xi) d x = integral_(-1)^(1) cos 2 pi x xi d x = lr(1/(2 pi xi) sin 2 pi x xi #h(1mm) |)_(-1)^(#h(0.7mm)1) = frac(1,pi xi) sin 2 pi xi, $
  мы получили не суммируемую функцию, так что формулу обращения вообще не написать.
]
Некоторое время будем заниматься окружностью $TT$, снабдив её нормированной мерой Лебега $frac(d theta, 2 pi) = m$.

= Ортогональность
== Ортогональность характеров
Пусть $mu$ -- произвольная неотрицательная мера на пространстве $S$. Тогда на пространстве $L^2 (mu)$ можно стандартным образом ввести скалярное произведение: $ angle.l f, g angle.r = integral_S f(t) overline(g(t)) d mu(t). $
В частном случае, когда $S = {1,dots,n}$, а мера $mu$ считающая, для $a = {a_j}_(j=1)^n$, #h(1mm) $b = {b_j}_(j=1)^n$:
$ angle.l a,b angle.r = sum_(j=1)^n a_j overline(b_j). $
Это отличается от того, что было на первом курсе комплексным сопряжением над $b$, потому что тогда мы работали с $RR^n$, а сейчас с $CC^n$, #text(author)[но кому я это пишу, это и так понятно.]
$ scal(f,f) = norm(f)_(L^2 (mu)), quad scal(f,g) = overline(scal(g,f)). $
Также вспомним неравенство Коши-Буняковского (частный случай неравенства Гёльдера): $ abs(scal(f,g)) <= norm(f)_(L^2 (mu)) dot norm(g)_(L^2 (mu)). $

#proposition[
  Пусть $G$ -- компактная абелева группа с нормированной мерой Хаара $lambda$. Тогда для любого характера $gamma$ на $G$ $ integral_G gamma d lambda = cases(1",  если" gamma eq.triple 1, 0",  иначе") $
]
#proof[
  Пусть $x, y in G$. Проинтегрируем равенство $gamma(x+y) = gamma(x) gamma(y)$ по $y$: $ gamma(x) integral_G gamma(y) d lambda(y) = integral_G gamma(x+y) d lambda(y) = integral_G gamma(y) d lambda(y). $
  Тогда если $gamma(x) eq.not 1$ хотя бы для одного $x$, то искомый интеграл равен нулю.
]

#corollary[
  Если $gamma_1$, $gamma_2$ -- различные характеры, то $scal(gamma_1,gamma_2) = 0.$
]
#proof[
  Действительно, $gamma_1 overline(gamma_2)$ -- тоже характер, причём раз $gamma_1$ и $gamma_2$ различны, то он не тождественная единица, а значит $ integral_G gamma_1(t) overline(gamma_2(t)) d lambda(t) = 0. $
]

#definition[
  Две функции $f, g in L^2 (mu)$ называются ортогональными, если $ scal(f,g) = 0. $
]
#text(author)[Кто бы мог подумать.]

Таким образом, характеры компактной абелевой группы попарно ортогональны, более того, если мера Хаара сама нормированна, то характеры тоже: $ norm(gamma)_(L^2 (mu)) = scal(gamma,gamma) = integral_G bold(1) d lambda = 1. $
#figure(rect[#image(ipath+"anti-furry.jpg", width: 40%)], caption: [⊂(◉‿◉)つ])

// Лекция 3 (18.09.2024)
== Ортонормированные системы
Опять же многие нижеизложенные вещи нам будут известны, но а что вы хотели.\
Пусть $(S,mu)$ -- пространство с мерой.
#definition[
  Семейство функций ${f_j}_(j in cal(I)) subset.eq L^2(S,mu)$ называется ортонормированной системой, если $ norm(f_j)_(L^2) = 1 quad forall j in cal(I), $ $ scal(f_j,f_k) = 0 quad forall j eq.not k. $
]
Например, характеры окружности ${e^(i k theta)}_(k in ZZ)$ -- ортонормированная система на $[-pi,pi]$, если мера Лебега нормированная. То же самое работает на любом отрезке длины $2 pi$.
#definition[
  Коэффициентами Фурье функции $f in L^2(mu)$ по ортонормированной системе ${f_j}_(j in cal(I))$ называются $c_j = scal(f,f_j)$.\
  Рядом Фурье функции $f$ по данной ортонормированной системе называется $sum_(j in cal(I)) c_j f_j.$
]
Ближайшей нашей целью является увидеть, что ряд Фурье всегда сходится по норме пространства $L^2(mu)$.
#theorem("Пифагор")[
  Пусть $f,g in L^2(mu)$ ортогональны, тогда $ norm(f+g)_(L^2)^2 = norm(f)_(L^2)^2 + norm(g)_(L^2)^2. $
]
#proof[
  $ norm(f+g)^2 = scal(f+g,f+g) = scal(f,g) + scal(f,g) + scal(g,f) + scal(g,g) = norm(f)^2 + norm(g)^2. $
]
#svo
- Пусть ${f_j}_(j in cal(I))$ -- ортонормированная система, $j_1,dots,j_k in cal(I)$ -- конечный набор индексов. Тогда $ f - sum_(s = 1)^k c_(j_s) f_(j_s) perp f_(j_t) quad "при " t = 1, dots, k. $
  Действительно, $ scal(f - sum_(s = 1)^k c_(j_s) f_(j_s),f_(j_t)) = scal(f,f_(j_t)) - sum_(s=1)^k c_(j_s) scal(f_(j_s),f_(j_t)) = scal(f,f_(j_t)) - c_(j_t) = 0. $
- Тем самым, если $g = sum_(s=1)^k c_(j_s) f_(j_s)$, то $f-g perp g$. По теореме Пифагора $ norm(f)^2 = norm(f-g)^2 + norm(g)^2 >= norm(g)^2. $
- Если ${e_1,dots,e_k}$ -- конечная ортонормированная система, а $d_1,dots,d_k$ -- комплексные числа, то вновь по теореме Пифагора $ norm(d_1 e_1 + dots + d_k e_k)^2 = abs(d_1)^2 + dots + abs(d_k)^2. $
- Таким образом, из двух предыдущих пунктов следует, что $ norm(g)^2 = abs(c_(j_1))^2 + dots + abs(c_(j_k))^2, $ и получается $ abs(c_(j_1))^2 + dots + abs(c_(j_k))^2 <= norm(f)^2. $
  Следовательно, числа ${abs(c_j)^2}_(j in cal(I))$ образуют суммируемое семейство, при этом выполняется неравенство Бесселя:
  #align(center)[#box(stroke: (paint: blue, thickness: 2pt, dash: "dashed"), radius: 10cm, inset: 1.5em)[$ sum_(j in cal(I)) abs(c_j) <= norm(f)^2 $]]
  Далее мы докажем, что здесь всегда достигается равенство. А пока вернёмся к общей ситуации.\
Пусть ${f_j}_(j in A)$ -- ортонормированная система в $L^2 (S,mu)$, причём $A$ счётно.\ Пусть $A_1 subset.eq A_2 subset.eq dots$ -- конечные множества, дающие в объединении всё $A$: $ union.big_(k >= 1)A_k = A. $
Тогда частичные суммы $display(sigma_k = sum_(j in A_k)c_j f_j)$ сходятся ($c_j$ -- коэффициенты Фурье функции $f$).\
Действительно, пусть $l > k$, тогда $ norm(sigma_l - sigma_k)_(L_2 (mu))^2 = sum_(j in A_l without A_k) abs(c_j)^2 arrow.long_(k arrow infinity) 0. $
Значит частичные суммы сходятся благодаря критерию Коши. То есть ряд сходится безусловно: можно суммировать не подряд, а по любой системе конечных множеств.\ Что можно сказать про сумму этого ряда?\
Пусть $H$ -- замыкание линейной оболочки векторов ${f_j}$. Разумеется, сумма $sigma$ этого ряда лежит в $H$. При этом $f - sigma perp f_j$ при всех $j$.
Действительно, если $u_k, u, v in L^2$ и $u_k arrow.long_(L^2) u$, то $ abs(scal(u,v)-scal(u_k,v)) = abs(scal(u-u_k,v)) <= norm(u-u_k) dot norm(v) arrow.long 0. $
Поэтому $display(scal(f - sigma,f_j) = lim_(k arrow infinity) scal(f-sigma_k,f_j))$, а тут получаем ноль как только $A_k in.rev j$.
#proposition[
  Разложение функции $f in L^2 (S,mu)$ на составляющие $f = u + v$, где $u in H$, а $v perp H$ единственно.
]
#proof[
  Пусть есть ещё одно такое разложение: $f = u_1 + v_1$. Тогда $u + v = u_1 + v_1$, положим $w = v-v_1 = u_1-u$. Получается, что $w in H$ и $w perp H$, значит $w perp w$, тогда $norm(w)_(L^2)^2 = 0$.
]
#definition[
  Ортонормированная система ${f_j}_(j in cal(I))$ в $L^2(mu)$ называется полной, если замыкание её линейной оболочки совпадает с $L^2(mu)$.
]

#set enum(numbering: ru_alph())
#theorem[
  Следующие условия эквивалентны:
  + Ортонормированная система ${f_j}_(j in cal(I))$ полна.
  + Если $u in L^2 (mu)$ и $scal(u,f_j) = 0$ при всех $j in cal(I)$, то $u=0$.
  + Выполнено равенство Парсеваля: $ norm(u)^2 = sum_(j in cal(I)) abs(scal(u,f_j))^2 quad forall u in L^2 (mu). $
  + Ряд Фурье $sum_(j in cal(I)) scal(u,f_j) f_j$ всякой функции $u in L^2 (mu)$ сходится к $u$.
]
#proof[
  Пусть $H$ -- замыкание линейной оболочки системы ${f_j}_(j in cal(I))$. Мы уже поняли, что если $f in L^2(mu)$, то ряд $sum_(j in cal(I)) scal(f,f_j) f_j$ сходится к некоторой функции $g$ такой, что $f-g perp H$.
  - $"а" arrow.double "г."quad$По условию $H = L^2(mu)$, значит $f-g perp f-g$, из чего следует $f=g$.
  - $"г" arrow.double "а."quad$ Любая функция приближается частичными суммами ряда Фурье.
  - $"б" arrow.double "г."quad$ $f-g perp H$, значит $f = g$, то есть ряд Фурье сходится к $f$.
  - $"г" arrow.double "б."quad$ Ряд Фурье функции $u$ нулевой, значит сходится к нулю. Следовательно, $u = 0$.
  - $"г" arrow.double "в."quad$ Для $F subset.eq cal(I)$, $abs(F) < infinity$ следующее выражение стремится к $norm(u)^2$: $ sum_(j in F) abs(scal(u,f_j))^2 = lr(norm(#h(1mm)sum_(j in F) scal(u,f_j)f_j#h(1mm))#h(1mm))^2 $
  - $"в" arrow.double "б."quad$ Если все $scal(u,f_j)$ равны нулю, то по равенству Парсеваля $norm(u)^2 = 0$, откуда $u=0$.
]
#set enum(numbering: "1.")
Переходим к окружности (точнее, к отрезку $[-pi,pi]$ или вообще любому отрезку длины $2 pi$), мера Лебега на которой нормированна: $inline(frac(d theta, 2 pi))$.
Когда изучают ряды Фурье, принято рассматривать поведение симметричных частичных сумм ряда $ f tilde sum_(n in ZZ) hat(f)(n) e^(i n t), $
$ S_N f(t) = sum_(abs(n) <= N) hat(f)(n) e^(i n t) $
$ hat(f)(n) = 1/(2 pi) integral_(-pi)^(pi) f(s) e^(-i n s). $
Систему характеров окружности ${e^(i n t)}$ очень часто называют _тригонометрической системой_, как мы знаем, она ортонормированна.\
Коэффициенты Фурье определены для $f in L^1([-pi,pi])$, но сейчас мы займёмся $L^2$-теорией. Заметим, что $L^2([-pi,pi]) subset.eq L^1([-pi,pi])$, так как для конечных мер в принципе выполнено $L^q subset.eq L^p$ для $1<=p<=q<=infinity$, поэтому так-то проблем нет, но...\
На $RR$ будет не так: нам захочется понять, что такое $hat(f)$ для $f in L^2(RR)$, но формула $ hat(f)(xi) = integral_RR f(x) e^(-2 pi i xi x) d x $ неприемлима, вообще говоря, поскольку $L^2(RR) subset.eq.not L^1(RR)$.\
Из общих соображений мы знаем неравенство Бесселя: $ sum_(n in ZZ) abs(hat(f)(n))^2 <= 1/(2 pi) integral_(-pi)^(pi) abs(f(t))^2 d t, $ а верно ли равенство Парсеваля? То есть полна ли тригонометрическая система в $L^2([-pi,pi])$? Если вкратце: да, а подробнее
#theorem[
  Система ${e^(i n t)}_(n in ZZ)$ является полной в $L^2([-pi,pi])$.
]<polnota>
#proof[
  Тригонометрические полиномы образуют самосопряжённую подалгебру $cal(P)$ в $C(TT)$ (чтобы получить сопряжённую функцию достаточно заменить все $n$ на $-n$).\
  Уже функция $e^(i t)$ разделяет точки. Несмотря на то, что она принимает одинаковые значения в точках $pi$ и $-pi$, этим точкам отрезка соответствует одна и та же точка на окружности. Тогда по #link(<stoun>)[теореме Стоуна-Вейерштрасса] тригонометрические полиномы плотны в $C(TT)$, и раз они плотны по равномерной метрике, то и по метрике $L^2$ тоже. В свою очередь $C(TT)$ плотно в $L^2([-pi,pi])$ и тем самым мы получили требуемое.
]

= Частичные суммы
== Ядро Дирихле

Пусть $f in L^2([-pi,pi])$. Распишем чему равны частичные суммы ряда Фурье:
$ S_N f(x) = sum_(abs(k) <= N) hat(f)(k) e^(i k x) = sum_(abs(k) <= N) 1/(2 pi) integral_(-pi)^(pi) f(t) e^(-i k t) d t dot e^(i k x) = $
$ = 1/(2 pi) integral_(-pi)^pi f(t) sum_(abs(k) <= N) e^(-i k t) e^(i k x) d t = 1/(2 pi) integral_(-pi)^pi f(t) sum_(abs(k) <= N) e^(i k (x-t)) d t $
Тогда в последней формуле виднеется некоторая свёртка. Можем определить ядро Дирихле как $ D_N (v) = sum_(abs(k) <= N) e^(i k v), $ на самом деле это просто некоторый тригонометрический полином, такой, что
$ S_N f = f * D_N, $ $ S_N f(x) = 1/(2 pi) integral_(-pi)^pi f(t) D_N (x-t) d t. $
// ИСПРАВИТЬ: выровнять мужиков
#figure(
    grid(
        columns: (auto, auto),
        rows:    (auto, auto),
        gutter: 1em,
        figure(image(ipath+"Dirichlet.jpg", width: 60%), numbering: none, caption: [а) Петер Густав Лежён Дирихле (1805 -- 1859)]),
        figure(image(ipath+"Fourier.jpeg", width: 60%), numbering: none, caption: [б) Жан-Батист Жозеф Фурье (1768 -- 1830)]),
      ),
    caption: [мужики])
Посчитаем формулу для ядра Дирихле:
$ D_N (v) = e^(-i N v) (1 + e^(i v) + dots + e^(2 N i v)) = e^(-i N v) dot frac(e^((2 N + 1) i v )-1, e^(i v) - 1) = $
$ = frac(e^((N + 1) i v) - e^(- N i v), e^(i v) - 1) = frac(e^((N + 1/2) i v) - e^(-(N + 1/2) i v), e^(frac(i v, 2)) - e^(-frac(i v,2))) = frac(2 i sin (N+1/2)v, 2 i sin frac(v,2)) = frac(sin (N+1/2) v, sin frac(v,2)). $
На отрезке $[-pi,pi]$ знаменатель обращается в ноль лишь при $v = 0$, и вблизи нуля эта дробь близка к $2N + 1$. Также нетрудно видеть, что $ integral_(-pi)^(pi) D_N (u) d u = integral_(-pi)^(pi) sum_(abs(k) <= N) e^(i k u) d u = sum_(abs(k) <= N) integral_(-pi)^(pi) e^(i k u) d u = 2 pi + sum_(0 < abs(k) <= N) lr(e^(i k u)/(i k) |)_(-pi)^(pi) = 2 pi. $
Тем самым, $ 1/(2 pi) integral_(-pi)^(pi) D_N (u) d u = 1. $
//Довольно легко сосчитать (и возможно мы это потом сделаем), что

== Сходимость частичных сумм
Как можно пытаться проверить, что для данной точки $S_N f(x) arrow.long A$?
$ S_N f(x) - A = f * D_N - A = 1/(2 pi) integral_(-pi)^(pi) f(x-y) D_N (y) d y - A/(2 pi) integral_(-pi)^(pi) D_N (y) d y = $
$ = 1/(2 pi) integral_(-pi)^(pi) (f(x-y)-A) D_N (y) d y = 1/(2 pi) integral_(-pi)^(pi) frac(f(x-y)-A, sin frac(y,2)) dot sin (N+1/2) y d y. $
#lemma("Римана-Лебега")[
  Пусть $f in L^1(RR)$. Тогда $ lim_(M arrow infinity) integral_RR f(x) cos M x = 0, $ $ lim_(M arrow infinity) integral_RR f(x) sin M x = 0. $
]<lrl>
#proof[
  Докажем для синуса (с косинусом всё аналогично).
  + Пусть сначала $f in D(RR)$ и $"supp"f subset.eq [-a,a]$. Тогда
    $ integral_(-a)^(a) f(x) sin M x d x = -integral_(-a)^(a) frac(f(x),M) d (cos M x) = -frac(1,M) integral_(-a)^(a) f'(x) cos M x d x + lr(1/M f(x) cos M x |)_(-a)^a $
    По модулю это выражение не превосходит $inline(C/M)$, где $C$ -- некоторая константа. Тем самым исходный интеграл стремится к нулю при $M arrow infinity$.
  + Теперь докажем общий случай. Тогда $f$ можно приближать функциями $g in D(RR)$ с компактным носителем.
    $ abs(integral_RR f(x) sin M x d x) <= integral_RR abs(f(x)-g(x)) d x + abs(integral_RR g(x) sin M x d x) <= 2 epsilon. $
    То есть первое слагаемое можно сделать сколь угодно маленьким выбирая $g$, а второе стремится к нулю при $M arrow infinity$.
]
Вернёмся теперь к тому, что мы делали выше. Теперь нам видно, что если функция $ y arrow.long.bar frac(f(x-y)-A,sin y/2) $ оказалась суммируемой на отрезке $[-pi,pi]$, то $S_N f(x) arrow.long A$. Но нам мешает знаменатель: $inline(sin y/2 tilde y/2)$ при $y arrow 0$, следовательно у $inline(1/(sin y/2))$ в нуле несуммируемая особенность, но она может компенсироваться, если знаменатель мал.
#theorem[
  Пусть $f in L^1([-pi,pi])$, $2pi$-периодична ($f(pi)=f(-pi)$) и удовлетворяет условию Липшица порядка $alpha>0$ в точке $x$: $ abs(f(x-y)-f(x)) <= C abs(y)^alpha. $ Тогда $S_N f(x) arrow.long f(x)$.
]<th-10>
#proof[
  $frac(abs(f(x-y)-f(x)),abs(sin y/2)) <= C abs(y)^(alpha-1)$, а это суммируемая функция. Искомое стремление $S_N f(x)$ к $f(x)$ следует из сказанного выше.
]
Можно сказать, что сходимость здесь равномерная, если (например) $f$ непрерывно дифференцируема всюду. Это условие можно ещё ослабить, но мы наоборот, докажем нечто достаточно грубое.
#fact[
  Если $f$ $2pi$-периодична и дважды непрерывно дифференцируема, то $S_N f arrows f$.
]<fact1>
Отложим ненадолго доказательство, и скажем пока почему множество тригонометрических полиномов $cal(P)$ плотно в $C(TT)$ в смысле равномерной сходимости. Мы уже #link(<polnota>)[видели] это, но в доказательстве использовали #link(<stoun>)[теорему Стоуна-Вейерштрасса]. Теперь мы обойдёмся без неё. #footnote[зато будем использовать пока даже недоказанный факт, вкусно]\
Действительно, пусть $f in C(TT)$, #h(1mm) $epsilon > 0$. Найдём $g in C^2(TT)$, такую что $sup_(xi in TT) abs(f(xi)-g(xi)) < epsilon$.\
Теперь применив #link(<fact1>)[факт] мы получаем $S_N g arrows g$ и тем самым всё доказано.
#figure(rect[#image(ipath+"when.jpg",width: 25%)], caption: [honorable mention])
В частности, из всего этого следует, что если $f in L^2(TT)$, то ${hat(f)(n)}_(n in ZZ) in l^2(ZZ)$, $ f = lim_(N arrow infinity) S_N f, $ где сходимость подразумевается в $L^2$. К тому же выполнено $norm(f)_script(L^2(TT,(frac(d theta,2pi)))) = norm(#h(0.5mm) hat(f) #h(0.5mm))_(l^2(ZZ))$ -- равенство Парсеваля. Ещё заметим, что если $sum_(j in ZZ) abs(c_j)^2 < infinity$, то ряд $sum_(j in ZZ) c_j e^(i j t)$ сходится в $inline(L^2(TT,frac(d theta,2pi)))$ и коэффициенты Фурье его суммы это как раз $c_j$.\
Сходимость уже видели: $norm(S_(N_2) - S_(N_1))^2 = sum_(N_1 < abs(j) <= N_2) abs(c_j)^2 arrow.long_(script(N_1 arrow infinity)) 0$, где $S_K$ -- $K$-ая симметрическая частичная сумма этого ряда. Итак, класс $L^2(TT)$ полностью описан в терминах преобразования Фурье.\
Перед тем как доказать #link(<fact1>)[тот факт], полезно сделать несколько замечаний о размерах коэффициентов Фурье.
#proposition[
  Если $f in L^1([-pi,pi])$, то $ abs(hat(f)(n)) <= norm(f)_(L^1) = 1/(2pi) integral_(-pi)^(pi) abs(f(t)) d t $
  и $hat(f)(n) arrow.long 0$ при $abs(n) arrow.long infinity$.
]<prop1>
#proof[
  Первая часть просто следует из определения:
  $ abs(hat(f)(n)) = abs(1/(2pi) integral_(-pi)^(pi) f(t) e^(-i n t) d t) <= 1/(2pi) integral_(-pi)^(pi) abs(f(t)) dot abs(e^(-i n t)) d t = 1/(2pi) integral_(-pi)^(pi) abs(f(t)) d t. $
  Вторая часть -- из #link(<lrl>)[леммы Римана-Лебега]: $ integral_(-pi)^(pi) f(t) e^(-i n t) = integral_(-pi)^(pi) f(t) cos (n t) d t - i integral_(-pi)^(pi) f(t) sin (n t) d t arrow.long_(abs(n) arrow infinity) 0 $
]
#proposition[
  Если $f in C^((k))$ и $2pi$-периодична, то $ hat(f^((k)))(n) = (-i n)^k hat(f)(n), $ в частности, из предыдущего предложения следует, что $abs(hat(f)(n)) <= C abs(n)^(-k), #h(3mm) n eq.not 0.$
]
#proof[
  $ hat(f')(n) = 1/(2pi) integral_(-pi)^(pi) f'(t) e^(-i n t) d t = lr(1/(2pi) e^(-i n t)|)_(-pi)^(pi) - frac(i n, 2pi) integral_(-pi)^(pi) f(t) e^(-i n t) d t. $
  Первое слагаемое обнуляется из-за $2pi$-периодичности, то есть $hat(f')(n) = (-i n) hat(f)(n)$, а дальше всё понятно по индукции. 
]
#proof(link(<fact1>)[факта])[
  Уже знаем, что $S_N f arrow.long f$ поточечно, поскольку $f'(t)$ существует всюду. Но для ряда $sum_(n in ZZ) hat(f)(n) e^(i n t)$ имеем $abs(hat(f)(n) e^(i n t)) <= C abs(n)^(-2), #h(2mm) n eq.not 0$. Поэтому он сходится равномерно.
]
Заметим, что если $abs(c_n) <= C abs(n)^(-(k+2)), #h(2mm) n eq.not 0$, то ряд $sum_(n in ZZ) c_n e^(i n t)$ сходится равномерно к $2pi$-периодической функции из $C^((k))$.\
Действительно, после почленного дифференцирования $j$ раз, где $j <= k$, он по-прежнему мажорируется абсолютно сходящимся числовым рядом, то есть сходится абсолютно и равномерно.\
#corollary[
  $C^(infinity)$ (пространство всех $2pi$-периодических бесконечно дифференцируемых функций на $RR$) описывается так:\
  $ f in C^(infinity) quad arrow.l.r.double.long quad forall k in NN quad hat(f)(n) = italic(O)(abs(n)^(-k)), #h(2mm) abs(n) arrow.long infinity. $
]

== Мало-мальски приличные функции
Напишем ещё вариант формулы для $S_N$:
$ S_N f(x) - A = 1/(2pi) integral_(-pi)^(pi) (f(x-y)-A) dot underbrace(frac(sin (N+1/2) y, sin y/2), D_N) d y = 1/(2pi) integral_0^pi (f(x+y)-f(x-y)- 2 A) D_N(y) = $
$ = 1/pi integral_0^pi (frac(f(x+y)-f(x-y), 2) - A) D_N(y) d y = 1/pi integral_0^pi underbrace(1/(sin y/2) (frac(f(x+y)-f(x-y),2)-A), phi(y)) sin (N+1/2) y d y. $
И вновь мы имеем, что если функция $phi(y)$ суммируема, то по #link(<lrl>)[лемме Римана-Лебега] получаем $ S_N f(x) arrow.long A. $
Предположим, что $f$ имеет разрыв первого рода в точке $x$, то есть $ exists lim_(y arrow 0+) f(x+y) = f_(+) (x), quad exists lim_(y arrow 0+) f(x-y) = f_(-) (x). $
Предположим, например, что у $f$ в точке разрыва существуют производные справа и слева:
$ exists lim_(y arrow 0+) frac(f(x+y)-f_(+) (x), y), quad exists lim_(y arrow 0+) frac(f(x-y)-f_(-) (x), y). $
Тогда если в качестве $A$ взять величину $frac(f_(+) (x) + f_(-) (x),2)$. то ряд Фурье в точке $x$ сходится к $A$. Тем самым, при некоторой регулярности функции, её ряд Фурье сходится к полусумме её предельных значений.

= Восстановление функции по ряду Фурье
/*
#proposition[
  Если $f in C^2(TT)$, то её ряд Фурье сходится к ней равномерно.
]
#proof[
  Ранее мы поняли, что $hat(f)(n) = italic(O) ((abs(n)+1)^(-k))$, мы пишем $abs(n)+1$ чтобы не писать всё время $n eq.not 0$, тогда
  $ sum_(n in ZZ) abs(hat(f)(n)) dot abs(e^(i n t)) <=  sum_(n in ZZ) frac(C, n^2+1) $ -- мажорируя сходящимся числовым рядом получаем, по теореме Вейерштрасса, что ряд Фурье сходится равномерно. Ранее мы видели, что если функция непрерывно дифференцируема (а в нашем случае это так), то ряд Фурье сходится к ней поточечно (см. @th-10). Отсюда мы и получаем равномерную сходимость к $f$.
]
Отсюда также следует полнота тригонометрической системы.
Это было в письменном конспекте*/
== Известные результаты
На самом деле всё зависит от класса, например ранее мы поняли, что в $L^2$ и $C^infinity$ всё однозначно восстанавливается, то есть ряд Фурье сходится, в случае $L^2$ по метрике, в случае $C^infinity$ равномерно вместе со всеми производными.\
Пусть теперь $f in L^p ([-pi,pi])$ и мы знаем её коэффициенты Фурье $hat(f)(n)$. Можно, конечно, составить частичные суммы $ S_N = sum_(abs(j) <= N) hat(f)(j) e^(i j t) $ и смотреть куда они сходятся. Сразу дадим ответ:
+ $S_N arrow.long f$ в $L^p$, если $1 < p < infinity$.
+ Существует $f in C [-pi,pi]$, $2pi$-периодичная, такая, что $S_N f(0)$ расходится, разумеется, сдвигом 0 заменяется на любую другую точку. Это называется теоремой Дюбуа-Реймонда, доказана в конце 19 века.
+ Существует $f in L^1 ([-pi,pi])$, ряд Фурье которой расходится почти всюду. Даже существует такая, что он расходится всюду, но это уже изыски. Это называется теоремой Колмогорова-Сильвестрова.
Не обязательно смотреть сходимость частичных сумм, может можно его как-то просуммировать.
$ sum a_n quad arrow.r.long.squiggly quad sum b_n (sigma) a_n $
Надо предположить про коэффициенты $b_n$, что все такие ряды сходятся, далее устремить $sigma$ к какому-то $sigma_0$. Если такие штуки сходятся, то тогда и говорят, что ряд суммируется.

== Аппроксимативные единицы
#definition[
  Семейство ${Phi_sigma}$ суммируемых функций на окружности (отрезке $[-pi,pi]$) называется аппроксимативной единицей для $L^p (TT)$ (или $C(TT)$), если $ Phi_sigma * f arrow.long_(sigma arrow sigma_0) f $ для любой $f in L^p (TT)$ (или из $C(TT)$ соответственно).
]
$sigma_0$ в определении это некоторое направление, например если индексация идёт по натуральным числам, то $sigma_0 = +infinity$. Из общих свойств преобразования Фурье мы знаем, что
$ hat(Phi_sigma * f) (n) = hat(Phi)_sigma (n) hat(f) (n), $ $ (Phi_sigma * f) (t) = sum_(n in ZZ) hat(Phi)_sigma (n) hat(f) (n) e^(i n t). $
То есть как и описывалось выше, мы суммируем ряд с некоторыми коэффициентами. Коэффициенты Фурье функции $hat(f)$ явно должны быть ограничены, так что если коэффициенты $hat(Phi)_sigma (n)$ достаточно быстро убывают, то такие ряды сходятся, и даже равномерно, например, достаточно, чтобы функции $Phi_sigma$ были дважды гладкие, и тогда ряды сходятся как ряды обратных квадратов.\
Тепреь напишем достаточные условия для того, чтобы последовательность была аппроксимативной единицей для всех классов $L^p (TT)$ ($1 <= p < infinity$), $C(TT)$.
+ Условия в терминах $Phi_sigma$:
  #set enum(numbering: ru_alph())
  + $norm(Phi_sigma)_(L^1) <= C$, где $C$ не зависит от $sigma$.
  + $integral_(-pi)^(pi) Phi_sigma d m = 1$, где $m$ -- нормированная мера Лебега на окружности.
  + $sup_(abs(x)>= delta) abs(Phi_sigma(x)) arrow.long_(sigma arrow sigma_0) 0 quad forall delta > 0$.
  #v(3mm)
+ Условия в терминах $hat(Phi)_sigma$:\ (а) и (б) сохраняются (б означает, что $hat(Phi)_sigma (0) =1$), а вместо (б) предположим что $hat(Phi)_sigma (n) arrow.long_(sigma arrow sigma) 1 quad forall n$.
Докажем второе условие. Как и прежде, за $cal(P)$ мы обозначаем множество тригонометрических полиномов.
- Условие 2 влечёт $forall p in cal(P) quad Phi_sigma * p arrow.long p$ равномерно, потому что коэффициенты Фурье $p$ просто умножаюся на коэффициенты Фурье $Phi_sigma$, которые при $sigma arrow.long sigma_0$ стремятся к $1$, поэтому так как слагаемых конечное число, сходимость равномерная.
- Множество $cal(P)$ плотно в $C(TT)$ относительно равномерной сходимости.
$ f in C(TT), quad Phi_sigma * f(z) - f(z) = integral_TT f(z overline(zeta)) Phi_sigma (zeta) d m(zeta) - f(z) $
$ epsilon>0, #h(2mm) p in cal(P) :quad abs(f(z)-p(z)) <= epsilon quad forall z in TT $
$ Phi_sigma * f(z) = Phi_sigma * f - Phi_sigma * p + Phi_sigma * p = Phi_sigma * p + integral_TT (f(z overline(zeta) - p(z overline(zeta)))) Phi_sigma (zeta) d m $
Первое слагаемое равномерно стремится к $p$. Второе слагаемое оценим так:
$ abs(integral_TT (f(eta)-p(eta) Phi_sigma (z overline(eta))) d m(eta)) <= integral_TT sup_(xi in TT) abs(f(xi)-p(xi)) dot abs(Phi_sigma (z overline(eta))) d m(eta) $
Если $sigma$ достаточно близко к $sigma_0$, то $sup_(zeta in TT) abs(Phi_sigma * f - p) <= C epsilon, quad sup_(zeta in TT) abs(Phi_sigma * f (zeta) - f(zeta)) <= C epsilon + epsilon$.\
Мы доказали всё в равномерной метрике, а хотелось в метрике $L^p$, но непрерывные функции в $L^p$ плотны, поэтому приближая функцию непрерывными, а непрерывные приближая свёртками, всё будет хорошо.
#figure(rect[#image(ipath+"kisl.jpg",width: 40%)], caption: [(o･ω･o)])
Приведём теперь антипример. Посмотрим на ядра Дирихле: $D_N = frac(sin (N + 1/2), sin t/2) = sum_(abs(j) <= N) e^(i j t)$.\
$1/(2pi) integral_(-pi)^(pi) abs(D_N (t)) d t tilde log N$, поэтому нормы $D_N$ в $L_1$ не заведомо не ограничены. А остальные условия выполнены. Давайте покажем эту эквивалентность хотя бы с одной стороны.
$ integral_0^pi frac(abs(sin(N + 1/2)t), abs(sin t/2)) d t >= C integral_0^pi frac(abs(sin(N + 1/2)t),t) d t = C integral_0^(pi(N+1/2)) frac(abs(sin s),s) d s >= $
$ >= C sum_(k=1)^N integral_(k pi)^((k+1)pi) frac(abs(sin s),s) d s >= C sum_(k=1)^N 1/((k+1)pi) integral_(k pi)^((k+1)pi) abs(sin t) d t >= C' sum_(k=1)^N 1/(k+1) >= C'' log N. $
То есть мы разбили отрезок на подотрезки от $k pi$ до $(k+1)pi$ и заменили $s$ на наибольшее значение. Оценка сверху оставляется читателю в качесте упражнения.//#text(fill: author)[Кажется, там лучше суммирование до $N-1$ вести, чтобы всё корректнее было.]

#underline[_Замечание_]: в условиях пункта 2, если $Phi_sigma >= 0 #h(3mm) forall sigma$, то тогда то предположение, которое мы сделали вместо (б), влечёт (а), потому что $ integral_TT abs(Phi_sigma) d m = integral_TT Phi_sigma d m = 1. $
В связи с этим всем, надо вспомнить про суммирование по Чезаро.
$ sigma_N f = 1/(N+1) sum_(k=0)^N S_k f = 1/(N+1) sum_(k=0)^N f*D_k = f * (1/(N+1) sum_(k=0)^n D_k). $
#definition[
  Ядром Фейера называется $ K_N = 1/(N+1) sum_(k=0)^N D_k $
]
// Факт: KN >= 0
// Лекция 5 (02.10.2024)
Формула для коэффициентов Фурье ядра Фейера видна из определения ядра Дирихле.
$ hat(K)_N (j) = frac(N+1-abs(j),N+1), quad abs(j) <= N+1, $
$ hat(K)_N (j) = 0, quad abs(j) > N+1. $
Тем самым, $ hat(K)_N (j) arrow.long_(N -> infinity) 1 quad forall j in ZZ.
$ Теперь докажем, что $K_N >= 0$, из чего будет следовать их ограниченность в $L^1$, потому что, как говорилось выше, модуль интеграла ограничивается интегралом модуля, который равен просто интегралу, который равен единице по аналогичному факту для ядер Дирихле. Вспомним стандарную формулу для ядра Дирихле через синусы и распишем через неё ядра Фейера.
$ D_k (t) = frac(sin (k+1/2)t,sin t/2), $
$ K_N (t) = frac(1,N+1) dot 1/(sin t/2) dot underbrace((sin inline(t/2) + sin (1+inline(1/2))t + dots + sin (N+inline(1/2))t), S) eq.circle $
$ S = "Im"(sum_(k=0)^(N) e^(i (k+1/2)t)) = "Im" e^((i t)/2) (sum_(k=0)^N e^(i k t)) = "Im" e^((i t)/2) frac(e^(i (N+1) t) - 1,e^(i t) - 1) = "Im" frac(e^(i (N+1) t)-1, e^((i t)/2) - e^(- (i t)/2)) = $
$ = "Im" frac(cos (N+1)t - 1 + i sin (N+1)t, 2 i sin t/2) = -frac(cos (N+1)t-1,2 sin t/2) = frac(2 sin^2 (N+1) t/2, 2 sin t/2) $
$ eq.circle 1/(N+1) dot frac(sin^2 (N+1) t/2, sin^2 t/2) >= 0. $
Стало быть, это стандартная аппроксимативная единица.
#theorem("Фейера")[\
  Ряд Фурье функции из $L^p (TT)$ (или из $C(TT)$) суммируется к ней методом Чезаро.
]
#proof[
  Мы всё уже проделали: среднее арифметическое частичных сумм это свёртка с ядрами Фейера, которые, в свою очередь, образуют стандартную аппроксимативную единицу. 
]

== Суммирование рядов Фурье методом Абеля-Пуассона
Для начала напомним в чём заключается суть  метода. $ sum_(j=0)^infinity a_j quad arrow.squiggly.long quad sum_(j=0)^infinity r^j a_j, quad 0 <= r < 1. $
Тогда если существует $lim_(r -> 1-) sum_(j=0)^infinity r^j a_j = A$, то говорят, что ряд суммируется к $A$ методом Абеля-Пуассона.
Во втором семесте мы доказывали, что этот метод регулярен, то есть сходящиеся ряды суммируются к их стандартной сумме, и смотрели на иные свойства. Но нас интересует как суммировать этим методом ряд Фурье.\
Рассмотрим $f in L^1(TT)$ и её ряд Фурье. Сперва нам надо обойти тот факт, что ряд двухсторонний, но это сделать легко.
$ sum_(j in ZZ) hat(f) (j) e^(i j theta) = hat(f) (0) + sum_(k in NN) (hat(f)(k) e^(i k theta) + hat(f)(-k) e^(-i k theta)) $
Теперь этому ряду сопоставляется ряд $hat(f)(0) + sum_(k in NN) r^k (hat(f)(k) e^(i k theta) + hat(f)(-k) e^(-i k theta))$, обозначим его за $phi_r (theta)$.
$ phi_r (theta) = sum_(j in ZZ) r^(-abs(j)) hat(f)(j) e^(i j theta) = P_r (theta) * f, $
где $P_r (theta) = sum_(j in ZZ) r^abs(j) e^(i j theta)$ -- _ядро Пуассона_, которое заведомо сходится как геометрическая прогрессия. Теперь мы хотим доказать, что ${P_r}_(0<=r<1)$ это аппроксимативная единица. Для этого достаточно показать:
+ $P_r >= 0$.#v(2mm)
+ $integral_(-pi)^(pi) P_r (theta) d theta = 2pi$#v(2mm)
+ $hat(P)_r (j) arrow.long_(r -> 1-) 1 quad forall j in ZZ$.
Всё понятно, кроме первого, которое проверяется простыми вычислениями.
$ P_r (theta) = sum_(j>=0) r^j e^(i j theta) + sum_(j >= 1) r^j e^(-i j theta) = frac(1,1-r e^(i theta)) + frac(r e^(i theta), 1-r e^(-i theta)) = frac(1-r^2, 1 - 2 r cos theta + r^2) >= 0 $
Тем самым, методом Абеля-Пуассона все ряды Фурье суммируются.

== Интеграл Пуассона
Если мы обозначим $r e^(i theta)$ за $z$, то $z$ будет некоторой точкой круга $DD = {z in CC : abs(z)<1}$. Тогда
$ P(z) = P_r (theta) = sum_(j >= 0) z^j + overline((sum_(j > 0) z^j)). $
Первое слагаемое аналитично в круге, второе слагаемое на самом деле вещественная часть некоторой аналитической функции, значит $P(z)$ гармоническая в $DD$. Значит, если $z = x + i y$, то $P$ удовлетворяет уравнению Лапласа: $Delta P(x+i y) = 0$.
Пусть $f in C(TT)$. Тогда $ P_r (theta) * f = sum_(j >= 0) hat(f)(j) z_j + overline(sum_(j>=1) overline(hat(f)(-j)) z_j), $
это тоже гармоническая функция, так как первое слагаемое аналитично, а второе гармонично как сопряжённое к аналитической функции.
$ P_r * f (theta) = 1/(2pi) integral_(-pi)^pi f(theta-pi) dot frac(1-r^2,1-2r cos t + r^2) d t $
Эта штука называется интегралом Пуассона и она решает задачу Дирихле в круге.

== Как получать аппроксимативные единицы?
Пусть $phi in ell^2(ZZ)$, предположим, что она вещественна и чётна, то есть $phi(-n) = phi(n)$, к тому же $norm(phi)_(l^2) = 1$.
$ Phi (n) = phi * phi (n) = sum_(k in ZZ) phi(n-k) phi(k) $
$ hat(phi)(xi) = sum_(n in ZZ) hat(phi)(n) xi^n $
Согласно равенству Парсеваля $norm(hat(phi))_(L^2(TT)) = norm(phi)_(ell^2) = 1$.\
Пусть $phi$ не только квадратично суммируема, но и просто суммируема, то есть $phi in ell^1(ZZ) sect ell^2(ZZ)$.
$ hat(Phi)(zeta) = (hat(phi)(zeta))^2 >= 0 $
Ведь потому что $phi$ чётна, её преобразование Фурье вещественно.\ #v(0.1mm)
Например, если взять $phi = (chi_[-M,M])/(sqrt(2M+1))$, то в свёртке получится нечто похожее на ядра Фейера. 

= Интегралы Фурье
Поговорим про преобразование Фурье в $RR^n$.\
Пусть $f in L^1(RR^n)$, ранее мы уже говорили, что $hat(f)(xi) = integral_(RR^n) f(x) e^(-2pi i scal(x,xi)) d x, quad xi in RR^n$.\
Всё будет не так хорошо, как на окружности, ну например потому что $L^2 (RR^n) subset.eq.not L^1(RR^n)$.

== Основные свойства
+ $abs(hat(f)(xi)) <= norm(f)_(L^1)$ -- очевидно.
+ $hat(f)$ -- непрерывная функция на $RR^n$. Следует из теоремы Лебега о мажорируемой сходимости.
+ $lim_(xi -> infinity) abs(hat(f)(xi)) = 0$. Следует из #link(<lrl>)[леммы Римана-Лебега].
+ Определим сдвиг функции. Для $t in RR^n$ положим $f^t (x) = f(x-t)$, тогда $ hat(f^t)(xi) = integral_(RR^n) f(x-t) e^(-2pi i scal(x,xi)) d x = integral_(RR^n) f(y) e^(-2pi i scal(y,xi)) e^(-2pi i scal(t,xi)) d y = hat(f^t)(xi) e^(-2pi i scal(x,xi)). $
+ Если взять $g(x) = f(x) e^(2pi i scal(x,u))$, то $ hat(g)(xi) = integral_(RR^n) f(x) e^(2pi i scal(x,u)) e^(-2pi i scal(x,xi)) d x = hat(f)(xi - u). $
+ Пусть $f in C^1 (RR^n)$ и все $inline(frac(partial, partial x_j))f$ суммируемы. Тогда $ hat(frac(partial, partial x_j)f)(xi) = integral_RR frac(partial, partial x_j)f(x) e^(-2 pi i scal(x,xi)) d x $
  Чтобы было удобно интегрировать по частям, предположим также что $f$ и все $inline(frac(partial, partial x_j))f$ стремятся к нулю на бесконечности. Теперь, если для определённости взять $j = 1$, получится
  $ integral_(RR^(n-1)) (integral_RR frac(partial, partial x_1)f e^(-2pi i x_1 xi_1) d x_1) e^(-2pi i (x_2 xi_2 + dots + x_n xi_n)) d x_2 dots d x_n. $
  Внутренний интеграл возьмём по частям, подстановка пропадёт.
  $ integral_RR frac(partial, partial x_1)f e^(-2pi i x_1 xi_1) d x_1 = - integral_RR f(x) e^(-2pi i x_1 xi_1) (-2pi i xi_1) d x_1 = 2pi i xi_1 hat(f)(xi) $
  Тем самым, $hat(inline(frac(partial, partial x_j))f)(xi) = 2pi i xi_j hat(f)(xi)$.
+ Из предыдущего пункта следует, что если $f in C^infinity (RR^n)$ и все производные начиная с нулевой суммируемы и стремятся к нулю на бесконечности, то $ (partial_1^(alpha_1) dots thin partial_n^(alpha_n) f)^(and) = (2pi i xi_1)^(alpha_1) dots thin (2pi i xi_n)^(alpha_1) hat(f) (xi). $
+ Если $f$ как в пунке 7, то $hat(f)$ убывает быстрее любой степени $xi$:
  $ forall k in NN quad abs(hat(f)(xi)) (1 + abs(xi)^k) arrow.long_(abs(xi) -> infinity) 0. $
  // Лекция 6 (09.10.2024)
  Объясняется это так: если $f$ суммируема $k$ раз и все её производные до порядка $k$ суммируемы, то для $inline(sum_(i=1)^n alpha_n <= k)$ выполнено $ (partial_1^(alpha_1) dots thin partial_n^(alpha_n) f)^(and) = (2pi i xi_1)^(alpha_1) dots thin (2pi i xi_n)^(alpha_1) hat(f) (xi). $
  #text(fill: author)[Тут Кисляков написал перед множителями минусы, но видимо это проблема обозначений и нормировок, раз у нас в Фурье экспонента с минусом, то тут он не возникнет.\ ]
  Мы знаем, что у суммируемой функции преобразование Фурье ограничено, значит $exists C$ такая, что $ abs(hat(f) (xi)) <= C quad "и" quad (2pi abs(xi))^(alpha_1) dots (2pi abs(xi_n))^(alpha_n) abs(hat(f) (xi)) <= C $
  для всех мультииндексов $alpha = (alpha_1,dots,alpha_n)$. Просуммировав по всем мультииндексам, не превосходящим $k$, получим
  $ abs(hat(f) (xi)) underbrace(sum_(abs(alpha) <= k) (1 + abs(xi_1)^(alpha_1) dot dots abs(xi_n)^(alpha_n)), >= A (1+abs(xi))^k) <= C', $
  где оценка на сумму получена из неравенства $1/sqrt(n) (abs(xi_1) + dots + abs(xi_n)) <= sqrt(xi_1^2 + dots + xi_n^2) <= abs(xi_1) + dots + abs(xi_n). $
  Поэтому $abs(hat(f) (xi)) <= frac(C'', (1+abs(xi))^k)$.
== Простейший вариант формулы обращения
Как мы не раз замечали, верна она далеко не всегда. Напомним, речь идёт о равенстве $(f^and)^(or) = f$ для $f in L^1(RR^n)$. Ещё раз вспомним формулы для прямого и обратного:
$ hat(f) (xi) = integral_(RR^n) f(x) e^(-2pi scal(x,xi)) d x, quad caron(f) (xi) = hat(f) (-xi). $
Оказывается, эти операции более или менее взаимно обратны для достаточно хороших функций.\
Работать мы будем на $RR$, то есть $n=1$, и пусть $f in cal(D)(RR)$, то есть бесконечно дифференцируема с компатным носителем.#footnote(text(fill: author)[#h(2mm) То есть мы будем смотреть на крышечки от шапочек.]) Покажем, что в таком случае формула обращения верна буквально.
Пусть $R$ -- настолько большое число, что носитель функции $phi(x) = f(R x)$ лежит в отрезке $[-pi,pi]$.
$ f(R x) = sum_(n in ZZ) c_n e^(i n x), quad x in [-pi,pi], $
$ c_n = 1/(2pi) integral_(-pi)^pi f(R x) e^(-i n t) d x. $
Сделав замену $R x arrow.squiggly x$ получаем $f(x) = sum_(n in ZZ) c_n e^(i n x/R)$, $ c_n = 1/(2pi R) integral_(-R pi)^(R pi) f(t) e^(-i n t/R) d t = 1/(2pi R) integral_(-infinity)^(+infinity) f(t) e^(-2pi i n t/(2pi R)) d t = 1/(2pi R ) cal(F) (f) (n/(2pi R)). $
Тем самым, $f(x) = 1/(2pi R) sum_(n in ZZ) cal(F) (f) (n/(2pi R)) e^(2pi i x n/(2pi R))$. Эта сумма близка к интегралу от $-R$ до $R$, а в пределе при $R arrow.long infinity$ хотим получить стремление к $integral_(-infinity)^(+infinity) cal(F)(f) (xi) e^(2pi i xi x) d xi$.\
Пусть $K$ -- большое число, и пусть $abs(n/(2pi R)) > K$. Оценим хвост ряда:
$ 1/(2pi R) sum_(abs(n/(2pi R))>K) abs(cal(F)(n/(2pi R))) <= C dot 1/(2pi R) sum_(abs(n/(2pi R))>K) (frac(2pi R,abs(n)))^A <= frac(C',K^(A-1)) $
Константу $A>0$ можно выбрать сколь угодно большой, потому что коэффициенты Фурье убывают быстрее любой степени. Для удобства обозначим $G(xi) = cal(F)(f) (xi) e^(2 pi i x xi)$. Оценим оставшуюся часть:
$ 1/(2pi R) sum_(abs(n/(2pi R))<=K) G(n/(2pi R)) arrow.long_(R -> infinity) integral_(-K)^(K) G(xi) d xi. $
Значит, для класса $cal(D)(RR)$ формула обращения действительно верна.

== Снова про $RR^n$
Вернёмся в $RR^n$ и вновь напишем формулу для преобразования Фурье: $ hat(f) (xi) = integral_(RR^n) f(x) e^(-2pi i scal(x,xi)) d x. $
Хочется узнать, сколько раз можно дифференцировать эту формулу. Надо дифференцировать под знаком интеграла и смотреть суммируемая ли функция получилась. Пусть $(1+abs(xi)) f(x) in L^1 (RR^n)$, тогда $inline(frac(partial, partial x_j) hat(f))$ существует для любого $j = 1, dots, n$ так как $ (frac(partial, partial x_j) hat(f)) (xi) = integral_(RR^n) 2 pi i x_j f(x) e^(-2 pi i scal(x,xi)) d x $ и подынтегральная функция суммируема по теореме Лебега. Отсюда следует, что $ (2 pi i x_j f(x))^and = frac(partial, partial x_j) hat(f). $
Проблема класса $cal(D)(RR^n)$ в том, что преобразование Фурье функции оттуда не может иметь компактный носитель, потому что получается целая функция с компактным носителем, а по теореме единственности это ноль. Лечится это классом Шварца $S(RR^n)$ -- бесконечно гладкие функции, у которых любая производная убывает на бесконечности быстрее любой степени. Тем самым, мы априори потребовали, чтобы $ abs(D^alpha f(x)) <= frac(C_(alpha,f,A),(1+abs(x)^A)), $
и преобразование Фурье можно дифференцировать сколько угодно раз. Более того, из сказанного выше следует, что преобразование Фурье переводит класс Шварца на себя.
$ cal(F) (S(RR^n)) subset.eq S(RR^n) $
позже мы поймём, что на самом деле тут равенство.
== Растянутые и сдвинутые функции
Хотим понять, как ведёт себя преобразование Фурье при растяжении функции.\
Пусть $t in RR, #h(2mm) t eq.not 0, #h(2mm) f in L^1(RR^n)$. Положим $f^((t))(x) = f(t x)$.
$ hat(f^((t))) (xi) = integral_(RR^n) f(t x) e^(-2 pi i scal(x,xi) d x) = frac(1,abs(t)) integral_(RR^n) f(x) e^(-2pi i scal(x,xi/t)) = frac(1,abs(t)) hat(f) (xi/t). $
Тем самым, $(1/(s^n) f(inline(x/s)))^and = hat(f) (s xi)$.\
Теперь рассмотрим сдвиг: пусть $y in RR^n$, определим $f_((y)) = f(x-y)$. Выше мы уже видели, что
$ hat(f)_((y)) (xi) = integral_(RR^n) f(x-y) e^(-2 pi i scal(x,xi)) d x = e^(-2 pi i scal(xi,y)) hat(f) (xi). $
== Общая теория про формулу обращения
#lemma[
  Если $f,g in L^1(RR^n)$, то $integral_(RR^n) f(x) hat(g) (x) d x = integral_(RR^n) hat(f) (y) g(y) d y.$
]<lemma2>
#proof[
  Для начала стоит заметить, что формула действительно осмысленная: преобразование Фурье функции из $L^1$ ограничено, так что умножая на суммируемую мы получаем суммируемую.\
  $ integral_(RR^n) f(x) hat(g)(x) d x = integral_(RR^n) f(x) (#h(1.5mm)integral_(RR^n) g(t) e^(-2 pi i scal(t,x)) d t) d x = integral_(RR^n) integral_(RR^n) f(x) g(t) e^(-2 pi i scal(t,x)) d x d t = integral_(RR^n) g(t) hat(f)(t) d t. $
  Теорема Фубини работает, так как функция $(x,y) arrow.long.bar f(x) g(y) e^(-2 pi i scal(x,y))$ суммируема на $RR^n times RR^n$.
]
$ integral_(RR^n) f(x-u) hat(g)(x) d x = integral_(RR^n) e^(-2 pi i scal(u,s)) hat(f)(s) g(s) d s. $
Давайте считать, что $g$ чётная. Тогда $hat(g)$ также чётная, это видно из формулы для растяжения при $t=-1$. Тогда в левом интеграле можно заменить $x$ на $-x$, также заменим $u$ на $-u$, получим
$ integral_(RR^n) f(u-x) hat(g)(x) d x = integral_(RR^n) e^(2 pi i scal(u,s)) hat(f)(s) g(s) d s. $
Теперь подставим $g(t s)$ вместо $g(s)$.
$ integral_(RR^n) f(u-x) dot 1/(t^n) dot hat(g)(x/t) d x = integral_(RR^n) e^(2 pi i scal(u,s)) hat(f)(s) g(t s) d s. $
Тут виднеется формула свёртки с аппроксимативной единицей, надо потребовать, чтобы $ hat(g) in L^1(RR^n) quad "и" quad integral_(RR^n) hat(g) (v) d v = 1. $
Было бы неплохо, чтобы $g(0) = 1$, $g$ была бы непрерывна и $hat(f)$ суммируема, тогда по теореме Лебега правая часть будет стремится к обратному преобразованию Фурье для функции $hat(f)$.\

// Лекция 7 (16.10.2024)
#proposition[
  Пусть $h in L^1(RR^n)$ и $integral_(RR^n) h(x) d x = 1$. Положим $h_t (x) = 1/(t^n) h(x/t)$ для $t>0$. Тогда
  $ forall f in L^1(RR^n) quad f * h_t arrow.long^(L^1)_(t -> 0) f. $
]
#proof[
  Так как интеграл $h_t$ останется единичным, надо оценить интеграл по $x$ от модуля следующего выражения:
  $ integral_(RR^n) f(x-y) h_t (y) d y - f(x) integral_(RR^n) h_t (y) d y.  $
  $ integral_(RR^n) #h(1.5mm)abs(#h(1.5mm)integral_(RR^n) f(x-y) h_t (y) d y - f(x) integral_(RR^n) h_t (y) d y#h(1.5mm)) d x <= integral_(RR^n) integral_(RR^n) abs(f(x-y) -f(x)) d x abs(h_t (y)) d y eq.circle $
  Далее применим непрерывность сдвига в $L^1$:
  $ forall epsilon>0 quad exists delta > 0 : quad abs(y) < delta quad arrow.double phi(y) = integral_(RR^n) abs(f(x-y)-f(x)) d x < epsilon. $
  $ eq.circle integral_(abs(y)<delta) phi(y) abs(h_t (y)) d y + integral_(abs(y)>=delta) phi(y) abs(h_t (y)) d y <= epsilon integral_(abs(y)<delta) abs(h_t (y)) d y + integral_(abs(y)>=delta) phi(y) abs(h_t (y)) d y <= $
  $ <= epsilon norm(h)_(L^1) + 2 norm(f)_(L^1) underbrace(integral_(abs(y)>=delta) 1/(t^n) abs(h(y/t)) d y, = integral_(abs(u) >= delta t) abs(h(u)) d u arrow.long^(t -> 0) 0) $
]
== "Шаблон" для обращения преобразования Фурье
Имеется $f in L^1(RR^n)$ и $g in L^1(RR^n)$ -- фиксированная. Мы требовали от неё, чтобы она была чётная, непрерывная в нуле (#text(fill: author)[хотя раньше сказали, что везде]) и $g(0)=1$.
#let lch = text(fill: rgb("#FF4500"), 13pt)[$bold("ЛЧ")$]
#let pch = text(fill: rgb("#006400"), 13pt)[$bold("ПЧ")$]
$ lch = integral_(RR^n) f(x-u) dot 1/(t^n) dot hat(g) (u/t) d u = integral_(RR^n) hat(f) (y) g(t y) e^(2pi i scal(x,y)) d y = pch $
Чтобы получить свёртку с аппроксимативной единицей, нужны ещё условия: $hat(g) in L^1(RR^n), #h(2mm) integral_(RR^n) hat(g)(u) d u = 1$, и тогда $1/(t^n) hat(g)(u/t)$ действительно будет аппроксимативной единицей. Но как такую $g$ найти?\
Пусть пока что $n=1$. Возьмём чётную $g_1 in cal(D)(RR)$, $g_1(0) = 1$ -- это сделать легко. Тогда $hat(g_1) in L^1$, так как она лежит в классе Шварца. Так как для класса $cal(D)(RR)$ формула обращения верна, можем написать
$ g_1(x) = integral_(RR) hat(g_1)(xi) e^(2pi i x xi) d xi $
Подставив туда $x=0$ получим $1 = integral_(RR) hat(g_1)(xi) d xi$.

А в $RR^n$ мы можем взять $g(x) = g_1(x_1) dot dots dot g_1(x_n)$, для неё $hat(g)(xi) = hat(g_1)(xi_1) dot dots dot hat(g_1)(xi_1)$ и всё что надо выполнено. Теперь можем смело такую $g$ зафиксировать.
$ lch arrow.long^(L^1) f. $
Давайте предположим, что $hat(f) in L^1(RR^n)$. Тогда так как $g$ ограничена, можно перейти к пределу под интегралом, и $ pch arrow.long integral_(RR^n) hat(f) (y) e^(2pi i scal(x,y)) d y = (hat(f))^or. $
Тем самым, мы получили следующий результат:
#theorem[
  $f = (hat(f))^or$ почти всюду, если $f$ и $hat(f)$ суммируемы.
]
''Почти всюду'' можно не писать, потому что прямое и обратное преобразования Фурье непрерывны, так что раз $f$ совпадает почти всюду с непрерывной функцией, её можно поправить, чтобы она стала непрерыной.
#corollary[
  $cal(F)(S(RR^n)) = S(RR^n)$
]
#proof[
  Пусть $phi in S(RR^n)$. По теореме $phi = (hat(phi))^or$. Обозначим $beta = hat(phi)$. Получили, что $phi$ это чьё-то обратное преобразование Фурье, но если взять $gamma(x) = beta(-x)$, то
  $ hat(gamma)(xi) = integral_(RR^n) gamma(xi) e^(-2 pi i scal(x,xi)) d xi = integral_(RR^n) beta(-xi) e^(-2 pi i scal(x,xi)) d xi = integral_(RR^n) beta(xi) e^(2pi scal(x,xi)) d xi = caron(beta)(x) = phi(x). $
]
Для удобства будем называть $g$ порождающей для формулы обращения.

== Теорема Планшереля
Напомним, что выполнялось на окружности: $ f in L^2 (TT) iff sum_(n in ZZ) abs(hat(f) (n))^2 < +infinity, $ $ 1/(2pi) integral_(-pi)^(pi) abs(f(x))^2 d x = sum_(n in ZZ) abs(hat(f)(n))^2. $
Теорема Планшереля говорит, что нечтно подобное выполнено и в $RR^n$. Формулу для преобразования Фурье можно написать для $L^1(RR^n)$, но для функций из $L^2$ не всегда, так что можно рассмотаривать $f in L^1(RR^n) sect L^2(RR^n)$. А это множество плотно в $L^2(RR^n)$, так что потом можно будет приближаться функциями этого класса.
#theorem[
  Если $f,g in S(RR^n)$, то $ scal(f,g) = integral_(RR^n) f(x) overline(g(x)) d x = integral_(RR^n) hat(f) (xi) overline(hat(g)(xi)) d xi = scal(hat(f),hat(g)). $
]
#corollary[
  Если взять $f = g$, то получим, что $norm(f)_(L^2) = norm(g)_(L^2)$ для функций из класса Шварца.
]
#proof("теоремы")[
  Пусть $phi,psi in S(RR^n)$. Тогда по #link(<lemma2>)[лемме 2] $integral_(RR^n) phi(x) hat(psi)(x) d x = integral_(RR^n) hat(phi)(x) psi(x) d x$.// ПРОВЕРЯТЬ НОМЕР
  Положим $psi = caron(u)$, где $u in S(RR^n)$ -- произвольная. Получаем $ integral_(RR^n) phi(x) u(x) d x = integral_(RR^n) hat(phi) caron(u) (x) d x. $
  Положим $u = overline(v)$, тогда $caron(u)(x) = integral_(RR^n) overline(v(xi)) e^(2pi i scal(x,xi)) d xi = overline(integral_(RR^n) v(xi) e^(-2pi i scal(x,xi))) d xi = overline(hat(v)(x))$.
]
Задачим линейный оператор $cal(F): phi arrow.long.bar hat(phi)$, только что мы доказали, что в норме $L^2$ это изометрия, то есть $norm(cal(F) phi)_(L^2) = norm(phi)_(L^2)$. По теореме о продолжении с плотного множества, $cal(F)$ можно линейно продолжить до линейного оператора на всём $L^2$. Для тех, кто с ней незнаком, поясним:\
Пусть $h in L^2(RR^n)$. Приблизим её функциями $phi_n in S(RR^n): quad norm(phi_n - h)_(L^2) arrow.long 0$.
Тогда ${cal(F)phi_n}_(n in NN)$ -- последовательность Коши в $L_2$, так как $norm(cal(F)(phi_n)-cal(F)(phi_k)) = norm(cal(F)(phi_n-phi_k)) = norm(phi_n-phi_k)$.\
Поэтому, так как $L^2$ банахово, эта последовательность куда-то сходится: $cal(F)(phi_n) arrow.long g$. Это $g$ не зависит от выбора аппроксимирующей последовательности и $norm(h)_(L^2) = norm(g)_(L^2)$.\
Теперь за $cal(F)$ обозначаем уже продолженный на всё $L^2$ оператор, его мы и будем называть преобразованием Фурье в $L^2(RR^n)$. Тогда $cal(F)(L^2(RR^n)) = L^2(RR^n)$ потому что раз это изометрия, то образ является замкнутым подпространством, но так как класс Шварца там лежит и плотен, то образ совпадает с $L^2(RR^n)$. Из всего сказанного вытекает следующий факт.

#underline([Факт]). Пусть $h in L^2(RR^n)$, $v_n in L^1(RR^n) sect L^2(RR^n)$ и $v_n arrow.long^(L^2) h$. Тогда $hat(v)_n arrow.long^(L^2) cal(F)(h)$.

Также ясно, что $scal(cal(F)(u),cal(F)(v)) = scal(u,v)$. Это следует либо из поряризационного тождества, либо из сохраняния нормы для предела по функциям класса Шварца.
== Ещё про формулы обращения
Обозначим $cal(F)_(-)(h)(x) = cal(F)(h)(-x)$. Тогда $cal(F)_(-) = cal(F)^(-1)$, потому что для функций класса Шварца это верно. То есть формула обращения в $L^2$ верна.

Напишем ещё одну порождающую функцию: $g(x) = e^(-pi abs(pi)^2), quad x in RR^n$. Она лежит в классе Шварца, давайте посчитаем её преобразование Фурье.
+ $n=1$. $g(x) = e^(-pi x^2)$.
  $ hat(g)(xi) = integral_(-infinity)^infinity e^(pi x^2) dot e^(-2 pi i x xi) d x = integral_(-infinity)^infinity e^(-pi(x^2+2i x xi + (i xi)^2)) e^(-pi xi^2) d x = e^(-pi xi^2) integral_(-infinity)^infinity e^(-pi (x + i xi)^2) = 1 $
  #text(fill: author)[ТУТ ЖЕ НЕ 1, ДА???]\
  Для $xi = 0$ нам это известно, иначе рассмотрим следующий прямоугольник:
  #align(center,
  cetz.canvas({
    import cetz.draw: *
    stroke(red)
    line((-1.5,0),(-1.5,1),(1.5,1),(1.5,0))
    //set-style(mark: (end: ">", pos: 50%, scale: 0.5))
    stroke(black)
    circle((-1.5,0),radius: 0.6pt)
    circle((1.5,0),radius: 0.6pt)
    circle((0,1),radius: 0.6pt)
    set-style(mark: (end: "straight"))
    line((-2.5,0),(2.5,0))
    line((0,-0.3),(0,2))
    content((1.5,-0.2),$A$)
    content((-1.5,-0.2),$-A$)
    content((0.2,1.4), $xi$)
    set-style(mark: (end: "<", pos: 40%, scale: 0.5))
    line((1.5,0),(0,0))
    stroke(red)
    line((-1.5,1),(0,1))
    line((-1.5,0.1),(-1.5,1))
    line((1.5,1),(1.5,0))
  }))
  Интеграл по нему функции $e^(-pi (x + i xi)^2)$ равен нулю, так как она аналитична. На нижнем отрезке он равен единице, это просто случай $xi = 0$, по верхней стороне это интеграл, который нам нужен с противоположным знаком. Теперь разберёмся с боковыми сторонами
  $ integral_0^(xi) e^(-pi (plus.minus A + y)^2) d y = integral_0^(xi) e^(-pi A^2 plus.minus 2pi A i y + pi y^2) d y arrow.long_(script(A -> 0)) 0. $
+ $n$ любое. Тогда $e^(-pi abs(x)^2) = e^(-pi x_1^2) dot dots dot e^(-pi x_n^2)$. То же самое верное и тут, так как $ (e^(-pi abs(x)^2))^and = e^(-pi abs(xi)^2). $

Возьмём функцию $f in L^2(RR)$, обозначим $ f_A = chi_([-A,A]) dot f. $ Она лежит в пересечении $L^1(RR) sect L^2(RR)$. Тогда существует $hat(f)_A$.
$ f_A arrow.long_(A -> infinity)^(L^2) f, $
$ cal(F)f = lim_(A -> infinity) hat(f)_A = lim_(A -> infinity) integral_(-A)^(A) f(x) e^(-2pi i x xi) d x, $
где пределы понимаются в смысле пространства $L^2$.\

// Лекция 8 (23.10.2024)
Пусть $f in L^2(RR)$, $phi = cal(F)(f)$. Тогда верна такая формула:
$ f(x) = lim_(A -> infinity) integral_(-A)^A phi(xi) e^(2pi i x xi) d xi, $
где, опять же, предел в смысле $L^2$. Это правда так как $chi_([-A,A]) dot phi in L^1(RR) sect L^2(RR)$.

//Что будет, если мы откажемся от $L^2$?
Возьмём $h = chi_([-1,1])$. Где-то раньше мы считали, что $ hat(h)(xi) = 1/pi dot (sin 2pi xi)/xi. $ Эта штука не суммируема, но лежит в $L^2$.
По теореме Планшереля $  1/(pi^2) integral_(RR) frac(sin^2 pi xi, xi^2) d xi = 2. $

Напишем опять ту общую формулу, из которой мы выводили формулу обращения, предположения про $g$ всё те же.
$ integral_(RR^n) f(x-y) dot 1/(t^n) dot hat(g)(y/t) d y = integral_(RR^n) hat(f) (s) e^(2pi i scal(x,s)) g(t s) d s. $
$n=1, quad g = chi_([-1,1])$.
$ integral_(-1/t)^(1/t) hat(f) (s) e^(2pi i x s) d s = integral_(-infinity)^(infinity) f(x-y) dot 1/t dot frac(sin frac(2pi y,t), y/t), quad A = 1/t $
$ integral_(-A)^(A) hat(f)(s) e^(2pi i x s) d s = 1/pi integral_(-infinity)^(infinity) f(x-y) frac(sin 2pi A y, y) d y $
В несобственном смысле, $ lim_(M -> infinity) integral_(-M)^(M) frac(sin 2pi A y, pi y) = 1. $
Предполагаем $f in L^1(RR)$ и $x$ фиксированно. 
$ integral_(-infinity)^(infinity) f(x-y) frac(sin 2pi A y, pi y) d y - a = integral_(-infinity)^(infinity) (f(x-y)-a) frac(sin 2pi A y, pi y) d y = $
$ = integral_(-M)^(M) frac(f(x-y)-a,pi y) sin 2pi A y d y + integral_(RR without [-M,M]) f(x-y) frac(sin 2pi A y, pi y) d y + a integral_(RR without [-M,M]) frac(sin 2pi A y, pi y) d y = $ 
$ = I_1(x) + I_2(x) + I_3. $
Проведём оценки, для начала убедимся, что второе и третье слагаемые малы при любом $A$, если $M$ велико.

- $epsilon>0. quad$ Покажем, что $abs(I_2(x)) < epsilon$, если $M$ велико (равномерно по $A$).
$ integral_(RR without [-M,M]) abs(f(x-y)) dot 1/(pi abs(y)) <= 1/(pi M) integral_(abs(y)>M) abs(f(x-y)) d y <= 1/(pi M) integral_(RR) abs(f(x-y)) d y = 1/(pi M) norm(f)_(L^1) . $

- То же самое для $I_3$.
$ I_3 = integral_(-infinity)^(-M) frac(sin 2pi A y, pi y) d y + integral_(M)^(infinity) frac(sin 2pi A y, pi y) d y = 2 integral_(M)^(infinity) frac(sin 2pi A y, pi A y) d(A y) = 2 integral_(A M)^(infinity) frac(sin 2pi tau, pi tau) d tau. $
Так как $A$ нас интересует на бесконечности, то, например, при $A>=1$ интеграл оценивается тем же самым без $A$, а он стремится к нулю при $M -> infinity$.

- Если нам повезло, и функция $inline(y arrow.long.bar frac(f(x-y)-a,y))$ суммируема на любом отрезке $[-M,M]$, то в силу #link(<lrl>)[леммы Римана-Лебега] $I_1(x) arrow.long 0$ при $A arrow.long infinity$.

#corollary[
  Если $y arrow.long.bar frac(f(x-y)-a,y)$ суммируема на любом отрезке $[-M,M]$, то $ integral_(-A)^(A) hat(f)(xi) e^(2pi i x xi) d xi arrow.long_(A -> infinity) a. $
]
#corollary[
  Если у $f$ существует производная, то сходимость имеет место и происходит к $a = f(x)$.
]
Эти следствия называются классической формулой обращения. То есть по обратному преобразованию Фурье функция восстанавливается там, где есть минимальная гладкость.
== Ядро Пуассона для верхнего полупространства
Это ещё один вариант общей формулы обращения.\

Напомним, $h$ -- гармоническая в $RR_d$, если $Delta h = 0$.
$ (frac(partial, partial x_1))^2 h + dots + (frac(partial, partial x_d))^2 h = 0 $
Функция $r^(-(d-2))$ гармонична, где $r = abs(x) = sqrt(x_1^2 + dots + x_n^2)$. При $d=2$ вместо неё рассматривают логарифм $log r$. Посчитаем частные производные:
$ frac(partial r, partial x_j) = 1/(2r) dot 2 x_j = x_j / r, $
$ frac(partial, partial x_j) r^(-(d-2)) = -(d-2) r^(-(d-2)-1) dot frac(x_j,r) = -(d-2) r^(-d) x_j, $
$ frac(partial^2, partial x_j^2) r^(-(d-2)) = d(d-2) r^(-(d-1)) dot frac(x_j,r) dot x_j - (d-2)r^(-d), $
$ Delta r^(-(d-2)) =  -(d-2)r^(-d) + d(d-2)r^(-(d-2)) sum_(j = 1)^(d) x_j^2 = 0. $
Добавим ещё одну переменную $t>0$, полученное полупространство обозначим за $RR^(n+1)_+$. Тогда функция $(t^2+abs(x)^2)^(-frac(n-1,2))$ гармонична в $RR^(n+1)_+$.
$ frac(partial, partial t) (t^2+abs(x)^2)^(-frac(n-1,2)) = C frac(t,(t^2 + abs(x)^2)^((n+1)/2)) = C frac(t,t^(n+1) (1+abs(x/t)^2)^((n+1)/2)) = C frac(1,t^(n) (1+abs(x/t)^2)^((n+1)/2)). $
Обозначим $p(x) = frac(C', (1+abs(x)^2)^((n+1)/2))$. Тогда сверху мы получили $1/(t^n) p(x/t) = p_t (x)$. Функция $p$ неотрицательна, суммируема на $RR^n$, и если выбрать $C'$ так, чтобы интеграл был равен единице, то получим, что ${p_t}_(t>0)$ -- аппроксимативная единица. На неё можно смотреть как на функцию от двух переменных, и тогда она будет гармонична в верхнем полупространстве.\
$ h in L^1(RR^n), quad H(x,t) = h * p_t (x) = integral_(RR^n) h(x-y) p_t (y) d y = integral_(RR^n) f(y) p_t (x-y) d y. $
$H$ гармонична в $RR^(n+1)_+$ так как можно дифференцировать под знаком интеграла, потому что дифференцируя два раза степень при $abs(x)^(-1)$ останется больше размерности пространства, то есть
#underline[_Замечание_]: $D thin p_t (x)$ -- суммируемая функция для любого дифференциального опертора.
$ phi = hat(p), quad hat(p_t) (x) = phi(t x). $
Ниже мы покажем, что $phi$ радиальна, то есть $phi = psi(abs(x))$, где $psi$ -- некоторая функция на $RR_+$. Тогда $ hat(p_t) (x) = psi(t abs(x)). $
Обозначим $P(t,y) = p_t (y)$.
$ frac(partial^2 P,partial t^2) + frac(partial^2 P,partial y_1^2) + dots + frac(partial^2 P,partial y_n^2) = 0, $
$ frac(partial^2 psi(t abs(x)),partial t^2) + (2pi i x_1)^2 psi(t abs(x)) + dots + (2pi i x_n)^2 psi(t abs(x)) = 0, $
$ abs(x)^2 psi'' (t abs(x)) -4pi^2 abs(x)^2 psi(t abs(x)) = 0. $
Возьмём $abs(x)=1$, тогда $psi''(t) - 4pi^2 psi(t) = 0$. Курс дифференциальных уравнений говорит нам, что решением служит $ psi(t) = C_1 e^(2pi t) + C_2 e^(-2pi t). $
$ hat(p)(x) = psi(abs(x)), quad hat(p) (0) = psi(0). $
$C_1$ должна быть равна нулю, чтобы было стремление к нулю преобразования Фурье, а что $C_2 = 1$ следует из равенства выше.
$ integral_(RR^n) f(x-y) p_t (y) d y = integral_(RR^n) hat(f)(xi) e^(2pi i scal(x,xi)) e^(-2pi t abs(xi)) d xi. $
Левая часть сходится к $f$ в $L^1$ из-за аппроксимативной единицы, и в $L^2$ происходит то же самое. Если правую часть рассматривать как функцию $u$ от $(t,x) in RR_+ times RR^n$, то $u$ гармоническая и если $f in L^p (RR^n)$, то $L^p-lim_(t -> 0) u(dot,t) = f(dot)$. Если $f in L^infinity (RR^n)$ и равномерное непрерывна#footnote([если не требовать равеномерную непрерывность, то сходимость будет поточеченой]), то $u(dot,t) arrows_(t -> 0) f(dot)$.\
Получили ещё одну формулу -- способ получать нечто вроде формулы обращения с помощью свёртки с ядром Пуассона. Восполним то, чем воспользовались выше.
== Преобразование Фурье при ортогональных преобразованиях
Пусть $V: RR^n arrow RR^n$ -- ортогональное преобразование, $f in L^1(RR^n)$.
$ hat(f compose V) (xi) = integral_(RR^n) f(V(x)) e^(-2pi i scal(x,xi)) d x = integral_(RR_n) f(u) e^(-2pi i scal(V^(-1) u, xi)) d u = $
$ = integral_(RR^n) f(u) e^(-2pi i scal(u, V xi)) d u = hat(f)(V xi) = (hat(f) compose V)(xi). $
Отсюда следует, что если функция $f$ зависит только от длины $f$, то есть радиальна, то её преобразование Фурье тоже радиально.
// Лекция 9 (30.10.2024)
== Функция Пуанкаре в круге
$ u(r e^(i theta)) = 1/pi integral_(-pi)^pi f(e^(i (x-theta))) frac(1-r^2,1-2r cos theta + r^2) d theta = sum_(n in ZZ) r^abs(n) hat(f) (n) e^(i n x). $
Посмотрим на случай $n=1$.
$ u(t,x) = integral_(-infinity)^infinity f(x-y) frac(t,pi(t^2+y^2)) d y, $
$ frac((1-r)(1+r),(1-r)^2 + 2r(1-cos theta)) = frac((1-r)(1+r),(1-r)^2+4r sin^2 theta/2) $
Заметно, что получаются весьма схожие вещи: $t$ похоже на $1-r$, а $x$ похоже на $2 sin theta/2$.

= Сходимость свёрток почти всюду
//"По современным _понятиям_, то, что я сейчас буду рассказывать входит в анализ Фурье" \u{00A9} С. В. Кисляков
Из сходимости функций в $L^p$ следует, то можно выбрать подпоследовательность, сходящуюся почти всюду, но для каждой функции такая последовательность будет своя.
== Максимальная функция Харди-Литтлвуда
$f in L^1 (RR^n)$, $x in RR^n$. Посмотрим на $ (M f)(x) := sup_(r>0) 1/abs(B_r (x)) integral_(B_r (x)) abs(f(t) d t ), $
где под модулем шарика подразумевается его объём. Получилась измеривая функция, ведь супремум можно брать по рациональным радиусам и тогда получится счётный супремум измеримых функций.
#example[
  $n=1$, $f = chi_[-1,1]$. Тогда $M f (x) >= c/abs(x)$ для достаточно больших $x$, так что она получилась не суммируемой.
]
Напомним неравенство Чебышёва: для $g in L^1 (RR^n)$ $ abs({abs(g)>t}) <= 1/t integral_(RR^n) abs(g(x)) d x = frac(norm(g),t). $
Откуда $abs({abs(g)>t}) = O (inline(1/t))$ -- условие не сильнее, чем $f in L^1$.
#theorem("Харди-Литтлвуда")[
  Существует константа $C = C_n$, что $forall f in L^1 (RR^n), quad forall t>0$ $ abs({x : M f (x) > t}) <= frac(C_n norm(f)_(L^1),t). $
]
Для знающих функциональный анализ это будет означать, что $M$ имеет слабый тип $(1,1)$.
#definition[
  $T$ -- сублинейный функционал на измеримых функциях, если $ abs(T(alpha f + beta g)) <= C (abs(alpha) dot abs(T(f)) + abs(beta) dot abs(T(g))). $
  - Он имеет сильный тип $(1,1)$, если $ norm(T f)_(L^1) <= C norm(f)_(L^1) $
  - Он имеет слабый тип $(1,1)$, если $ abs({abs(T f) > lambda}) <= frac(C norm(f)_(L^1),lambda) $
]
То есть в первом случае $T$ действует из $L^1$ и $L^1$, а во втором из $L^1$ в почти $L^1$, этим и обуславливается название.
#lemma("Винера")[
  Пусть $B_1, B_2, dots, B_N$ -- конечное множество шаров в $RR^n$. Тогда существует конечный поднабор попарно непересекающихся шаров $U_1, U_2, dots, U_k$, такой, что $ 3U_1 union 3U_2 union dots union 3U_k supset.eq union.big_(s=1)^N B_s, $
  где $A B_r (x) = B_(A r) (x)$.
]
#proof[
  Пусть $U_1$ -- шар наибольшего радиуса среди набора. Все шары, которые он пересекает содержатся в $3U_1$. Теперь пусть $U_2$ -- шар наибольшего радиуса среди тех, которые не пересекаются с $U_1$. Строя последовательность таким образом получим необходимый поднабор.
]
#proof("теоремы Харди-Литтлвуда")[
  Требуется оценить меру $A = {x : M f(x) > t}$. Возьмём комакт $K subset.eq A$ и докажем, что $ abs(K) <= frac(C_N norm(f)_(L^1),t). $
  Если $y in K$, то $M f(y) > t$, значит существует шар $B^((y))$ с центром в $y$ такой, что $ 1/abs(B^((y))) integral_(B^((y))) abs(f(t)) d t > t. $
  Шары $B^((y))$ покрывают $K$, значит можно выбрать конечное подпокрытие $B_1, dots, B_N$, для которых всё так же $ abs(B_i) < 1/t integral_(B_i) abs(f(t)) d t. $
  По лемме Винера можем выбрать среди них дизъюнктные $U_1, dots, U_M$, такие что $3U_1 union dots union 3U_M supset.eq K$. Теперь можно написать оценку $ abs(K) <= sum_(j = 1)^M abs(3U_j) = 3^n sum_(j=1)^M abs(U_j) <= frac(3^n,t) sum_(j=1)^M integral_(U_j) abs(f(t)) d t <= frac(3^n,t) norm(f)_(L^1). $
  По регулярности меры можно приближать $A$ компактами, чтобы мера тоже приближалась.
]
#underline[_Замечание_]: Пусть $mu$ -- конечная борелевская мера на $RR^n$. $ M mu(x) = sup_(r>0) 1/abs(B_r (x)) abs(mu)(B_r (x)). $
Тогда $abs({x : M mu (x) > t}) <= inline(frac(3^n,t)) abs(mu) (RR^n)$. Работает абсолютно аналогичное доказательство.

== Сильная теорема о дифференцировании

#definition[
  Дифференциальный базис -- совокупность измеримых множеств ${C_r}_(r>0)$, $abs(C_r)>0$, что существуют не зависящие от $r$ константы $a$ и $b$, такие что
  $ C_r subset.eq B_(a r) (0) " и " abs(C_r) >= b abs(B_r (0)). $
]
#theorem("о дифференцировании")[
  Если $h$ локально суммируема, то почти всюду $ lim_(r->0) 1/abs(C_r) integral_(C_r + x) h(y) d y = h(x). $
]
Её можно усилить теоремой Лебега, перенеся $h$ в левую часть и поставив модуль под интеграл.

#underline[_Замечание_]: Пусть $f = chi_E$, где $E$ -- измеримое множество положительной меры. Возьмём в теореме о дифференцировании $C_r = B_r (0)$, тогда для почти всех $x$ $ lim_(r->0) 1/abs(B_r (x)) abs(B_r (x) sect E) = cases(1","quad x in E, 0","quad x in.not E) $
// Лекция 10 (06.11.2024)
#theorem("Лебега")[
  Если $f in L^1(RR^n)$, то для почти всех $x$ $ lim_(t -> 0) 1/(abs(C_t)) integral_(C_t + x) abs(f(u) - f(x)) d u = 0. $
]
На самом деле понятно, что $f$ можно считать локально суммируемой. Обозначим
$ (tau f)(x) = overline(lim_(t -> 0)) 1/(abs(C_t)) integral_(C_t + x) abs(f(u)-f(x)) d u $
Тем самым надо показать, что $tau f = 0$ для почти всех $x$ и всякой $f in L^1(RR^d)$.

#proof[
  Докажем, что $lambda^* ({x : tau f(x) > s}) = 0 $ для всех $s>0$, где $lambda^*$ -- внешняя мера Лебега (иначе могут быть проблемы с измеримостью).
  $ tau f(x) <= sup_(t > 0) (1/abs(C_t) integral_(C_t + x) abs(f(u)) d u) + abs(f(x)), $
  //Подсупремумное выражение оценим через теорему Харди-Литтлвуда (не, это Х-Л дальше вроде)
  $ 1/(abs(C_t)) integral_(C_t + x) abs(f(u)) d u <= 1/(b t^d) integral_(B_(a t)(x)) abs(f(u)) d u = A/(abs(B_(a t))) integral_(B_(a t)(x)) abs(f(u)) d u, $
  $ sup_(t>0) (1/(abs(C_t)) integral_(x + C_t) abs(f(u)) d u) <= A (M f)(x), $
  $ lambda^* {x : tau f(x) > s} <= lambda{A M f > s/2} + lambda{abs(f) > s/2} <= C dot (2A)/S dot norm(f)_(L^1) + 2/s dot norm(f)_(L^1) = C' dot 1/s dot norm(f)_(L^1) $
  Звёздочки мы убрали, потому что тут множества измеримые.// Получили, что
  //$ lambda^* ({x : tau f (x) > s}) <= C' norm(f)_(L^1) dot 1/s $
  Если $phi$ -- непрерывная функция с компактным носителем, то $ tau phi eq.triple 0, $
  $ tau(f+g) <= tau(f) + tau(g) $
  $ f in L^1(RR^d), #h(2mm) epsilon > 0, #h(2mm) exists$ $phi$ -- непрерывная с компактным носителем такая, что $norm(f-phi)_(L^1) <= epsilon$.
  $ tau(f) <= tau(f-phi) + tau phi = tau(f-phi) $
]

Дополнение: Пусть $nu$ -- сингулярная борелевская мера на $RR^d$. Тогда почти всюду $ 1/(abs(C_t)) nu(x + C_t) arrow.long_(t arrow 0) 0 $
План доказательства:
- Если $nu$ сосредоточена на компакте $K$ и $lambda(K) = 0$, то это очевидно.
- Если $forall epsilon > 0 quad exists K : abs(nu - nu_K) <= epsilon, quad nu_K (e) = nu(K sect e),$ $lambda(K) = 0$, то тоже верно.
- Всякая конечная борелевская мера на $RR_d$ -- такая, как требуется в предыдущем пункте.

Пусть $rho$ -- конечная борелевская мера на $RR^d$. Тогда $rho = f dot lambda + nu$, где $nu$ сингулярная относительно меры Лебега и
$ 1/abs(C_t) rho(x+C_t) arrow.long_("п.в.") f(x) $

#corollary("Лебег")[
  Монотонная функция на $RR$ дифференцируема почти всюду.
]
#proof[
  $Phi$ -- возрастающая функция, нужен предел $ lim_(h arrow 0+) frac(Phi(x+h)-Phi(x),h). $
  Пусть $rho$ -- мера Лебега-Стилтьеса, порождённая функцией $Phi$. Можем считать, что $x$ и $x+h$ -- точки непрерывности, ведь точек разрыва не более чем счётное число. Под пределом стоит $ frac(rho([x,x+h)), abs([x,x+h))), $
  и это должно сойтись к плотности абсолютно непрерывной части меры $rho$ и производная как у функции $f$ из разложения $rho$ (#text(fill: author)[осторожно, какой-то скам]). Если в $x+h$ нет непрерывности, то всё равно всё хорошо, ведь скачки там не очень большие за счёт непрерывности в $x$.
]

#theorem[
  $Tau_alpha$ -- семейство операторов, что для каждого $alpha$ оператор $T_alpha$ отображает функции из $L^1(RR^d)$ в измеримые функции. Фиксировано некоторое $alpha_0$, к которому стремятся $alpha$.\
  - Пусть $forall f in L^1$, для почти всех $x$ выполнено $sup_(alpha) abs(T_alpha (f(x))) <= C (M f(x) + abs(f(x))).$

  - Существует плотное в $L^1$ множество $E$, что $forall g in E$ почти всюду выполнено $lim_(alpha -> alpha_0) T_alpha g(x) = 0. $

  - Пусть операторы $T_alpha$ субаддитивные: $exists D: abs(T_alpha (f_1 + f_2)) <= D(abs(T_alpha (f_1)) + abs(T_alpha (f_2))). $
  Тогда $forall f in L^1(RR^n)$ почти всюду выполняется $lim_(alpha -> alpha_0) T_alpha f(x) = 0$
]
#proof[
  $ tau f (x) = overline(lim_(alpha -> alpha_0)) abs(T_alpha f(x)) $
  $ lambda^* {tau f > s} <= lambda {M f > s/A} + lambda {abs(f) > s/A} <= frac(C' norm(f)_(L^1),s). $
  Если $phi in E$, то $tau f <= D' (tau(f-phi)+tau phi)$.
  $ S_t f (x) = f * u_t (x) = 1/(t^n) integral_(RR^n) u(y/t) f(x-y) d y, $
  $ u in L^1(RR^n), quad integral_(RR^n) u(x) d x = 1, quad u_t (x) = 1/t u(x/t). $
  $ T_t f(x) = 1/(t^n) integral_(RR^n) abs(u(y/t)) dot abs(f(x-y) - f(x)) d y $
  Хотим чтобы $lim_(t -> 0) T_t f(x) = 0$ почти всюду.
  $ sup_(t > 0) T_t f(x) <= sup_(t) 1/(t^n) integral_(RR^n) abs(u(y/t)) dot abs(f(x-y)) d y + abs(f(x)) $
  Из следующей теоремы будет следовать что $ #h(20mm) sup_(t) 1/(t^n) integral_(RR^n) abs(u(y/t)) dot abs(f(x-y)) d y <= C M f(x) #h(10mm) (star) $
]


#theorem[
  Оценка $(star)$ верная, если $u$ допускает суммируемую убывающую радиальную мажоранту, то есть $exists phi : [0,infinity) arrow [0,infinity)$, $phi$ убывает, $phi(abs(x))$ суммируема на $RR^n$ и $abs(u(x)) <= phi(abs(x))$.
]
#proof[
  $ 1/(t^n) integral_(RR^n) abs(u(y/t)) dot abs(f(x-y)) d y <= 1/(t^n) integral_(RR^n) phi(abs(y)/t) abs(f(x-y)) d y = $
  $ = 1/(t^n) integral_(abs(y) <= t) phi(y/t) abs(f(x-y)) d y + 1/(t^n) sum_(k=1)^infinity integral_(F) phi(abs(y)/t) abs(f(x-y)) d y <= $
  $ <= C (1/abs(B_t (0)) integral_(B_t (0)) abs(f(x-y)) d y dot phi(0) + 1/(t^n) sum_(k=1)^infinity phi(2^k) integral_(abs(y)<2^(k+1) t) abs(f(x-y)) d y) <= $
  $ <= C (M f(x) + sum_(k=1)^infinity abs(B_(2^(k+1) t) (0)) dot 1/abs(B(2^(k+1) t) (0)) dot integral_(B_(2^(k+1) t) (0)) abs(f(x-y)) d y dot phi(2^k)) <= $
  $ <= C M f(x) (phi(0) + sum_(k=1)^infinity (2^(k+1))^d dot phi(2^k)) <= C' M f(x) (phi(0) + integral_(RR^n) phi(abs(x)) d x). $
  $F = {y in RR^n : #h(2mm) 2^k t < abs(y) < 2^(k+1) t}$.
]
#example[
  + $u in cal(D)(RR^d)$. Тогда такая $phi$ существует. Действительно, носитель $u$ лежит в некотором шаре радиуса $R$. Легко построить функцию, равную единице на отрезке $[0,R]$ и имеющую компактный носитель. Домножив её на $max_(x in RR^n) u(x)$ получим нужную $phi$.
  + Ядро Пуассона. Такая функция сама по себе радиальна и суммируема. $ u(x) = frac(C,(1+abs(x)^2)^frac(n+1,2)), quad u_t (x) = frac(C t^n,(t^2+abs(x)^2)^frac(n+1,2)). $
  + Гаусово ядро $u(x) = e^(-pi abs(x)^2)$.
]
// Лекция 11 (13.11.2024)
== Случай окружности
$ M_TT f(zeta) = sup_(I in.rev zeta) 1/abs(I) integral_I abs(f(tau)) d tau, $
где $I$ -- дуги с центром в $zeta$.
#theorem[
  $abs({M_TT f > alpha}) <= C/alpha dot norm(f)_(L^1(TT)), quad alpha > 0.$
]
#proof[
  Периодично продолжаем функцию на отрезок $[-3pi,3pi]$, на остальной части ноль. Получившаяся функция $tilde(f)$ лежит в $L^1(RR)$, более того, $ norm(thin tilde(f) thin)_(L^1(RR)) <= 3 norm(f)_(L^1(TT)), quad M tilde(f) >= M_TT f, $
  $ abs({M_TT f > alpha}) <= abs({M tilde(f) > alpha}) <= frac(C,alpha) norm(thin tilde(f) thin)_(L^1 (RR)) <= frac(3C,alpha) norm(f)_(L^1(TT)). $
]
Рассмотрим $P_r (s) = frac(1-r^2, 1-2r cos s + r^2)$ -- ядро Пуассона.\
Нас будут интересовать свёртки $(f * P_r)(x)$ и сходятся ли они к $f$.
Для сходимости достаточно доказать, что $ sup_(r in [0,1)) abs(f * P_r (-)) <= C M_TT f(-). $
$ P_r (s) = (1+r) dot frac(1-r, (1-r)^2 + 2r (1-cos s)) = (1+r) dot frac(1-r, (1-r)^2 + 4r sin^2 s/2). $
Видно, что штука выше напоминает ядро Пуассона для полуплоскости: $1/pi dot frac(t,t^2 + x^2)$. Положим $t = 1-r$.
$ P_r (s) <= C dot frac(t,t^2+s^2). $
Тем самым, искомая сходимость действительно есть, если $f in L^1(TT)$. Теперь ответим на тот же вопрос для ядер Фейера.
$ Phi_N (s) = 1/(N+1) (frac(sin((N+1)/2)s,sin s/2))^2 <= C dot cases(N+1, 1/(N+1) dot 1/s^2) <= C dot frac(1/(N+1), 1/(N+1)^2 + s^2), quad t = 1/(N+1). $
$ sup_N abs(f * Phi_N) <= C M_TT f. $

= Многообразия и дифференциальные формы
== Общие разговоры о формуле Стокса
В свзяи с тем, что в третьем семестре времени у нас было мало, мы не успели пройти такие важные вещи. В общем сейчас это упущение наверстаем. Суть проста -- интеграл по границе многообразия выражается через интерграл по всему многообразию.
#example[
  Пусть $Gamma$ это стандартно ориентированная граница прямоугольника $[a,b] times [c,d]$,\ $Phi = f d x + g d y$ -- дифференциальная форма. Тогда
  $ integral_Gamma Phi = integral_Gamma f d x + g d y  = integral_a^b f(s,c) d s - integral_a^b f(s,d) d s + integral_c^d g(b,t) d t - integral_c^d g(a,t) d t = $ $ = -integral_a^b integral_c^d partial_2 f(s,t) d  s d t + integral_c^d integral_a^b partial_1 g(s,t) d s d t. $
  $ integral_Gamma Phi =  integral.double_P (partial_1 g - partial_2 f) $
  // ТУТ КРИВО ДВОЙНОЙ ИНТЕГРАЛ
]
Общая формула Стокса выглядит так:
#align(center, box(stroke: (gradient.linear(..color.map.rainbow)), inset: 1em)[$ integral_G d Omega = integral_(partial G) Omega $])
- $Omega$ -- внешняя дифференциальная форма
- $d$ -- внешний дифференциал
- $G$ -- ориенируемое многообразие с краем $partial G$, $dim G = k$, $G subset.eq RR^n$.\
Тут разгон про дифференциальные формы, который я не записал.

#definition[
  Многообразие с краем -- хаусдорфово топологическое пространство со счётной базой, такое, что у каждой точки есть окрестность, гомеоморфная либо кубу $(-1,1)^k$, либо полукубу $(-1,0] times (-1,1)^(k-1)$.
]
Точки, попадающие под второй случай, и будут краем многообразия. Проецированием атласа на край, легко показать, что край многообразия -- многообразие размерности $k-1$. Вводя ориентацию на многообразии мы тем самым вводим ориентацию и на его крае.
// Ну кому нужно определение линейной дифференциальной формы
Из четвёртого семестра мы знаем что такое линейная дифференциальная форма, напомним, что она имеет общий вид $ Phi(x,a) = sum_(j=1)^n phi_j (x) a_j, $
$ a = (a_1,dots,a_n), quad d x_j (h) = h_j, quad Phi(x,dot) = sum_(j=1)^n phi_j (x) d x_j. $
#definition[
  Полилинейная ($k$-линейная) форма на $RR^n$ -- линейная по каждому из аргументов $h$ функция $Psi(x,h^((1)),dots,h^((k)))$.
]
Можем разложить следующим образом: $h^((j)) = sum_(s=1)^n h_s^((j)) e_s$,
$ Omega(x,h^((1)),dots,h^((k))) = sum_(i_1,dots,i_k) omega_(i_1,dots,i_k) (x) h_(i_1)^((1)) dots h_(i_k)^((k)), $
$ omega_(i_1,dots,i_k)(x) = Omega(x,e_(i_1),dots,e_(i_k)). $
//#definition[
//  Пусть $gamma:[a,b] -> U$ -- гладкий путь. Тогда $ integral_gamma Phi = sum_(j=1)^n integral_a^b phi_j (gamma(t)) gamma_j^' (t) d t $
//]
Пусть $omega_(i_1,dots,i_k) = 1$, при фиксированном наборе $i_1,dots,i_k$, а на остальных наборах ноль. Тогда $Psi^(i_1,dots,i_k) (h^((1)),dots,h^((k))) = h_(i_1)^((1)) dots h_(i_k)^((k))$ -- базисные полилинейные формы.

_Простое_ $k$-мерное многообразие $G$ в $U$ имеет карту $X: Delta = (-1,1)^k arrow.long^("на") G$ класса $C^1$.\
Интеграл дифференциальной формы по такому многообразию определяется как $ I_Psi (G) =  integral_Delta sum_(i_1,dots,i_k) omega_(i_1,dots,i_k) compose X dot A^(i_1,dots,i_k) d lambda_k, $
$ A^(i_1,dots,i_k) = det mat(
  partial_1 X_(i_1) (u), ..., partial_k X_(i_1) (u);
  dots.v, dots.down, dots.v;
  partial_1 X_(i_k) (u), ..., partial_k X_(i_k) (u);). $
Для _непростых_ многообразий нужно устравивать гладкое разбиение единицы. Интеграл зависит от формы кососимметрично, поэтому если форма не меняется при перестановки двух переменных, то интеграл нулевой.
$ Psi_1 (x,h^((1)),dots,h^((k))) = 1/(k!) sum_(s in S_k) (-1)^sigma(s) Psi(x,h^((s_1)),dots,h^((s_k))) = "Alt"#h(0.3mm)Psi, $
$ I_Psi (G) = I_("Alt"#h(0.3mm)Psi) (G). $
То есть после альтернирования получается кососимметричная форма с тем же интегралом. Базисом в пространстве кососимметричных форм будет проальтернированный базис всех форм.
- $0$-форма -- просто функция
- $1$-форма -- там базисные формы это $phi(h)=h_j$, так что любая (они все кососимметричны) форма имеет вид $ sum_(j=1)^n omega_j (x) phi_j = sum_(j=1)^n omega_j (x) d x_j. $
- $k$-форма -- альтернирование формы $omega_(i_1,dots,i_k) (h^((1)),dots,h^((k))) = h_(i_1)^((1)) dots h_(i_k)^((k))$.
Введём обозначение $"Alt"#h(1mm)omega_(i_1,dots,i_k) = d x_(i_1) and dots and d x_(i_k)$, тогда
$ "Alt"#h(1mm)omega_(i_1,dots,i_k) (h^((1)),dots,h^((k))) = 1/(k!) det (h_(i l)^((m)))_(i,l = 1)^k. $
// Лекция 12 (20.11.2024)
Итак, всякая кососимметричная дифференциальная форма порядка $k$ в $U subset.eq RR^n$ имеет вид
$ Omega = sum_(i_1,dots,i_k) omega_(i_1,dots,i_k) d x_(i_1) and dots and d x_(i_k), $
где $omega_(i_1,dots,i_k)$ -- функции, заданные в $U$,
$ d x_(i_1) and dots and d x_(i_k) (h_(i_1)^((1)),dots,h_(i_k)^((k))) = "Alt"(h_(i_1)^((1)),dots,h_(i_k)^((k))). $
Такие формы не совсем базисные, так как они не обязательно линейно независимо, но можно всегда упорядочить переменные по возрастанию, однако запись получится весьма громоздкой, из-за чего часто допускается писать линейно зависимые части.

Внешнее произведение элементарных кососимметричных форм $ Omega_1 = omega d x_(i_1) and dots and d x_(i_k) quad "и" quad Omega_2 = eta d x_(j_1) and dots and d x_(j_l) $
это форма $ Omega_1 and Omega_2 = omega eta d x_(i_1) and dots and d x_(i_k) and d x_(j_1) and dots and d x_(j_l), $
на общий случай определение продолжается по линейности.

Если $f$ -- форма порядка ноль, то
$ d f = sum_(j=1)^n frac(partial f, partial x_j) d x_j. $
Для произвольной элементарной кососимметричной формы $Omega = omega_(i_1, dots, i_k) d x_(i_1) and dots and d x_(i_k)$ её внешний дифференциал по определению равен $ d Omega = (d omega_(i_1, dots, i_k)) and d x_(i_1) and dots and d x_(i_k), $
на общий случай, опять же, продолжаем по линейности.

#svo
+ Внешний дифференциал превращает $k$ формы в $k+1$ формы.
+ Внешний дифференциал линеен.
+ $Omega_1 and Omega_2 = (-1)^(k l) Omega_2 and Omega_1$.
+ $d (Omega_1 and Omega_2) = d Omega_1 and Omega_2 + (-1)^k Omega_1 and d Omega_2. $
  #proof[
    Можно считать, что $Omega_1 = f d x_(i_1) and dots and d x_(i_k)$, $Omega_2 = g d x_(j_1) and dots and d x_(j_k)$.
    $ Omega_1 and Omega_2 = f g thin d x_(i_1) and dots and d x_(i_k) and d x_(j_1) and dots and d x_(j_l), $
    $ d (Omega_1 and Omega_2) = (g d f + f d g) and x_(i_1) and dots and x_(i_k) and x_(j_1) and dots and x_(j_l) = $
    $ = d Omega_1 and Omega_2 + f (d g and x_(i_1) and dots and x_(i_k) and x_(j_1) and dots and x_(j_l)) = d Omega_1 and Omega_2 + (-1)^k Omega_1 and d Omega_2. $
  ]
+ $d d Omega = 0$, если, конечно же, коэффициенты в $C^2$.
  #proof[
    Вновь можно считать, что $Omega = f d x_(i_1) and dots and d x_(i_k)$. Тогда
    $ d Omega = d f and x_(i_1) and dots and d x_(i_k), $
    $ d d Omega = d d f and x_(i_1) and dots and d x_(i_k) + (-1)^k d f and d (x_(i_1) and dots and d x_(i_k)) $
    Понятно, что второе слагаемое равно нулю. Первое тоже, так как
    $ d f = frac(partial f, partial x_1) d x_1 + dots + frac(partial f, partial x_n) d x_n, $
    $ d d f = sum_(i=1)^n (sum_(j=1)^n frac(partial^2 f,partial x_i partial x_j) d x_j) and d x_i = 0. $
  ]
+ Нетрудно видеть, что $ (sum_(j=1)^k t_(1,j) d x_(i_j)) and (sum_(j=1)^k t_(2,j) d x_(i_j)) and dots and (sum_(j=1)^k t_(k,j) d x_(i_j)) = det(t_(i j)) thin d x_(i_1) and dots and d x_(i_k). $
+ Замена переменных.. Пусть $G$ -- область в $RR^n$ и $E$ -- область в $RR^m$. $Phi: E -> G$ -- гладкое отображение, дифференцируемое сколько надо раз. Пусть в $G$ имеется $k$-форма
  $ Omega = sum_(i_1,dots,i_k) omega_(i_1,dots,i_k) d x_(i_1) and dots and d x_(i_k) $
  $Phi$ представляется координатными функциями $Phi_1, dots, Phi_n$. Мы хотим определить композицию $Omega compose Phi$.
  #box(stroke: 0.5pt, inset: 5mm)[
    _Сергей Витальевич: Мнемоническое правило: подставляем $Phi$ всюду, где можно.\
    Богдан: А где нельзя?\
    Сергей Витальевич: А где нельзя, там и не подставить._]\
  $ Omega compose Phi = sum_(i_1,dots,i_k) omega_(i_1,dots,i_k) compose Phi med d Phi_(i_1) and dots and d Phi_(i_k). $
  Теперь покажем, что $ d(Omega compose Phi) = (d Omega) compose Phi. $
  #proof[
    $ d (Omega compose Phi) = sum_(i_1,dots,i_k) [d(omega_(i_1,dots,i_k) compose Phi) and Phi_(i_1) and dots and Phi_(i_k) + omega_(i_1,dots,i_k) compose Phi med d (d Phi_(i_1) and dots and d Phi_(i_k))] = $
    $ = sum_(i_1,dots,i_k) d(omega_(i_1,dots,i_k) compose Phi) and Phi_(i_1) and dots and Phi_(i_k), $
    $ d Omega = sum_(i_1,dots,i_k) [partial_1 omega_(i_1,dots,i_k) d x_(i_1) + dots + partial_n omega_(i_1,dots,i_k) d x_(i_n)] and d x_(i_1) and dots and d x_(i_k). $
    Подставим $Phi$ в одно слагаемое: $partial_1 omega_(i_1,dots,i_k) compose Phi d Phi_1 + dots + partial_n omega_(i_1,dots,i_k) compose Phi d Phi_n$, подставляя далее, выскакивают строки матрицы Якоби отображения $Phi$, в общем упражнение читателю.
  ]
+ Пусть $Omega = sum_(i_1,dots,i_k) omega_(i_1,dots,i_k) d x_(i_1) and dots d x_(i_k)$ -- $k$-форма в $RR^n$, $X: G -> RR^n$, где $G$ -- область в $RR^k$. Тогда
  $ integral_X Omega = integral_(id_G) Omega compose X, $
  где $id_G$ -- карта, в которой $G$ сама себя параметризует. Чтобы не возникало вопросов почему мы интегрируем по отображениям, положим
  $ integral_X Omega = sum_(i_1,dots,i_k) integral_G omega_(i_1,dots,i_k) compose X(u) det(frac(partial X^j (u),partial u_i)) d u. $
  #proof[
    $ Omega compose X = sum_(i_1,dots,i_k) omega_(i_1,dots,i_k) compose X med d X^(i_1) and dots and d X^(i_k), $
    $ d X^j = partial_1 X^j d u_1 + dots + partial_k X^j d u_k, $
    $ d X^(i_1) and dots and d X^(i_k) = det(frac(partial X^j,partial u_i)) d u_1 and dots and d u_k. $
    #text(fill: author)[Как сказал бы сейчас Андрей Чураков, _ну и всё тогда_.]]

Пусть $U subset.eq RR^k$ -- открытое множество, $M$ -- компактное ориентируемое многообразие размерности $k$ с краем. Пусть ${X_alpha}_(alpha in Lambda)$ -- ориентированный атлас для $M$. Каждое $X_alpha$ задано либо на кубе $Delta = (-1,1)^k$, либо на $tilde(Delta) = (-1,0] times (-1,1)^(k-1)$. Тем самым край будет объединением образов сужений отображений второго случая на $Delta_0 = {0} times (-1,1)^(k-1)$.
#lemma("о разбиении единицы")[
  Пусть $K subset.eq RR^n$ компактно. Тогда существуют $eta_1, dots, eta_s in cal(D)(RR^n)$ такие что $eta_i >= 0$, $sum_(i=1)^s eta_i <= 1$ и $sum_(i=1)^s eta_i (x) = 1$ при $x in K$. Причём диаметры носителей $eta_i$ сколь угодно малы.#footnote[#h(1mm)То есть зная изначально какой-то $epsilon>0$, можно устроить разбиение, у которого диаметры всех носителей меньше $epsilon$]#footnote[#h(1mm)#text(fill: author)[Кажется, обычно не оценивают единицей сумму $eta_i$ везде, а просто требуют, чтобы они не превосходили единицу]]
]
Согласно лемме Лебега о покрытии, можно считать, что каждый носитель $eta_i$ лежит в пределах какой-то координатной карты $U_i$. Пусть $Omega$ -- $(k-1)$-форма. Тогда $ integral_M Omega := sum_(i=1)^s integral_(U_i) eta_i Omega. $

#fact[
  Определение не зависит от разбиения единицы.
]
#proof[
  Пусть ${theta_j}_(j=1)^t$ -- ещё одно разбиение единицы и носители лежат в пределах координатных карт. Можем считать, что всё происходит в одном атласе, при необходимости их смешав.
  $ integral_M eta_i Omega = integral_(X_alpha(i)) eta_i Omega = sum_(j=1)^t integral_(X_alpha(i)) eta_i theta_j Omega = sum_(j=1)^t integral_(X_alpha(j)) eta_i theta_j Omega. $
  Просуммируем по $i$. Поменяв ролями $eta$ и $theta$ придём к тому, что требуется.
]
// Лекция 13 (27.11.2024)










