# Managing a Personal Stock Portfolio using Excel

Portfolio management is the art and science of selecting and overseeing a group of investments that 
meet the long-term financial objectives and risk tolerance of a client, a company, or an institution. 
Active portfolio management requires strategically buying and selling stocks and other assets in an effort 
to beat the performance of the broader market.

In order to better manage one's stock portfolio, he/she needs to keep a close eye on the market value of their stocks, 
the current price, how the price of the stocks are changing, the monthly trend of the stock price, the industry that is 
providing the better value, current gain/loss etc. 

## The Project:

Hence, in this project I have built a dashboard in MS Excel that eases the task of one's personal stock portfolio management. 
I have used Excel's in-built `Stock` data type to connect a list of stock ledgers to live stock data from the web. This allowed 
for getting up-to-date information about a stock's current price, price changes, highs and lows etc. On top of that, I have also used 
the `STOCKHISTORY` function to get historical price data about the stocks in the ledger. 

The dashboard shows the current stock holdings of an individual, units held, current prices and the market values of the holdings, 
today's change in price, gain/loss and the price change over the last 12 months. It also illustrates the holding market value by industry 
of the stock. Moreover, the dashboard also gives a glimpse into the volume, open, high, low and close of a watchlist of stocks to help an investor 
make an informed decision about his/her investment into those stocks.

**Dashboard Sneek Peek:**
<img src="Dashboard Preview.png">

## The Data:

The dataset for this project contains a ledger of stocks, generated using the `Stock` data type of Excel and its associated functions, and has been tabulated 
as follows:

| Column  | Description |
|---------|-------------|
| Date  | Date of the transaction |
| Stock | Name, exchange and ticker of the stock  |
| Ticker  | Ticker of the stock |
| Transaction | Type of the transaction |
| Units | Units of the stock transacted |
| Price | Unit price of the stock |
| Currency  | Currency of the transaction |
| Transaction Amount  | Total amount of the transaction |
