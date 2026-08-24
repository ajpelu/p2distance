# Welfare indicators of European countries

Quality of life indicators (*welfare indicators*) for 27 countries of
the European Union during the 2002-2007 period. For each variable (i.e.
indicator), both its definition and the year it refers to are given. The
data come from EurLIFE, an interactive database on quality of life in
Europe (see Source).

## Usage

``` r
data(welfare)
```

## Format

A data frame with 27 rows and 20 columns:

- `happiness`: Mean value on a scale from 1 ("very unhappy") to 10
  ("very happy"). Year: 2007.

- `life.satis`: Life satisfaction. Share of individuals aged 15 and over
  who are very or fairly satisfied with the life they lead. Year: 2006.

- `judicial`: Trust in the judicial system. Percentage of people aged 15
  and over who tend to trust justice or the legal system. Year: 2005.

- `night`: Unsafe to walk around at night. Percentage of individuals
  aged 18 and over who think it is very or rather unsafe to walk around
  the area they live in at night. Year: 2003.

- `social`: Satisfaction with social life. Percentage of the population
  aged 15 and over who are very or fairly satisfied with their social
  life. Year: 2004.

- `people`: Trust in people. Mean value on a scale from 1 ("you can't be
  too careful in dealing with people") to 10 ("most people can be
  trusted"). Year: 2007.

- `family`: Satisfaction with family life. Mean value on a scale from 1
  ("very dissatisfied") to 10 ("very satisfied"). Year: 2007.

- `health`: Satisfaction with the national health care system.
  Percentage of individuals who are very or fairly satisfied with their
  national health system. Year: 2002.

- `life.65`: Life expectancy at age 65. Average number of further years
  a person aged 65 would live if age-specific mortality rates remained
  constant. Year: 2003.

- `life.0`: Life expectancy at birth. Average number of years a person
  would live if age-specific mortality rates remained constant. Year:
  2005.

- `inequality`: Inequality of income distribution. Ratio of the total
  income received by the 20% of the population with the highest income
  to that received by the 20% with the lowest income. Year: 2005.

- `hobbies`: Too little time for hobbies and interests. Percentage of
  people aged 18 and over who have too little time for hobbies and
  interests. Year: 2007.

- `education`: Satisfaction with education. Mean value on a scale from 1
  ("very dissatisfied") to 10 ("very satisfied"). Year: 2007.

- `standard`: Satisfaction with standard of living. Mean value on a
  scale from 1 ("very dissatisfied") to 10 ("very satisfied"). Year:
  2007.

- `dist.school`: Distance to the nearest primary school. Proportion of
  people aged 15 and over who live within walking distance or within 20
  minutes of the nearest primary school. Years: 1999, 2005.

- `area`: Satisfaction with the area you live in. Share of individuals
  aged 15 and over who are very or fairly satisfied with the area they
  live in (five-item scale). Year: 2004.

- `home`: Satisfaction with the home. Share of individuals aged 15 and
  over who are very or fairly satisfied with their home (four-item
  scale). Year: 2004.

- `stress`: Find work stressful. Share of people who "strongly agree" or
  "agree" that their work is too demanding and stressful. Year: 2007.

- `employement`: Employment rate. Employed persons aged 15-64 as a
  percentage of the total population in that age group. Year: 2005.

- `job`: Job satisfaction. Percentage of employed people who are very or
  fairly satisfied with their job (four-item scale). Year: 2005.

## Source

EurLIFE database. Interactive database on quality of life in Europe.
European Foundation for the Improvement of Living and Working Conditions
(Eurofound). Accessed 20 Feb 2012.

## Details

These quality of life indicators come from different sources (Standard
Eurobarometer Surveys, European Quality of Life Surveys, Eurostat,
European Foundation for the Improvement of Living and Working
Conditions) collated by EurLIFE.

## References

Somarriba, N., & Peña, B. (2009). Synthetic Indicators of Quality of
Life in Europe. *Social Indicators Research*, 94, 115-133.

## Examples

``` r
data(welfare)
```
