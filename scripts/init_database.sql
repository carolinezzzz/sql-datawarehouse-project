USE master;
CREATE DATABASE DataWarehouse;

USE DataWarehouse;

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO


CREATE TABLE bronze.crm_cust_info(
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE

);


CREATE TABLE bronze.crm_prd_info(
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME

);


CREATE TABLE bronze.crm_sales_details(
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_at INT,
    sls_ship_at INT,
    sls_due_at INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);


CREATE TABLE bronze.erp_loc_a101(
    cid NVARCHAR(50),
    cntry NVARCHAR(50)
);

CREATE TABLE bronze.erp_cust_az12(
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(50)
);

CREATE TABLE bronze.erp_px_cat_g1v2(
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);
GO

BULK INSERT bronze.crm_cust_info
FROM '/var/opt/mssql/datasets/source_crm/cust_info.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT bronze.crm_prd_info
FROM '/var/opt/mssql/datasets/source_crm/prd_info.csv'
WITH (
    FIELDTERMINATOR = ',',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT bronze.crm_sales_details
FROM '/var/opt/mssql/datasets/source_crm/sales_details.csv'
WITH (
    FIELDTERMINATOR = ',',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT bronze.erp_loc_a101
FROM '/var/opt/mssql/datasets/source_erp/loc_a101.csv'
WITH (
    FIELDTERMINATOR = ',',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT bronze.erp_cust_az12
FROM '/var/opt/mssql/datasets/source_erp/cust_az12.csv'
WITH (
    FIELDTERMINATOR = ',',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT bronze.erp_px_cat_g1v2
FROM '/var/opt/mssql/datasets/source_erp/px_cat_g1v2.csv'
WITH (
    FIELDTERMINATOR = ',',
    FIRSTROW = 2,
    TABLOCK
);

