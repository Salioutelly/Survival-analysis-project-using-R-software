# Survival-analysis-project-using-R-software
# 🩺 Survival Analysis on Healthcare Dataset

> A statistical project using survival analysis techniques to evaluate the influence of variables such as age, gender, and medical condition on patient survival times.

## 📌 Project Overview

This project conducts a **survival analysis** on a healthcare dataset using both **non-parametric** and **semi-parametric** methods. The goal is to assess whether different factors (age, gender, and medical condition) significantly impact patient survival times.

---

## 🧹 I. Data Preprocessing

- **Dataset Columns:**
  - `Survival.Time`, `Date.of.Admission`, `Discharge.Date`, `Gender`, `Medical.Condition`, `Age`

- **Cleaning & Validation:**
  - ✅ No missing values
  - ✅ No negative survival times
  - ✅ No unrealistic values (i.e., all survival times ≤ 365 days)
  - ✅ Calculated survival times matched provided values

- **Data Type Conversion:**
  - Variables such as `Survival.Time`, `Medical.Condition`, and `Admission.Type` were properly converted to appropriate data types.

---

## 📊 II. Data Modeling

### 1. 🔹 Kaplan-Meier Estimator

- **Method:** Non-parametric estimation of survival for each group.
- **Groups Analyzed:** Arthritis, Asthma, Cancer, Diabetes, Hypertension, Obesity
- **Result:** Survival curves are visually similar across groups.
- **Log-Rank Test:**
  - p-value = 0.2 → No statistically significant difference across medical conditions.

---

### 2. 🔸 Log-Rank Test (Group Comparison)

- **Chi-Square Statistic:** 6.8 on 5 degrees of freedom
- **p-value:** 0.2
- **Conclusion:** No significant difference in survival between groups.

---

### 3. ⚙️ Cox Proportional Hazards Model

- **Predictors:** Age, Gender, Medical Condition
- **Results:**
  - All hazard ratios ≈ 1 → Minimal influence on survival time.
  - Age: HR = 0.9997
  - Gender (male): HR = 0.9904
  - All medical conditions: p > 0.05 (not significant)

- **Model Statistics:**
  - Concordance Index: 0.504 → Low predictive power
  - Likelihood Ratio, Wald, and Score tests: p = 0.2 (non-significant)

---

## 📈 Visual Representations

- **Kaplan-Meier Curves** for different medical conditions
- **Cox Model Forest Plot** showing hazard ratios for each predictor

---

## ✅ Conclusion

- There is **no significant difference** in survival across different medical conditions.
- **Cox model confirms** that age, gender, and medical condition have minimal impact on survival in this dataset.
- The dataset may lack important variables or sufficient variation to explain survival outcomes.
- Future work should consider:
  - Including more clinical variables
  - Expanding the dataset size
  - Incorporating external risk factors

---

## 💻 Tools & Libraries Used

- Python (e.g., `lifelines`, `pandas`, `matplotlib`)
- Jupyter Notebook
- Statistical methods: Kaplan-Meier, Log-Rank Test, Cox Regression

---

## 📎 References

- Medical dataset (unspecified)
- Lifelines documentation: https://lifelines.readthedocs.io/

---

