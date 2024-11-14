#import "@preview/ctheorems:1.1.3": *

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

#set page(width: 210mm, height: 297mm, margin: 1.5cm, numbering: none, number-align: right)
#set heading(numbering: "1.")

#let theorem = thmbox("теорема", "Теорема", fill: rgb("#98FB98"), stroke: 0.7pt).with(base_level: 0)
#let lemma = thmbox("лемма", "Лемма", fill: rgb("#D8BFD8"), stroke: 0.7pt).with(base_level: 0)
#let proposition = thmbox("предложение", "Предложение", fill: rgb("#FFC0CB"), stroke: 0.7pt).with(base_level: 0)
#let corollary = thmplain("следствие", "Следствие", stroke: 0.6pt, inset: 1em, radius: 0em).with(numbering: none)
#let definition = thmbox("определение", "Определение", fill: rgb("#ADD8E6"), stroke: 0.7pt).with(base_level: 0)

#let example = thmplain("пример", "Пример", stroke: 0.5pt, inset: 1em, radius: 0em).with(numbering: none)
#let fact = thmplain("факт", "Факт", stroke: 0.5pt, inset: 1em, radius: 0em).with(numbering: none)
#let proof = thmproof("доказательство", "Доказательство")

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
#align(text(40pt, font: "FreeMono")[*АНАЛИЗ ФУРЬЕ*])
#v(-5mm)
#align(text(15pt, font: "Comfortaa")[_Сергей Витальевич Кисляков_])
//#v(37mm)
#align(right+bottom, image(ipath+"4444.png", width: 30%))
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
  В третьем семестре мы доказывали, что свёртка суммируемой и бесконечно дифференцируемой (#text(fill: author)[кажется, хватило бы просто непрерывных]) с компактным носителем бесконечно гладкая, поэтому $gamma in C^(infinity) (RR)$. Значит
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
#figure(rect[#image(ipath+"anti-f.jpg", width: 40%)], caption: [⊂(◉‿◉)つ])

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
        figure(image(ipath+"Fourier2.jpeg", width: 60%), numbering: none, caption: [б) Жан-Батист Жозеф Фурье (1768 -- 1830)]),
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
То есть мы разбили отрезок на подотрезки от $k pi$ до $(k+1)pi$ и заменили $s$ на наибольшее значение. #text(fill: author)[Кажется, там лучше суммирование до $N-1$ вести, чтобы всё корректнее было.] Оценка сверху оставляется читателю в качесте упражнения.\

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

== Как получать аппроксимативные единицы?\
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

#svo
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
+ Из предыдущего пункта следует, что если $f in C^infinity (RR^n)$ и все производные начиная с нулевой суммируемы и стремятся к нулю на бесконечности, то $ (partial_1^(alpha_1) dots thin partial_n^(alpha_n) f)^(and) = (2pi i xi_1)^(alpha_1) dots thin (2pi i xi_n)^(alpha_1). $
+ Если $f$ как в пунке 7, то $hat(f)$ убывает быстрее любой степени $xi$:
  $ forall k in NN quad abs(hat(f)(xi)) (1/k + abs(xi)^k) arrow.long_(abs(xi) -> infinity) 0. $

// Лекция 6 (09.10.2024)



#pagebreak()

// Лекция 10 (06.11.2024)

#definition[
  Дифференциальный базис -- совокуплность измеримых множеств ${C_n}$, такая что,
  $ exists a, b quad C_r subset.eq B_(a r) " и " abs(C_r) >= b abs(B_r(0)) $
  Похуй, потом
]
#theorem("Лебега")[
  Если $f in L^1(RR^n)$, то $ lim_(t -> 0) 1/(abs(C_t)) integral_(C_t + x) abs(f(u) - f(x)) d u = 0 $ для почти всех $x$.
  $ (tau f)(x) = overline(lim_(t -> 0)) 1/(abs(C_t)) integral_(C_t + x) abs(f(u)-f(x)) d u $
  То есть надо: $tau f = 0$ для почти всех $x$. $forall f in L^1(RR^d)$
]
#proof[
  $lambda^* ({x : tau f(x) > s}) = 0 quad forall s>0? $
  $tau f(x) <= sup_(t > 0) (1/abs(C_t) integral_(C_t + x) abs(f(u) d u)) + abs(f(x))$
  $ 1/(abs(C_t)) integral_(C_t + x) abs(f(u)) d u <= 1/(b t^d) integral_(B_(a t)(x)) abs(f(u)) d u = A/(abs(B_(a t))) integral_(B_(a t)(x)) abs(f(u)) d u $
  $ sup_(t>0) (1/(abs(C_t)) integral_(x + C_t) abs(f(u)) d u) <= A (M f)(x) $
  $ lambda^* {tau f > s} <= lambda{A M f > s/2} + lambda{abs(f) > s/2} <= lambda^* ({x : tau f (x) > s}) <= C' norm(f)_(L^1) dot 1/s $
  $"хуй" <= C dot (2A)/S dot norm(f)_(L^1) + 2/s dot norm(f)_(L^1) = C' dot 1/s dot norm(f)_(L^1) $
  Если $phi$ -- непрерывная функция с компактным носителем, то $ tau phi eq.triple 0, $
  $ tau(f+g) <= tau(f) + tau(g) $
  $ f in L^1(RR^d), quad epsilon > 0,$
  Существует $phi$ -- непрерывная с компактным носителем такая, что $norm(f-phi)_(L^1) <= epsilon$.
  $tau(f) <= tau(f-phi) + tau phi = tau(f-phi)$
]

Дополнение: Пусть $nu$ -- сингулярная борелевская мера на $RR^d$. Тогда почти всюду $ 1/(abs(C_t)) nu(x + C_t) arrow.long_(t arrow 0) 0 $
План доказательства:
- Если $nu$ сосредоточена на компакте $K$, то $lambda(K) = 0$
- Если $forall epsilon > 0 quad exists K : abs(nu - nu_K) <= epsilon, quad nu_K(e) = nu(K sect e), lambda(K) = 0. $
- Всякая конечная борелевская мера на $RR_d$ -- такая, как требуется в предыдущем пункте.

Пусть $rho$ -- конечная борелевская мера на $RR^d$.\
Тогда $rho = f dot lambda + nu$, где $nu$ сингулярная относительно меры Лебега.\
$ 1/abs(C_t) rho(x+C_t) arrow.long_("п. в.") f(x) $

Следствие (Лебег): Монотонная функция на $RR$ дифференцируема почти всюду. $Phi$ -- возрастающая функция, нужем предел $lim_(h arrow +0) frac(Phi(x+h)-Phi(x),h)$.\
$rho$ -- мера Лебега-Стилтьеса, порождённая функцией $Phi$.

#theorem[
  $Tau_alpha$ -- семейство операторов, что $forall alpha quad T_alpha$ отображает функции из $L^1(RR^d)$ в измеримые функции. Фиксировано некоторое $alpha_0$, к которому стремятся $alpha$.\
  - Пусть $forall f in L^1$, для почти всех $x$ $ sup_(alpha) abs(T_alpha (f(x))) <= C (M f(x) + abs(f(x))). $
  - Существует плотное в $L^1$ множество $E$, что $forall g in E$ почти всюду выполняется $ lim_(alpha -> alpha_0) T_alpha g(x) = 0. $
  - Пусть операторы $T_alpha$ субаддитивные: $ exists D: abs(T_alpha (f_1 + f_2)) <= D(abs(T_alpha (f_1)) + abs(T_alpha (f_2))). $
  Тогда $forall f$ in $L^1(RR^n)$ почти всюду выполняется $lim_(alpha -> alpha_0) T_alpha f(x) = 0$
]
#proof[
  $ tau f (x) = overline(lim_(alpha -> alpha_0)) abs(T_alpha f(x)) $
  $ lambda^* {tau f > s} <= lambda {M f > s/A} + lambda {abs(f) > s/A} <= frac(C' norm(f)_(L^1),s). $
  Если $phi in E$, то $tau f <= D' (t) "хуй"$
  $ S_t f (x) = f * u_t (x) = 1/(t^n) integral_(RR^n) u(y/t) f(x-y) d y $
  $u in L^1(RR^n)$, $integral_(RR^n) u(x) d x = 1$
  $ u_t (x) = 1/t u(x/t). $
  $ T_t f(x) = 1/(t^n) integral_(RR^n) abs(u(y/t)) dot abs(f(x-y) - f(x)) d y $
  Хотим: $lim_(t -> 0) T_t f(x) = 0$ почти всюду.
  $ sup_(t > 0) T_t f(x) <= sup_(t) 1/(t^n) integral_(RR^n) abs(u(y/t)) dot abs(f(x-y)) d y + abs(f(x)) $
  Верно ли, что $sup_(t) 1/(t^n) integral_(RR^n) abs(u(y/t)) dot abs(f(x-y)) d y <= C M f(x) (*)$
]


#theorem[
  Оценка $star$ верная, если $u$ допускает суммируемую убывающую радиальную мажоранту, то есть $exists phi : [0,infinity) arrow [0,infinity)$, $phi$ убывает и $phi(abs(x))$ суммируема на $RR^d$ и $abs(u(x)) <= phi(abs(x))$.
]
#proof[
  $1/(t^d) integral_(RR^d) abs(u(y/t)) dot abs(f(x-y)) d y <= 1/(t^d) integral_(RR^d) phi(abs(y)/t) abs(f(x-y)) d y = $
  $ = 1/(t^d) integral_(abs(y) <= t) phi(y/t) abs(f(x-y)) d y + 1/(t^d) sum_(k=1)^infinity integral_(F) phi(abs(y)/t) abs(f(x-y)) d y <= $
  $ <= C (1/abs(B_t (0)) integral_(B_t (0)) abs(f(x-y)) d y phi(0) + 1/(t^d) sum_(k=1)^infinity phi(2^k) integral_(abs(y)<2^(k+1) t) abs(f(x-y)) d y) <= $
  $ <= C (M f(x) + sum_(k=1)^infinity abs(B(2^(k+1) t) (0)) dot 1/abs(B(2^(k+1) t) (0)) dot integral_(B_(2^(k+1) t) (0)) abs(f(x-y)) d y dot phi(2^k)) <= $
  $ <= C M f(x) (phi(0) + sum_(k=1)^infinity (2^(k+1))^d dot phi(2^k)) <= C' M f(x) (phi(0) + integral_(RR^d) phi(abs(x)) d x) $
  $ F = {y : quad 2^k t < abs(y) < 2^(k+1) t}$
]


// Лекция ХХ (13.11.2024)
#pagebreak()

== На окружности
$ M_TT f(zeta) = sup_(I in.rev zeta) 1/abs(I) integral_I abs(f(tau)) d tau, $
где $I$ -- дуги с центром в $zeta$.
#theorem[
  $abs({M_TT f > alpha}) <= C/alpha dot norm(f)_(L^1(TT)), quad alpha > 0.$
]
#proof[
  Периодично продолжаем функцию на отрезок $[-3pi,3pi]$, на остальной части ноль. Получившаяся функция $tilde(f)$ лежит в $L^1(RR)$, более того, $ norm(tilde(f))_(L^1(RR)) <= 3 norm(f)_(L^1(TT)). $
  $ M tilde(f) >= M_TT f. $
  "Думаю это можно стереть всё" (с) С. В. Кисляков. Поэтому я не записал тут что-то.
]
$P_r (s) = frac(1-r^2, 1-2r cos s + r^2)$ -- ядро Пуассона.\
$(f * P_r)(x)$ -- сходятся ли к $f$?
Для сходимости достаточно доказать, что $ sup_(r in [0,1)) abs(f * P_r (-)) <= C M_TT f(-). $
$ P_r (s) = (1+r) dot frac(1-r, (1-r)^2 + 2r (1-cos s)) = (1+r) dot frac(1-r, (1-r)^2 + 4r sin^2 s/2). $
Положим $t = 1-r$.\
Ядро Пуассона для полуплоскости: $1/pi dot frac(t,t^2 + x^2)$.\
$ P_r (s) <= C dot frac(t,t^2+s^2). $
Тем самым, искомая сходимость действительно есть, если $f in L^1(TT)$. Теперь ответим на тот же вопрос для ядер Фейера.
$ Phi_N (s) = 1/(N+1) (frac(sin((N+1)/2)s,sin s/2))^2 <= C dot cases(N+1, 1/(N+1) dot 1/s^2) <= C dot frac(1/(N+1), 1/(N+1)^2 + s^2), quad t = 1/(N+1). $
$ sup_N abs(f * Phi_N) <= C M_TT f. $

= Формула Стокса
В свзяи с тем, что в третьем семестре времени у нас было мало, мы не успели пройти такие важные вещи. В общем сейчас это упущение наверстаем. Суть проста -- интеграл по границе многообразия выражается через интерграл по всему многообразию.
#example[
  Пусть $Gamma$ это стандартно ориентированная граница прямоугольника $[a,b] times [c,d]$,\ $Phi = f d x + g d y$ -- дифференциальная форма. Тогда
  $ integral_Gamma Phi = integral_Gamma f d x + g d y  = integral_a^b f(s,c) d s - integral_a^b f(s,d) d s + integral_c^d g(b,t) d t - integral_c^d g(a,t) d t = $ $ = -integral_a^b integral_c^d = "бля ну нахуя сразу стирать" $
  $ integral_Gamma Phi =  integral.double_P (partial_1 g - partial_2 f) $
]
Общая формула Стокса выглядит так:
#align(center, box(stroke: (gradient.linear(..color.map.rainbow)), inset: 1em)[$ integral_G d Omega = integral_(partial G) Omega $])
где $Omega$ -- внешняя дифференциальная форма, $d$ -- внешний дифференциал, $G$ -- ориенируемое многообразие с краем $partial G$, $dim G = k$, $G subset.eq RR^n$.\
Тут разгон про дифференциальные формы, который я не записал.
