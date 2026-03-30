# Time-Series-Econometrics

A collection of time-series econometrics projects covering AR, MA, ARIMA, Seasonal ARIMA, DL, ADL, and VAR models — developed as part of the **Time Series Econometrics** course at **International University – VNUHCM**.

---

## Final Project

### Inequality and Trade Openness in the U.S.: Is There a Significant Linkage?

**Authors:** Duong Thi Nhu Y (FAECIU23046) & Duong Hanh Trang (FAECIU23029)  
**Supervisor:** Ph.D. Do Hoang Phuong  
**Date:** January 2026  
**Institution:** School of Economics, Finance, and Accounting — International University, VNUHCM

---

### Research Overview

This paper empirically examines the dynamic relationship between **trade openness** and **income inequality** in the United States over the period **1972–2023**. Motivated by the ongoing debate around globalization's distributional consequences, the study addresses two key gaps in existing literature:

1. Most prior studies rely on cross-country panels; this paper focuses specifically on the U.S. economy over a long horizon.
2. Many studies omit **fiscal policy variables**, which can lead to omitted-variable bias in estimating trade's effect on inequality.

To address these gaps, the study incorporates **tax revenues** and **government spending** as control variables within a multivariate **Vector Autoregression (VAR)** framework.

---

### Data

| Variable | Description | Source |
|---|---|---|
| **Gini index** | Income inequality (% scale, 0–100) | World Bank WDI |
| **Trade openness** | (Exports + Imports) / GDP (%) | World Bank WDI |
| **Tax revenues** | Tax revenue as % of GDP | FRED |
| **Government spending** | General government expenditure as % of GDP | FRED |

- **Coverage:** United States, 1972–2023 (annual, 51 observations)
- **Data file:** `Final Project/data.dta` (Stata format)

---

### Methodology

1. **Unit Root Tests** — Augmented Dickey-Fuller (ADF): all variables are I(1) (non-stationary in levels, stationary at first difference).
2. **Lag Length Selection** — AIC, LR, FPE, SBIC/HQIC criteria; **AIC selects lag order 3 → VAR(3)**.
3. **Cointegration Test** — Johansen test reveals **no cointegrating relationship** (rank = 0); VECM is thus not employed.
4. **VAR(3) Estimation** — Estimated in levels following Sims (1990); estimators remain consistent for IRF analysis.
5. **Model Diagnostics:**
   - Stability: all characteristic roots lie within the unit circle (max modulus = 0.928) ✅
   - Residual autocorrelation: LM test fails to reject no-autocorrelation (p > 0.05 at lags 1 & 2) ✅
   - Granger causality: trade openness and fiscal variables **jointly** Granger-cause inequality (χ² = 19.55, p = 0.021).
6. **Impulse Response Functions (IRFs)** — Orthogonalized IRFs (OIRFs) and Forecast Error Variance Decomposition (FEVD) to trace dynamic effects.

---

### Key Findings

- **Trade openness → Gini:** No statistically significant response of the Gini index to trade shocks — contrary to the Stolper-Samuelson theorem. This aligns with the *technology-driven inequality* hypothesis.
- **Trade openness → Government spending:** A positive trade shock leads to an immediate and significant decline in government spending, consistent with **counter-cyclical fiscal behavior** (automatic stabilizers).
- Overall, trade openness influences U.S. fiscal dynamics but is **not the primary driver** of rising income inequality over the past five decades.

---

### Repository Structure

```
Time-Series-Econometrics/
├── Final Project/
│   ├── Final Project.do      # Stata analysis script (VAR, unit root, IRF)
│   ├── data.dta              # Dataset (Stata format, 1972-2023)
│   ├── myirfs.irf            # Saved IRF results
│   └── Latex/
│       ├── main.tex          # Main LaTeX document
│       ├── title.tex         # Title page
│       ├── setup.tex         # LaTeX packages & settings
│       ├── bibliography.bib  # References
│       ├── sections/
│       │   ├── 1 introduction.tex
│       │   ├── 2 lit-review.tex
│       │   ├── 3 method and ana.tex
│       │   ├── 4 IRF.tex
│       │   └── 5 conclusion.tex
│       ├── tables/           # LaTeX table inputs
│       └── appendixes/       # Appendix tables & figures
├── Assignments/
│   ├── Assignment 3/
│   ├── Assignment 4/
│   ├── Assignment 5/
│   └── Assignment 6/
└── README.md
```

---

### Replication

**Requirements:** Stata (any recent version)

```stata
cd "path/to/Final Project"
do "Final Project.do"
```

The script will:
- Load `data.dta`
- Plot time-series lines for all four variables
- Run ADF unit root tests
- Select lag order via `varsoc`
- Estimate VAR(3) and run diagnostics (LM test, Granger causality, stability)
- Conduct Johansen cointegration test
- Generate and graph OIRFs and FEVD
- Export IRF tables

All datasets and code are also available at:  
🔗 [github.com/trmuba2502/Time-Series-Econometrics/tree/main/Final%20Project](https://github.com/trmuba2502/Time-Series-Econometrics/tree/main/Final%20Project)

---

### Limitations

- Small sample (51 annual observations) may limit generalizability.
- The Gini index is survey-based and may carry measurement bias; it also does not capture non-income dimensions of inequality.
- Trade openness is measured as total trade flows (% of GDP) and does not distinguish *de facto* from *de jure* openness.
- VAR results are sensitive to lag length selection.

---

*Course: Time Series Econometrics | International University – VNUHCM | January 2026*
