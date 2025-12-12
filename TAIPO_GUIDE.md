# Taipo Layout Guide (Finnish Edition)

## Physical Layout

```
LEFT HAND:                    RIGHT HAND:
┌───┬───┬───┬───┐            ┌───┬───┬───┬───┐
│ 0 │ 1 │ 2 │ 3 │            │ 6 │ 7 │ 8 │ 9 │
│ P │ R │ M │ I │  TOP       │ I │ M │ R │ P │
├───┼───┼───┼───┤            ├───┼───┼───┼───┤
│10 │11 │12 │13 │            │16 │17 │18 │19 │
│ P │ R │ M │ I │  BOTTOM    │ I │ M │ R │ P │
└───┴───┴───┴───┘            └───┴───┴───┴───┘
        ┌───┬───┐            ┌───┬───┐
        │26 │27 │            │28 │29 │
        │Bsp│Spc│  THUMBS    │Spc│Bsp│
        └───┴───┘            └───┴───┘

P=Pinky, R=Ring, M=Middle, I=Index
```

## How Taipo Works

**Key concept**: Each letter = simultaneous press on ONE hand, alternating hands between letters.

- **Base** = finger keys only
- **+ Inner thumb** = numbers/brackets
- **+ Outer thumb** = shift/symbols
- **+ Both thumbs** = F-keys/functions

## Single-Key Chords

### Vowels (Bottom Row)
```
P = a    R = o    M = t    I = e
```

### Consonants (Top Row)
```
P = r    R = s    M = n    I = i
```

## Two-Key Chords (Same Hand)

### Bottom Row Combinations
```
R+I = c    R+M = u    P+M = q    P+R = l    M+I = h    P+I = d
```

### Top Row Combinations
```
M+I = y    R+I = f    R+M = p    P+M = z    P+R = b
```

## Finnish Characters ★

```
┌─────────────────────────────────────────┐
│  å = P+R (top)     [pinky+ring top]     │
│  ä = R(top)+P(bot) [diagonal]           │
│  ö = I(top)+R(bot) [diagonal]           │
└─────────────────────────────────────────┘
```

**OS keyboard layout must be Finnish or US-International**

Chord sends: å→`[`, ä→`'`, ö→`;`

## Cross-Row Chords

```
Top → Bottom (different fingers):
┌──────────────────────────────────────────┐
│ P(top)+I(bot) = d                        │
│ R(top)+I(bot) = v                        │
│ M(top)+I(bot) = ,  (comma)               │
│ M(top)+R(bot) = -  (minus)               │
│ M(top)+P(bot) = j                        │
│ I(top)+M(bot) = ?  (question)            │
│ I(top)+R(bot) = ö  ★ FINNISH             │
│ I(top)+P(bot) = w                        │
│ R(top)+M(bot) = /  (slash)               │
│ R(top)+P(bot) = ä  ★ FINNISH             │
│ P(top)+M(bot) = x                        │
│ P(top)+R(bot) = å  ★ FINNISH             │
│ P(top)+I(bot) = m                        │
│ I(top)+P(bot) = w                        │
└──────────────────────────────────────────┘
```

## Modifiers (Vertical Same-Finger)

```
P+P (same finger) = Win/Gui   [sticky]
R+R (same finger) = Alt       [sticky]
M+M (same finger) = Ctrl      [sticky]
I+I (same finger) = Shift     [sticky]
```

## Numbers (Base Chord + Inner Thumb)

```
c + thumb = 1    u + thumb = 2    q + thumb = 3
l + thumb = 4    y + thumb = 5    f + thumb = 6
p + thumb = 7    z + thumb = 8    b + thumb = 9
h + thumb = 0
```

## Special Keys

### Three-Finger Combos
```
R+M+I (top)    = Tab
R+M+I (bottom) = Enter
```

### With Outer Thumb (Shift/Symbols)
```
Any letter + outer thumb = CAPITAL
r + Spc = R    a + Spc = A    ä + Spc = Ä
```

### Navigation (Modifier + Outer Thumb)
```
Win  + Spc = →
Alt  + Spc = ↑
Ctrl + Spc = ↓
Shift+ Spc = ←
```

## Full Alphabet Reference

```
┌─────────────────────────────────────────┐
│ a=P(bot)   b=P+R(top)   c=R+I(bot)      │
│ d=P+I      e=I(bot)     f=R+I(top)      │
│ g=P+I(top) h=M+I(bot)   i=I(top)        │
│ j=M+P      k=I+R        l=P+R(bot)      │
│ m=P+I(top→bot) n=M(top) o=R(bot)        │
│ p=R+M(top) q=P+M(bot)   r=P(top)        │
│ s=R(top)   t=M(bot)     u=R+M(bot)      │
│ v=R+I(top→bot) w=I+P(top→bot) x=P+M     │
│ y=M+I(top) z=P+M(top)                   │
├─────────────────────────────────────────┤
│ å=P+R(top)                              │
│ ä=R(top)+P(bot)                         │
│ ö=I(top)+R(bot)                         │
└─────────────────────────────────────────┘
```

## Practice Words

Start with simple alternating patterns:

```
"hei"   = LEFT(M+I) RIGHT(I) LEFT(I)
"moi"   = LEFT(P+I) RIGHT(R) LEFT(I)
"sinä"  = LEFT(R) RIGHT(I) LEFT(M) RIGHT(R+P)
"kissa" = RIGHT(I+R) LEFT(I) RIGHT(R) LEFT(R) RIGHT(P)
"tämä"  = LEFT(M) RIGHT(R+P) LEFT(P) RIGHT(R+P)
```

**Remember**: Always alternate hands! L→R→L→R→L→R

## Learning Tips

1. **Start slow** - Accuracy before speed
2. **Master vowels first** - Bottom row single keys (a, o, t, e)
3. **Add common consonants** - Top row singles (r, s, n, i)
4. **Learn two-finger combos** - h, c, u, l
5. **Practice Finnish chars** - å, ä, ö patterns
6. **Increase speed** - Muscle memory develops over weeks

## Known Issues

- **ZMK #1899**: Very fast L+R rolls may glitch. Type at moderate speed initially.
- **Combo timeout**: Increase to 100-150ms if chords aren't registering reliably.

## Customization

See `config/taipo-finnish.dtsi` for all chord definitions. Each `TCOMBO` defines:
1. Base character
2. Shifted character (+ outer thumb)
3. Number/bracket (+ inner thumb)
4. Function key (+ both thumbs)
