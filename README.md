
## Notes (In case forget how to publish)

### 1.How to git

Quick setup — if you’ve done this kind of thing before or	
git@github.com:MediciHouse07/applied_math_finance.git
Get started by creating a new file or uploading an existing file. We recommend every repository include a README, LICENSE, and .gitignore.

…or create a new repository on the command line
```sh
echo "# repo_name" >> README.md 
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:MediciHouse07/repo_name.git
git push -u origin main
```
…or push an existing repository from the command 
```sh
git remote add origin git@github.com:MediciHouse07/applied_math_finance.git
git branch -M main
git push -u origin main

```
…or import code from another repository
You can initialize this repository with code from a Subversion, Mercurial, or TFS project.

Frequent process when uploading updates:
```
git add .
git commit -m ""
git push -u origin main
```

### Termnology used in the research
### Q&A

1.How does coredata function work?
It will extract the needed data and replace it with the new one
2.Why convert US UK rate in this way?

### Quick notes
#### Three way of checking data type
- class(x)
- mode(x)
- typeof(x)
- 9.592e-01 * 1 = 0.9592
- in file "get_fx.R", you can export exrate data from 2110-2204 period, around 6/7 months of data



#### Info in the earlier paper
- 8/40 prior to 1956 NT peg solely to USD
- 9/40 PLAZA accord 1985-1986 depreciation USD->appreciation Yen, bad for Japan export->PLAZA->US want to depreciate USD->seems didn't work->thought of the reason was from NIC & EU -> force TW NT to appreciate by link their currency to Yen
- Indonesia, suddenly acquired lots of international debt denoted in Yen, weight of Yen changed significantly

#### Sub task
- Find daily basis world exchange rate basket
- Verify the data
- Replicate the analysis grouply
- Check
- Target:what is today's currency basket
