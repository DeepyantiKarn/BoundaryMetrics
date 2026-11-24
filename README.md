# BoundaryMetrics – IPL Cricket Analytics

BoundaryMetrics is an IPL cricket analytics project built using Python, MySQL, and Power BI. It analyzes ball-by-ball data from 1,243 IPL matches.

## Tech Stack
- Python, Pandas, NumPy, Matplotlib
- MySQL
- Power BI
- Jupyter Notebook

## Project Structure
- `data/` – Cleaned datasets and analysis CSV files
- `ipl_male_json/` – Raw IPL match JSON files
- `python/` – Five notebooks covering data cleaning, match/team, batting, bowling, and match-phase analysis
- `sql/` – Database creation, table setup, data import, validation, and analysis queries
- `powerbi/` – Power BI dashboard

## Setup

1. Clone the repository:
   `git clone https://github.com/DeepyantiKarn/BoundaryMetrics.git`

2. Install dependencies:
   `pip install -r requirements.txt`

3. Run Jupyter from the `python` directory:
   `jupyter notebook`

4. Execute the five notebooks in numerical order.

5. For MySQL, execute the SQL scripts in numerical order, ensuring `LOCAL INFILE` is enabled for data import.

6. Open `powerbi/BoundaryMetrics_Dashboard.pbix` in Power BI Desktop.

## Dataset Attribution

IPL match data is sourced from [Cricsheet](https://cricsheet.org/).

The dataset is distributed under the Open Data Commons Attribution License (ODC-By). Refer to `ipl_male_json/LICENSE.txt` for the full license and attribution requirements.
