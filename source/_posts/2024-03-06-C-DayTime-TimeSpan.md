---
title: C# DayTime TimeSpan
date: 2024-02-29 17:57:13
tags:
  - [心得]
  - [學習]
categories:
  - [C#]
---

關於 C# DayTime、TimeSpan，相關用法。

---


# DayTime

1. 創建 DateTime 物件

* 使用 new DateTime() 構造函數，可以根據年、月、日或更具體到小時、分鐘、秒來創建一個 DateTime 物件。
獲取當前日期和時間

使用 DateTime.Now 來獲取當前的日期和時間。
使用 DateTime.Today 來獲取當前日期（不包括時間部分）。
訪問 DateTime 組件

可以直接訪問 DateTime 物件的年（Year）、月（Month）、日（Day）、小時（Hour）、分鐘（Minute）等組件。
不可變性（Immutability）

DateTime 物件是不可變的，意味著一旦創建，其值就不能改變。
修改 DateTime

雖然 DateTime 物件是不可變的，但可以使用如 AddDays、AddHours 等方法來基於現有的 DateTime 物件計算出新的時間點。

此時會產生新的 DateTime 物件並非修改原本的 DateTime 物件內容

格式化 DateTime

使用 ToLongDateString、ToShortDateString、ToLongTimeString、ToShortTimeString 等方法將 DateTime 物件格式化為不同形式的字串。
使用 ToString 方法與格式指定符，可以自定義日期時間的輸出格式。
格式指定符

通過 ToString 方法並傳入格式指定符，可以控制日期時間的字串表示形式，例如 "yyyy-MM-dd" 表示四位年份、兩位月份和兩位日期。
查找格式指定符

如果需要查找或學習更多的格式指定符，可以參考官方文檔或通過搜索引擎查詢”C# DateTime format specifier”。
TimeSpan
創建 TimeSpan 物件
使用 new 操作符：可以透過 new TimeSpan() 並傳入小時、分鐘、秒等參數來創建一個 TimeSpan 實例。

例如：new TimeSpan(1, 2, 3) 創建一個表示 1 小時 2 分鐘 3 秒的 TimeSpan 物件。
如果沒有分鐘和秒的值，可以傳入 0：new TimeSpan(1, 0, 0)。
使用靜態方法：TimeSpan 提供了一系列以 From 開頭的靜態方法來創建物件，如 FromDays、FromHours、FromMinutes 等。

例如：TimeSpan.FromHours(1) 創建一個表示 1 小時的 TimeSpan 物件。
減去兩個 DateTime 物件：將兩個 DateTime 物件相減，結果是一個 TimeSpan 物件。

例如：endDateTime - startDateTime。
讀取 TimeSpan 屬性
TimeSpan 具有多個屬性，如 Days、Hours、Minutes、Seconds 等，用於獲取對應的時間組件。
也有以 Total 開頭的屬性，如 TotalDays、TotalHours 等，用於獲取時間長度的總量，以不同的時間單位表示。
修改 TimeSpan
TimeSpan 是不可變的，但提供了 Add 和 Subtract 方法來返回修改後的新 TimeSpan 物件。
例如：timeSpan.Add(TimeSpan.FromMinutes(8)) 將 8 分鐘加到現有的 TimeSpan 物件上。
字串轉換
使用 ToString 方法可以將 TimeSpan 物件轉換為其字串表示形式。
使用 TimeSpan.Parse 方法可以將字串轉換為 TimeSpan 物件。
練習
編寫一個程式，要求用戶以 24 小時制時間格式（例如 19:00）輸入時間值。有效的時間應該在 00:00 和 23:59 之間。如果時間有效，顯示” 正確”；否則，顯示” 無效時間”。如果用戶沒有提供任何值，則視為無效時間。

答案 1
以下是一個簡單的 C# 程式，用於檢查用戶輸入的時間是否有效。這個程式首先提示用戶輸入一個時間值，然後檢查這個值是否符合 24 小時制時間格式，並且是否在 00:00 到 23:59 之間。根據這些條件，程式將輸出相應的訊息。

using System;

class Program
{
    static void Main()
    {
        Console.WriteLine("請以24小時制時間格式（例如19:00）輸入時間值：");
        string input = Console.ReadLine();

        // 檢查用戶是否輸入了任何值
        if (string.IsNullOrWhiteSpace(input))
        {
            Console.WriteLine("無效時間");
            return;
        }

        // 檢查時間格式是否正確
        if (TimeSpan.TryParse(input, out TimeSpan time))
        {
            // 檢查時間是否在00:00到23:59之間
            if (time.TotalDays < 1)
            {
                Console.WriteLine("正確");
            }
            else
            {
                Console.WriteLine("無效時間");
            }
        }
        else
        {
            Console.WriteLine("無效時間");
        }
    }
}
這個程式使用了 TimeSpan.TryParse 方法來嘗試解析用戶輸入的時間。如果解析成功，TimeSpan 對象 time 將被賦值，然後程式會檢查這個時間值是否小於一天（即 24 小時）。如果是，則認為時間有效；否則，顯示” 無效時間”。如果 TimeSpan.TryParse 方法返回 false，表示無法解析輸入的時間，同樣顯示” 無效時間”。

答案 2
將輸入的時間（格式為 HH:mm）轉換為 TimeSpan 對象是可行的，但需要注意的是，TimeSpan 代表時間間隔，而不是一天中的特定時間點。不過，在許多情況下，我們可以將 24 小時制的時間視為從一天的開始（00:00）到指定時間的間隔。這樣，使用 TimeSpan 來表示和處理這種時間是合理的。

為了將格式為 HH:mm 的時間字符串轉換為 TimeSpan 對象，你可以直接使用 TimeSpan.Parse 或 TimeSpan.TryParse 方法。這些方法適用於處理格式良好的時間字符串。以下是一個示例代碼，展示如何實現這一轉換：

using System;

class Program
{
    static void Main()
    {
        Console.WriteLine("請以24小時制時間格式（例如19:00）輸入時間值：");
        string input = Console.ReadLine();

        // 檢查用戶是否輸入了任何值
        if (string.IsNullOrWhiteSpace(input))
        {
            Console.WriteLine("無效時間");
            return;
        }

        // 嘗試將輸入的字符串轉換為 TimeSpan
        if (TimeSpan.TryParse(input, out TimeSpan time))
        {
            // 檢查時間是否在00:00到23:59之間
            if (time >= TimeSpan.FromHours(0) && time < TimeSpan.FromHours(24))
            {
                Console.WriteLine("正確");
            }
            else
            {
                Console.WriteLine("無效時間");
            }
        }
        else
        {
            Console.WriteLine("無效時間");
        }
    }
}
在這個例子中，如果輸入的時間格式正確且在有效範圍內（00:00 到 23:59），程式將輸出” 正確”。如果輸入無效或不在這個範圍內，則輸出” 無效時間”。這種方法利用了 TimeSpan 來處理和驗證一天中的時間，即便 TimeSpan 本身是用於表示時間間隔的。

TimeSpan.TryParse()
TimeSpan.TryParse 方法是一個在 .NET 中用來將字符串轉換為 TimeSpan 對象的方法。TimeSpan 本身代表一段時間，可以是幾小時、幾分鐘或其他任何時間單位的組合。這個方法非常適合於處理來自用戶輸入或其他來源的時間格式字符串，特別是當你不確定這些字符串是否總是符合預期格式時。

TimeSpan.TryParse 方法的簽名如下：

public static bool TryParse (string s, out TimeSpan result);
s: 要解析的時間字符串。
result: 如果解析成功，此方法返回時將包含一個 TimeSpan 對象，它代表 s 中指定的時間間隔。如果轉換失敗，則返回 TimeSpan.Zero。
這個方法的返回值是一個布爾值（bool），指示轉換是否成功：

true: 表示字符串成功轉換為 TimeSpan 對象。
false: 表示轉換失敗，此時 result 將被設置為 TimeSpan.Zero。
使用 out 參數 result 是一種常見的模式，用於在方法內部將結果返回給調用者。out 關鍵字要求在方法內部對該參數賦值，這樣在方法返回時，調用者就可以獲得這個值。

這個方法的一個優點是它提供了一種安全的方式來嘗試解析字符串為 TimeSpan，而不會在格式不正確時拋出異常。這使得你可以在不使用昂貴的異常處理機制的情況下處理可能的錯誤。

以下是一個使用 TimeSpan.TryParse 方法的示例：

string input = "12:34:56";
if (TimeSpan.TryParse(input, out TimeSpan result))
{
    Console.WriteLine($"成功解析: {result}");
}
else
{
    Console.WriteLine("解析失敗");
}
在這個例子中，如果 input 字符串是一個有效的時間表示，TimeSpan.TryParse 將會解析它並將解析後的 TimeSpan 對象存儲在 result 變量中，同時返回 true。如果 input 不是一個有效的時間表示，result 將被設置為 TimeSpan.Zero，並且方法返回 false。

Out
out 關鍵字在 C# 中是用來指定一個方法參數作為輸出參數的。它並不限定於特定的類型，如 TimeSpan，而是可以用於任何類型的變數。當你使用 out 關鍵字時，你是在告訴方法，你期望它在方法內部對這個參數進行賦值，然後在方法返回時，可以從方法外部訪問這個參數的值。

在 TimeSpan.TryParse(string s, out TimeSpan result) 方法中，out TimeSpan result 是指 result 是一個輸出參數，並且它的類型是 TimeSpan。這意味著，當 TryParse 方法被調用時，它將嘗試將輸入的字符串 s 解析為一個 TimeSpan 對象，並將解析結果賦值給 result。如果解析成功，result 將包含解析後的 TimeSpan 值；如果解析失敗，result 將被設置為 TimeSpan.Zero。

你可以使用 out 關鍵字與任何類型的變數，不僅限於 TimeSpan。這在設計需要返回多個值的方法時特別有用。以下是一個使用 out 參數的例子，其中 out 參數用於返回方法內計算的多個結果：

public static bool TryDivide(double numerator, double denominator, out double result)
{
    if (denominator == 0)
    {
        result = 0;
        return false;
    }
    else
    {
        result = numerator / denominator;
        return true;
    }
}
在這個例子中，TryDivide 方法嘗試將兩個數字進行除法運算，並通過 out 參數 result 返回計算結果。如果除數為零，方法返回 false 並將 result 設置為 0；如果除法運算成功，方法返回 true 並將結果賦值給 result。

總之，out 關鍵字的使用不限於特定類型，它提供了一種靈活的方式來從方法中返回多個值。

TotalDays
在 .NET 中，TimeSpan 類別的 TotalDays 屬性表示由 TimeSpan 實例表示的總天數，以天為單位。這個值包括 TimeSpan 表示的天數的整數部分和小數部分。換句話說，TotalDays 會將 TimeSpan 對象中的所有時間單位（天、小時、分鐘、秒等）轉換成天數的總和，並以雙精度浮點數（double）形式返回。

這與 TimeSpan 的 Days 屬性不同。Days 屬性只返回 TimeSpan 中的天數部分，不包括小時、分鐘和秒轉換成的天數，且返回值為整數（int）。

舉例說明
假設有一個 TimeSpan 對象表示 3 天 12 小時（或等價於 3.5 天），那麼：

TotalDays 屬性會返回 3.5。
Days 屬性則只會返回 3。
使用場景
TotalDays 屬性在需要準確計算時間間隔總天數時非常有用，特別是當時間間隔包括小時和分鐘時，你想要得到一個更精確的天數表示。

範例代碼
下面的 C# 代碼示例展示了如何使用 TotalDays 屬性：

using System;

class Program
{
    static void Main()
    {
        // 創建一個 TimeSpan 對象，表示 2 天 12 小時
        TimeSpan timeSpan = new TimeSpan(2, 12, 0, 0);
        
        // 使用 TotalDays 屬性獲取總天數
        double totalDays = timeSpan.TotalDays;
        
        Console.WriteLine($"總天數: {totalDays}");  // 輸出: 總天數: 2.5
    }
}
在這個例子中，TimeSpan 對象表示 2 天 12 小時，因此 TotalDays 屬性返回的值是 2.5。這個值精確地反映了 TimeSpan 對象所表示的總時間長度，以天為單位。