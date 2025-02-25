# ZBC400_D17_REP_A

## Description
This ABAP report (`ZBC400_D17_REP_A`) retrieves and displays flight information based on user input parameters. It utilizes a predefined class method to fetch data and presents it with color-coded icons depending on seat occupancy percentages.

## Features
- Retrieves flight data using `cl_bc400_flightmodel=>get_flights_range`.
- Uses `SELECT-OPTIONS` and `PARAMETERS` to filter flights by airline (`carrid`) and connection ID (`connid`).
- Implements error handling for missing data and authorization issues.
- Displays flight details with visual indicators (`icon_red_light`, `icon_yellow_light`, `icon_green_light`) based on seat occupancy.

## Data Handling
### Data Types
- Uses `TYPE-POOLS: icon, col` for icon and color constants.
- Declares `gs_flight` (structure) and `gt_flight` (internal table) based on `bc400_s_flight`.
- Defines constants for seat occupancy thresholds:
  - `gc_red` (97%)
  - `gc_yellow` (60%)

### Data Retrieval
- Calls `cl_bc400_flightmodel=>get_flights_range` inside a `TRY...CATCH` block.
- Catches exceptions:
  - `cx_bc400_no_data`: Displays 'no data'.
  - `cx_bc400_no_auth`: Displays 'no authorization'.

### Data Output
- Loops through `gt_flight` to display:
  - Airline ID (`carrid`)
  - Connection ID (`connid`)
  - Flight date (`fldate`)
  - Maximum and occupied seats (`seatsmax`, `seatsocc`)
  - Seat occupancy percentage (`percentage`)
- Uses color and icons to visually represent seat occupancy levels.

## Usage
1. Execute the report in SAP GUI.
2. Provide airline ID (`pa_car`) and connection ID range (`so_con`).
3. View the flight details along with seat occupancy indicators.

## Dependencies
- `bc400_s_flight` structure definition.
- `cl_bc400_flightmodel` class with `get_flights_range` method.
- `icon_red_light`, `icon_yellow_light`, `icon_green_light` icons.

## Author
Developed as part of the BC400 training module.
