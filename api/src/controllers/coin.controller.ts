import { Request, Response, RequestHandler } from "express";
import { WebSocket, WebSocketServer } from "ws";

export const getCoinMarket = async (req: Request, res: Response) => {
  // let ws = new WebSocket('wss://stream.binance.com:9443/ws/!ticker@arr');
  
  let ws = new WebSocket('wss://stream.bybit.com/v5/public/spot');

  // ws.onmessage = (msg) => {
  //   console.log(msg.data);
  // }

  ws.on('open', () => {
    const payload = {
      op: "subscribe",
      args: ["tickers.BTCUSDT"]
    }
    ws.send(JSON.stringify(payload));
  });
  

  ws.onmessage = (msg) => {
    console.log(msg.data);    
  }


  res.send('Hello from coin controller');
}