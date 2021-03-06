# BLS county unemployment statistics: 2000 - 2016

The script scrapes and
combines [local area unemployment (LAU)](https://www.bls.gov/lau/)
statistics from the Bureau of Labor Statistics for all US counties and
Washington D.C. from 2000 to 2016.

Example
page:
[https://www.bls.gov/lau/laucnty16.txt](https://www.bls.gov/lau/laucnty16.txt).

### [`county_unemploy.csv`](https://github.com/btskinner/county_unemploy/blob/master/county_unemploy.csv) [[Raw]](https://raw.githubusercontent.com/btskinner/county_unemploy/master/county_unemploy.csv)

##### COLUMNS

| Name | Description|
|:-----|:-----------|
|`stfips`|State FIPS code|
|`fips`|County FIPS code|
|`county`|County name|
|`stabbr`|State abbreviation|
|`year`|Year|
|`labor_force`|Number in labor force|
|`employed `|Number employed|
|`unemployed`|Number unemployed|
|`unem_rate`|Unemployment rate|

