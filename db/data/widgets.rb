Widget.create!([
  {id: 2, name: "Body Mass Index (BMI)", slug: "body-mass-index-bmi", graphic_type: "line", legend: "", source: "<p>Body mass index (BMI) is a measure of body fat based on height and weight that applies to adult men and women.</p>", query: "SELECT male AS valuey1, female AS valuey2, year FROM bmi_indicator where iso = '{{COUNTRY_ISO}}' ORDER BY year ASC", created_at: "2016-11-07 14:59:52", updated_at: "2016-11-14 10:31:34", x_axis: "{\r\n  \"name\": \"Years\"\r\n}", y_axis: "{\r\n\"name\": \"Kg/m2\",\r\n\"values\": [{\"name\": \"Male Index\", \"slug\": \"valuey1\"}, {\"name\": \"Female Index\", \"slug\": \"valuey2\"}]\r\n}"},
  {id: 7, name: "Extreme Poverty - Poverty headcount ratio at $1.90 a day (2011 PPP)", slug: "extreme-poverty-poverty-headcount-ratio-at-1-90-a-day", graphic_type: "bar", legend: "", source: "<p>Poverty headcount ratio at $1.90 a day is the percentage of the population living on less than $1.90 a day at 2011 international prices. As a result of revisions in PPP exchange rates, poverty rates for individual countries cannot be compared with poverty rates reported in earlier editions. Source data:</p>\r\n<div class=\"m-modal-content\">\r\n<p><a target=\"_blank\" href=\"http://data.worldbank.org/indicator/SI.POV.DDAY?locations=1W&start=1981&end=2012\">http://data.worldbank.org/indicator/SI.POV.DDAY?locations=1W&start=1981&end=2012</a></p>\r\n", query: "SELECT * FROM poverty_by_year where (iso = '{{COUNTRY_ISO}}' and valuey1 is not null) order by year asc", created_at: "2016-11-07 16:00:39", updated_at: "2016-11-11 14:14:22", x_axis: "{\r\n  \"name\": \"Years\"\r\n}", y_axis: "{\r\n  \"name\": \"% of population in Extreme Poverty\",\r\n  \"values\": [{\"name\": \"% of population\", \"slug\": \"valuey1\"}]\r\n}"},
  {id: 8, name: "Smoking prevalence", slug: "smoking-prevalence", graphic_type: "bar", legend: "{\r\n  \"type\": \"lines\",\r\n  \"items\": [{\"value\": \"Male Prevalence of current tobacco use\", \"color\": \"{{##COLOR###}}\"}, {\"value\": \"Male Prevalence of smoking any tobacco product\", \"color\": \"###COLOR###\"}, {\"value\": \"Female Prevalence of smoking current tobacco product\", \"color\": \"###COLOR###\"}, {\"value\": \"Female Prevalence of smoking any tobacco product\", \"color\": \"###COLOR###\"}]\r\n}", source: "<p>Prevalence of smoking, male is the percentage of men ages 15 and over who smoke any form of tobacco, including cigarettes, cigars, pipes or any other smoked tobacco products. Data include daily and non-daily or occasional smoking. Source data:</p>\r\n<div class=\"m-modal-content\">\r\n<p><a target=\"_blank\" href=\"http://data.worldbank.org/indicator/SH.PRV.SMOK.MA\">http://data.worldbank.org/indicator/SH.PRV.SMOK.MA</a></p>\r\n\r\n\r\n", query: "SELECT country, iso, year, any_tobacco_male as valuey2, tobacco_male as valuey1, prevalence_of_current_tobacco_use_female as valuey3, prevalence_of_smoking_any_tobacco_product_female as valuey4 FROM prevalence_tobacco where iso = '{{COUNTRY_ISO}}'  order by year asc", created_at: "2016-11-07 16:05:29", updated_at: "2016-11-14 10:58:19", x_axis: "{\r\n  \"name\": \"Years\"\r\n}", y_axis: "{\r\n  \"name\": \"% of adults\",\r\n  \"values\": [{\"name\": \"Male current tobacco use\", \"slug\": \"valuey1\" }, \r\n                  {\"name\": \"Male any tobacco product\", \"slug\": \"valuey2\"}, \r\n                  {\"name\": \"Female current tobacco product\", \"slug\": \"valuey3\"},\r\n                  {\"name\": \"Female any tobacco product\", \"slug\": \"valuey4\"}]\r\n}"},
  {id: 4, name: "Physicians (per 1,000 people)", slug: "physicians", graphic_type: "bar", legend: "", source: "<p>Physicians include generalist and specialist medical practitioners. Source data:</p>\r\n<p><a target=\"_blank\" href=\"http://data.worldbank.org/indicator/SH.MED.PHYS.ZS\">http://data.worldbank.org/indicator/SH.MED.PHYS.ZS</a></p>", query: "SELECT iso, valuey1, year FROM physicians where (iso = '{{COUNTRY_ISO}}' AND valuey1 IS NOT NULL) ORDER BY year ASC", created_at: "2016-11-07 15:09:33", updated_at: "2016-11-11 13:29:48", x_axis: "{\r\n  \"name\": \"Years\"\r\n}", y_axis: "{\r\n  \"name\": \"Number per each 1,000 people\",\r\n  \"values\": [{\"name\": \"Number per each 1,000 people\", \"slug\": \"valuey1\"}]\r\n}\r\n"},
  {id: 1, name: "Recorded alcohol per capita consumption, from 2000", slug: "recorded-alcohol-per-capita-consumption-from-2000", graphic_type: "line", legend: "{\r\n  \"type\": \"lines\",\r\n  \"items\": [{\"value\": \"Beer\", \"color\": \"{{##COLOR###}}\"}, {\"value\": \"All Types\", \"color\": \"###COLOR###\"}, {\"value\": \"Other alcoholic beverages\", \"color\": \"###COLOR###\"}, {\"value\": \"Spirits\", \"color\": \"###COLOR###\"}, {\"value\": \"Spirits\", \"color\": \"###COLOR###\"}, {\"value\": \"Wine\", \"color\": \"###COLOR###\"}]\r\n}", source: "<p>Recorded APC is defined as the recorded amount of alcohol consumed per capita (15+ years) over a calendar year in a country, in litres of pure alcohol. The indicator only takes into account the consumption which is recorded from production, import, export, and sales data often via taxation. Numerator: The amount of recorded alcohol consumed per capita (15+ years) during a calendar year, in litres of pure alcohol. Denominator: Midyear resident population (15+ years) for the same calendar year, UN World Population Prospects, medium variant. Source data:</p>\r\n<div class=\"m-modal-content\">\r\n<p><a target=\"_blank\" href=\"http://apps.who.int/gho/data/node.main.A1026\">http://apps.who.int/gho/data/node.main.A1026</a></p>\r\n", query: "SELECT wine AS valuey1, beer AS valuey2, alltypes AS valuey3, other AS valuey4, spirits AS valuey5, year FROM alcohol_all_data_by_year where iso = '{{COUNTRY_ISO}}' order by year asc", created_at: "2016-11-07 14:52:25", updated_at: "2016-11-11 12:25:55", x_axis: "{\r\n  \"name\": \"Years\"\r\n}", y_axis: "{\r\n  \"name\": \"Litres of pure alcohol\",\r\n  \"values\": [{\"name\": \"Wine\", \"slug\": \"valuey1\"}, \r\n                  {\"name\": \"Beer\", \"slug\": \"valuey2\"}, \r\n                  {\"name\": \"All types of beverages\", \"slug\": \"valuey3\"}, \r\n                  {\"name\": \"Other types\", \"slug\": \"valuey4\"}, \r\n                  {\"name\": \"Spirits\", \"slug\": \"valuey5\"}]\r\n}"},
  {id: 6, name: "Out-of-pocket health expenditure", slug: "Out-of-pocket-health-expenditure", graphic_type: "bar", legend: "", source: "<p>Out of pocket expenditure is any direct outlay by households, including gratuities and in-kind payments, to health practitioners and suppliers of pharmaceuticals, therapeutic appliances, and other goods and services whose primary intent is to contribute to the restoration or enhancement of the health status of individuals or population groups. It is a part of private health expenditure. Source data:</p>\r\n<div class=\"m-modal-content\">\r\n<p><a target=\"_blank\" href=\"http://data.worldbank.org/indicator/SH.XPD.OOPC.TO.ZS\">http://data.worldbank.org/indicator/SH.XPD.OOPC.TO.ZS</a></p>", query: "SELECT * FROM out_of_pocket_health_expenditure where (iso = '{{COUNTRY_ISO}}' and valuey1 is not null) order by year asc", created_at: "2016-11-07 15:53:15", updated_at: "2016-11-11 14:18:37", x_axis: "{\r\n  \"name\": \"Years\"\r\n}", y_axis: "{\r\n  \"name\": \"Percentage of total expenditure on health\",\r\n  \"values\": [{\"name\": \"% of total\", \"slug\": \"valuey1\"}]\r\n}"},
  {id: 10, name: "Cause of death, by non-communicable diseases", slug: "cause-of-death-by-non-communicable-diseases", graphic_type: "bar", legend: "", source: "<p>Cause of death refers to the share of all deaths for all ages by underlying causes. Non-communicable diseases include cancer, diabetes mellitus, cardiovascular diseases, digestive diseases, skin diseases, musculoskeletal diseases, and congenital anomalies. Source data:</p>\r\n<div class=\"m-modal-content\">\r\n<p><a target=\"_blank\" href=\"http://data.worldbank.org/indicator/SH.DTH.NCOM.ZS\">http://data.worldbank.org/indicator/SH.DTH.NCOM.ZS</a></p>\r\n\r\n\r\n\r\n", query: "SELECT country, iso, valuey1, year FROM non_communicable_diseases where (iso = '{{COUNTRY_ISO}}'  and valuey1 is not null) order by year asc", created_at: "2016-11-07 16:19:10", updated_at: "2016-11-11 14:12:20", x_axis: "{\r\n  \"name\": \"Years\",\r\n  \"values\": [{\"name\": \"Prevalence of current tobacco use\", \"slug\": \"valuey1\" }, \r\n                  {\"name\": \"Prevalence of smoking any tobacco product\", \"slug\": \"valuey2\"}]\r\n}", y_axis: "{\r\n  \"name\": \"Percentage of total population\",\r\n  \"values\": [{\"name\": \"% of population\", \"slug\": \"valuey1\"}]\r\n}"},
  {id: 5, name: "Government health spending percentage per person measured in US$", slug: "government-health-spending-per-person", graphic_type: "bar", legend: "\r\n", source: "<p>Public health expenditure consists of recurrent and capital spending from government (central and local) budgets, external borrowings and grants (including donations from international agencies and nongovernmental organizations), and social (or compulsory) health insurance funds. Source data:</p>\r\n<p><a target=\"_blank\" href=\"http://data.worldbank.org/indicator/SH.XPD.PUBL.GX.ZS\">http://data.worldbank.org/indicator/SH.XPD.PUBL.GX.ZS</a></p>", query: "SELECT * FROM health_expenditure_by_year where (iso = '{{COUNTRY_ISO}}' and valuey1 is not null) order by year asc", created_at: "2016-11-07 15:48:39", updated_at: "2016-11-11 14:50:32", x_axis: "{\r\n  \"name\": \"Years\"\r\n}", y_axis: "{\r\n  \"name\": \"Percentage of government expenditure\",\r\n  \"values\": [{\"name\": \"% of government expenditure\", \"slug\": \"valuey1\"}]\r\n}"},
  {id: 12, name: "Life expectancy Data by country", slug: "life-expectancy-data-by-country", graphic_type: "line", legend: "{\r\n  \"type\": \"lines\",\r\n  \"items\": [{\"value\": \"At age 60 years for both sexes\", \"color\": \"{{##COLOR###}}\"}, \r\n                {\"value\": \"At age 60 years for females\", \"color\": \"###COLOR###\"}, \r\n                {\"value\": \"At age 60 years for males\", \"color\": \"###COLOR###\"}, \r\n                {\"value\": \"At birth years for both sexes\", \"color\": \"###COLOR###\"}, \r\n                {\"value\": \"At birth years for females\", \"color\": \"###COLOR###\"}, \r\n                {\"value\": \"At birth years for males\", \"color\": \"###COLOR###\"}]\r\n}", source: "<p>Life expectancy at birth reflects the overall mortality level of a population. It summarizes the mortality pattern that prevails across all age groups - children and adolescents, adults and the elderly. </p>\r\n<p>Life expectancy at age 60 reflects the overall mortality level of a population over 60 years. It summarizes the mortality pattern that prevails across all age groups above 60 years.</p> \r\n<p>Source data:</p> \r\n<p><a target=\"_blank\" href=\"http://apps.who.int/gho/data/view.main.SDG2016LEXv\">http://apps.who.int/gho/data/view.main.SDG2016LEXv</a></p>", query: "SELECT year, life_expectancy_at_age_60_years_both_sexes as valuey1, life_expectancy_at_age_60_years_female as valuey2, life_expectancy_at_age_60_years_male as valuey3, life_expectancy_at_birth_years_both_sexes as valuey4, life_expectancy_at_birth_years_female as valuey5, life_expectancy_at_birth_years_male as valuey6 FROM life_expectancy_all_years where iso = '{{COUNTRY_ISO}}' ORDER BY year ASC", created_at: "2016-11-08 18:18:14", updated_at: "2016-11-11 14:16:11", x_axis: "{\r\n  \"name\": \"Years\"\r\n}", y_axis: "{\r\n  \"name\": \"Life expectancy\",\r\n  \"values\": [{\"name\": \"At age 60 years both sexes\", \"slug\": \"valuey1\" }, \r\n                  {\"name\": \"At age 60 years female\", \"slug\": \"valuey2\"}, \r\n                  {\"name\": \"At age 60 years male\", \"slug\": \"valuey3\"}, \r\n                  {\"name\": \"At birth years both sexes\", \"slug\": \"valuey4\"}, \r\n                  {\"name\": \"At birth years female\", \"slug\": \"valuey5\"},\r\n                  {\"name\": \"At birth years male\", \"slug\": \"valuey6\"}]\r\n}\r\n"},
  {id: 13, name: "Radiotherapy Centers", slug: "radiotherapy_centers", graphic_type: "map", legend: "", source: "<h2>Radiotherapy Centers</h2> <p>Original data from IAEA. Last Updated. 10/20/2016</p>\t\r\n", query: "SELECT latitude, longitude, city, province_state FROM radiotherapy_centers_all_countries where iso = '{{COUNTRY_ISO}}' order by city asc", created_at: "2016-11-16 17:55:11", updated_at: "2016-11-17 14:51:47", x_axis: "{}", y_axis: "{}"}
])
