

#property copyright "Nikos"
#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 Yellow
#property indicator_color2 Yellow

extern bool Show_Alert = false;

//Bullish Patterns
extern bool Display_1stThreeBarGroup = true;
extern bool Display_2ndThreeBarGroup = true;

//Bearish Patterns
bool Display_Short = false;


//---- buffers
double upArrow[];
double downArrow[];
string PatternText[5000];


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int init()
  {
   ObjectsDeleteAll(0, OBJ_TEXT);

   SetIndexStyle(0,DRAW_ARROW, EMPTY,2);
   SetIndexArrow(0,233);
   SetIndexBuffer(0, upArrow);

   SetIndexStyle(1,DRAW_ARROW, EMPTY,2);
   SetIndexArrow(1,234);
   SetIndexBuffer(1, downArrow);

   return(0);
  }


//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   double Range,Range1, AvgRange, MiddlePoint ;
   int counter, setalert;
   static datetime prevtime = 0;
   int shift;
   int shift1;
   int shift2;
   int shift3;
   int shift4;
   int shift5;
   int shift6;
   int shift7;
   int shift8;
   int shift9;
   int shift10;

   string pattern, period;
   int setPattern = 0;
   int alert = 0;
   int arrowShift;
   int textShift;
   double Body;
   double Lowest_Low9,Lowest_Low20, Lowest_Low200;
   double Lowest_Close9, Lowest_Close20, Lowest_Close200;
   double Highest_High9;
   double lowBand, highBand;
   double Lowest_High9;
   double Highest_Low9;

   if(prevtime == Time[0])
     {
      return(0);
     }
   prevtime = Time[0];

   switch(Period())
     {
      case 1:
         period = "M1";
         break;
      case 5:
         period = "M5";
         break;
      case 15:
         period = "M15";
         break;
      case 30:
         period = "M30";
         break;
      case 60:
         period = "H1";
         break;
      case 240:
         period = "H4";
         break;
      case 1440:
         period = "D1";
         break;
      case 10080:
         period = "W1";
         break;
      case 43200:
         period = "MN";
         break;
     }

   for(int j = 0; j < Bars; j++)
     {
      PatternText[j] = "pattern-" + j;
     }

   for(shift = 0; shift < Bars; shift++)
     {

      setalert = 0;
      counter=shift;
      Range=0;
      AvgRange=0;

      for(counter=shift ; counter<=shift+19; counter++)
        {
         AvgRange=AvgRange+MathAbs(High[counter]-Low[counter]);
        }
      Range=AvgRange/20;

      shift1 = shift + 1;
      shift2 = shift + 2;
      shift3 = shift + 3;
      shift4 = shift + 4;
      shift5 = shift + 5;
      shift6 = shift + 6;
      shift7 = shift + 7;

      double O = Open[shift1];
      double O1 = Open[shift2];
      double O2 = Open[shift3];
      double O3 = Open[shift4];
      double O4 = Open[shift5];
      double O5 = Open[shift6];
      double O6 = Open[shift7];
      double O7 = Open[shift8];

      double H = High[shift1];
      double H1 = High[shift2];
      double H2 = High[shift3];
      double H3 = High[shift4];
      double H4 = High[shift5];
      double H5 = High[shift6];
      double H6 = High[shift7];
      double H7 = High[shift8];

      double L = Low[shift1];
      double L1 = Low[shift2];
      double L2 = Low[shift3];
      double L3 = Low[shift4];
      double L4 = Low[shift5];
      double L5 = Low[shift6];
      double L6 = Low[shift7];
      double L7 = Low[shift8];

      double C = Close[shift1];
      double C1 = Close[shift2];
      double C2 = Close[shift3];
      double C3 = Close[shift4];
      double C4 = Close[shift5];
      double C5 = Close[shift6];
      double C6 = Close[shift7];
      double C7 = Close[shift8];

      Body = MathAbs(C-O);

      int font_size = 12;

      Range = MathAbs(H-L);
      Range1 = MathAbs(H1-L1);

      MiddlePoint = (H+L)/2;

      lowBand = iBands(NULL,PERIOD_CURRENT,20,2,0,PRICE_CLOSE,2,shift1);
      double lowBand1 = iBands(NULL,PERIOD_CURRENT,20,2,0,PRICE_CLOSE,2,shift2);
      double lowBand2 = iBands(NULL,PERIOD_CURRENT,20,2,0,PRICE_CLOSE,2,shift3);


      highBand = iBands(NULL,PERIOD_CURRENT,20,2,0,PRICE_CLOSE,1,shift1);
      double highBand1 = iBands(NULL,PERIOD_CURRENT,20,2,0,PRICE_CLOSE,1,shift2);
      double highBand2 = iBands(NULL,PERIOD_CURRENT,20,2,0,PRICE_CLOSE,1,shift3);

      Lowest_Low9 = Low[iLowest(NULL, PERIOD_CURRENT, MODE_LOW, 9, shift1)];
      Lowest_High9 = High[iLowest(NULL, PERIOD_CURRENT, MODE_HIGH, 9, shift1)];

      Highest_High9 = High[iHighest(NULL, PERIOD_CURRENT, MODE_HIGH, 9, shift1)];
      Highest_Low9 = High[iHighest(NULL, PERIOD_CURRENT, MODE_LOW, 9, shift1)];

      double ema50 = iMA(NULL,PERIOD_CURRENT,50,0,MODE_EMA,PRICE_CLOSE,shift1);
      double ema50_1 = iMA(NULL,PERIOD_CURRENT,50,0,MODE_EMA,PRICE_CLOSE,shift2);

      double ema20 = iMA(NULL,PERIOD_CURRENT,20,0,MODE_EMA,PRICE_CLOSE,shift1);
      double ema20_1 = iMA(NULL,PERIOD_CURRENT,20,0,MODE_EMA,PRICE_CLOSE,shift2);
      double ema20_2 = iMA(NULL,PERIOD_CURRENT,20,0,MODE_EMA,PRICE_CLOSE,shift3);
      double ema20_3 = iMA(NULL,PERIOD_CURRENT,20,0,MODE_EMA,PRICE_CLOSE,shift4);
      double ema20_4 = iMA(NULL,PERIOD_CURRENT,20,0,MODE_EMA,PRICE_CLOSE,shift5);
      double ema20_5 = iMA(NULL,PERIOD_CURRENT,20,0,MODE_EMA,PRICE_CLOSE,shift6);
      double ema20_6 = iMA(NULL,PERIOD_CURRENT,20,0,MODE_EMA,PRICE_CLOSE,shift7);
      double ema20_7 = iMA(NULL,PERIOD_CURRENT,20,0,MODE_EMA,PRICE_CLOSE,shift8);

      if(
         H > H1
         && L > L1
         && C > O
         && C1 > O1
         && L1 <= lowBand1
         && H1 < highBand1
      )
        {
         if(Display_1stThreeBarGroup == true)
           {
            WindowRedraw();
            upArrow[shift1] = Low[shift1] - Range*0.5;
            ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], upArrow[shift1] - Range*1);
            ObjectSetText(PatternText[shift], "Buy 1", font_size, "Times New Roman", Yellow);

           }
        }

      if(
         H <= H1
         && H <= H2
         && H1 <= H2
         && L <= L1
         && L <= L2
         && L1 <= L2
         && C1 <= C2
         && C >= O
         && C1 <= O1
         && C2 <= O2
         && L <= lowBand
      )
        {
         if(Display_2ndThreeBarGroup == true)
           {
            WindowRedraw();
            upArrow[shift1] = Low[shift1] - Range*0.5;
            ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], upArrow[shift1] - Range*1);
            ObjectSetText(PatternText[shift], "Buy 2", font_size, "Times New Roman", Yellow);

           }
        }



     } // End of for loop





   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
   ObjectsDeleteAll(0, OBJ_TEXT);
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
