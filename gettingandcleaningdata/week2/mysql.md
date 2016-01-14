# Notes for week 2

I didn't bother making notes for week 1 (a mistake, I should have but whatever). First up is reading from MySQL. We install an R package for doing exactly this:


```r
install.packages("RMySQL")
```

Next up, we will be using the UCSC database as an example. This is a Genome Bioinformatics database (one of the best apparently). Found at `http://genome.ucsc.edu/goldenPath/help/mysql.html`


```r
library(RMySQL)
```

```
## Loading required package: DBI
```

```r
ucscDb <- dbConnect(MySQL(), user="genome", host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);
```

```
## [1] TRUE
```

This shows all the databases available on this server.


```r
result
```

```
##               Database
## 1   information_schema
## 2              ailMel1
## 3              allMis1
## 4              anoCar1
## 5              anoCar2
## 6              anoGam1
## 7              apiMel1
## 8              apiMel2
## 9              aplCal1
## 10             balAcu1
## 11             bosTau2
## 12             bosTau3
## 13             bosTau4
## 14             bosTau5
## 15             bosTau6
## 16             bosTau7
## 17             bosTau8
## 18           bosTauMd3
## 19             braFlo1
## 20             caeJap1
## 21              caePb1
## 22              caePb2
## 23             caeRem2
## 24             caeRem3
## 25             calJac1
## 26             calJac3
## 27             calMil1
## 28             canFam1
## 29             canFam2
## 30             canFam3
## 31             cavPor3
## 32                 cb1
## 33                 cb3
## 34                ce10
## 35                 ce2
## 36                 ce4
## 37                 ce6
## 38             cerSim1
## 39             choHof1
## 40             chrPic1
## 41                 ci1
## 42                 ci2
## 43             criGri1
## 44             danRer1
## 45            danRer10
## 46             danRer2
## 47             danRer3
## 48             danRer4
## 49             danRer5
## 50             danRer6
## 51             danRer7
## 52             dasNov3
## 53             dipOrd1
## 54                 dm1
## 55                 dm2
## 56                 dm3
## 57                 dm6
## 58                 dp2
## 59                 dp3
## 60             droAna1
## 61             droAna2
## 62             droEre1
## 63             droGri1
## 64             droMoj1
## 65             droMoj2
## 66             droPer1
## 67             droSec1
## 68             droSim1
## 69             droVir1
## 70             droVir2
## 71             droYak1
## 72             droYak2
## 73             eboVir3
## 74             echTel1
## 75             echTel2
## 76             equCab1
## 77             equCab2
## 78             eriEur1
## 79             eriEur2
## 80             felCat3
## 81             felCat4
## 82             felCat5
## 83             felCat8
## 84                 fr1
## 85                 fr2
## 86                 fr3
## 87             gadMor1
## 88             galGal2
## 89             galGal3
## 90             galGal4
## 91             gasAcu1
## 92             geoFor1
## 93                  go
## 94            go080130
## 95            go140213
## 96            go150121
## 97             gorGor3
## 98             hetGla1
## 99             hetGla2
## 100               hg16
## 101               hg17
## 102               hg18
## 103               hg19
## 104        hg19Patch10
## 105         hg19Patch2
## 106         hg19Patch5
## 107         hg19Patch9
## 108               hg38
## 109         hg38Patch2
## 110         hg38Patch3
## 111            hgFixed
## 112             hgTemp
## 113          hgcentral
## 114            latCha1
## 115            loxAfr3
## 116            macEug1
## 117            macEug2
## 118            melGal1
## 119            melUnd1
## 120            micMur1
## 121               mm10
## 122         mm10Patch1
## 123                mm5
## 124                mm6
## 125                mm7
## 126                mm8
## 127                mm9
## 128            monDom1
## 129            monDom4
## 130            monDom5
## 131            musFur1
## 132            myoLuc2
## 133            nomLeu1
## 134            nomLeu2
## 135            nomLeu3
## 136            ochPri2
## 137            ochPri3
## 138            oreNil1
## 139            oreNil2
## 140            ornAna1
## 141            oryCun2
## 142            oryLat2
## 143            otoGar3
## 144            oviAri1
## 145            oviAri3
## 146            panPan1
## 147            panTro1
## 148            panTro2
## 149            panTro3
## 150            panTro4
## 151            papAnu2
## 152            papHam1
## 153 performance_schema
## 154            petMar1
## 155            petMar2
## 156            ponAbe2
## 157            priPac1
## 158            proCap1
## 159     proteins120806
## 160     proteins121210
## 161     proteins140122
## 162     proteins150225
## 163           proteome
## 164            pteVam1
## 165            rheMac1
## 166            rheMac2
## 167            rheMac3
## 168                rn3
## 169                rn4
## 170                rn5
## 171                rn6
## 172            sacCer1
## 173            sacCer2
## 174            sacCer3
## 175            saiBol1
## 176            sarHar1
## 177            sorAra1
## 178            sorAra2
## 179           sp120323
## 180           sp121210
## 181           sp140122
## 182           sp150225
## 183            speTri2
## 184            strPur1
## 185            strPur2
## 186            susScr2
## 187            susScr3
## 188            taeGut1
## 189            taeGut2
## 190            tarSyr1
## 191            tarSyr2
## 192               test
## 193            tetNig1
## 194            tetNig2
## 195            triMan1
## 196            tupBel1
## 197            turTru2
## 198            uniProt
## 199            vicPac1
## 200            vicPac2
## 201           visiGene
## 202            xenTro1
## 203            xenTro2
## 204            xenTro3
## 205            xenTro7
```

**As you can see, there's a shitload**. Now let's do the same thing but connect to a specific database, namely `hg19` which is a particular build of the human genome. T 


```r
hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19",
                  host = "genome-mysql.cse.ucsc.edu")
```

The following command lists all the tables contained within the database `hg19`.


```r
allTables <- dbListTables(hg19)
head(allTables)
```

```
## [1] "HInv"         "HInvGeneMrna" "acembly"      "acemblyClass"
## [5] "acemblyPep"   "affyCytoScan"
```

Suppose we wanted the dimensions of a specific table. This is equivalent to showing the "data frames" that are within that table. The second argument in the function corresponds to a specific sequence of the genome.


```r
dbListFields(hg19, "affyU133Plus2")
```

```
##  [1] "bin"         "matches"     "misMatches"  "repMatches"  "nCount"     
##  [6] "qNumInsert"  "qBaseInsert" "tNumInsert"  "tBaseInsert" "strand"     
## [11] "qName"       "qSize"       "qStart"      "qEnd"        "tName"      
## [16] "tSize"       "tStart"      "tEnd"        "blockCount"  "blockSizes" 
## [21] "qStarts"     "tStarts"
```

Suppose we wanted to count how many rows in total the data frames. This is done with the following sql command:


```r
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
```

```
##   count(*)
## 1    58463
```

Suppose you wanted to now get a data frame. You do so with:


```r
affyData <- dbReadTable(hg19, "affyU133Plus2")
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 0 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 1 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 2 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 3 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 4 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 5 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 6 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 7 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 8 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 11
## imported as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 12
## imported as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 13
## imported as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 15
## imported as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 16
## imported as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 17
## imported as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 18
## imported as numeric
```

```r
# head(affyData) # huge
```

As you can see, this table is huge and there are some warnings about coercing data types. Ignore these. One important thing to do when extracting data frames is subsetting, since most tables are gigantic. Don't forget to clear the query and connection!


```r
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 0 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 1 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 2 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 3 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 4 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 5 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 6 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 7 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 8 imported
## as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 11
## imported as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 12
## imported as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 13
## imported as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 15
## imported as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 16
## imported as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 17
## imported as numeric
```

```
## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 18
## imported as numeric
```

```r
affyMis <- fetch(query) 
affyMis <- fetch(query, n=10) # fetches the first 10 lines
quantile(affyMis$misMatches)
```

```
##   0%  25%  50%  75% 100% 
##    1    1    2    3    3
```

```r
dbClearResult(query)
```

```
## [1] TRUE
```

```r
dim(affyMis)
```

```
## [1] 10 22
```

```r
dbDisconnect(hg19)
```

```
## [1] TRUE
```

Those are the basics of MySQL
