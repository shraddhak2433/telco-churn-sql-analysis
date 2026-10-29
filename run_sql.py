"""SQL analysis of the Telco churn data.
Loads telco_churn.csv into a SQLite database, then runs every query in queries.sql.
Run: python run_sql.py
"""
import sqlite3
import pandas as pd

# 1. Load the CSV into a SQLite database
df = pd.read_csv("telco_churn.csv")
df["TotalCharges"] = pd.to_numeric(df["TotalCharges"], errors="coerce")
con = sqlite3.connect("telco.db")
df.to_sql("customers", con, if_exists="replace", index=False)
print(f"Loaded {len(df)} rows into table 'customers'\n")

# 2. Split queries.sql into separate queries (each starts with a '-- Q' comment line)
queries, title, lines = [], None, []
for line in open("queries.sql"):
    if line.startswith("-- Q"):
        if title:
            queries.append((title, "".join(lines)))
        title, lines = line[3:].strip(), []
    else:
        lines.append(line)
queries.append((title, "".join(lines)))

# 3. Run each query and print the result
output = []
for title, sql in queries:
    result = pd.read_sql_query(sql, con).to_string(index=False)
    block = f"{title}\n{result}\n"
    print(block)
    output.append(block)

open("results.txt", "w").write("\n".join(output))
con.close()
