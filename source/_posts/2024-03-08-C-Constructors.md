---
title: C# 建構函式與方法多載
date: 2024-03-08 23:37:36
tags:
  - [學習]
categories:
  - [C#]
---

關於 C# 建構函式、宣告 Class 中 多載(Overload) 參數。


<!--more-->
---


# 建構函式（Constructor）的深入解析與實戰

## 建構函式的基本概念
- **定義**：建構函式是一種特殊的方法，當類別的實例被創建時自動呼叫。
- **作用**：初始化類別的某些字段，將物件置於初始狀態。

## 建構函式的聲明方式
- **命名規則**：建構函式的名稱必須與類別名稱完全相同。
- **返回類型**：建構函式不應有返回類型，連`void`也不應有。

## 建構函式的類型
- **無參建構函式（預設建構函式）**：不帶任何參數，若未明確定義，C#編譯器會自動生成。
- **帶參建構函式**：可接受一個或多個參數，用於更靈活地初始化對象。

## 建構函式的多載（Overloading）
- **意義**：同一類別中可以有多個名稱相同但參數列表不同的建構函式。
- **目的**：提供不同的初始化選項。

## 程式實戰演練
### 定義一個Customer類別
```csharp
public class Customer {
    public int ID;
    public string Name;

    // 預設建構函式
    public Customer() {
        ID = 0;
        Name = null;
    }

    // 帶參建構函式
    public Customer(int id, string name) {
        ID = id;
        Name = name;
    }
}
```

### 實例化與使用
```csharp
Customer customerA = new Customer();
Customer customerB = new Customer(1, "John");
```

## 進階主題：建構函式的鏈接
- 使用`this`關鍵字實現建構函式間的調用。

### 例子
```csharp
public class Customer {
    public int ID;
    public string Name;
    public List<Order> Orders;

    public Customer() : this(0, null) {
        Orders = new List<Order>();
    }

    public Customer(int id, string name) {
        ID = id;
        Name = name;
        // 這樣確保了無論使用哪個建構函式，Orders都會被初始化
        Orders = new List<Order>();
    }
}
```

---

# C# 方法詳解

## 方法的簽名
- **定義**：方法名稱加上其參數的數量和類型。
- **例子**：`Move(int x, int y)` 在 `Point` 類中。

## 方法多載 (Overloading)
- **概念**：相同名稱但不同簽名的方法。
- **例子**：
  - `Move(int x, int y)`：移動點到指定坐標。
  - `Move(Point p)`：移動到另一個點的位置。

## 修飾符 `params`
- **用途**：允許傳入不定數量的參數。
- **例子**：`Add(params int[] numbers)` 可以傳入任意數量的整數。

## 修飾符 `ref`
- **用途**：參數按引用傳遞，方法內的更改會影響到原始變數。
- **例子**：
  - 原始狀態：`a = 1`。
  - 調用 `MyMethod(ref a)` 後，`a` 的值改變。

## 修飾符 `out`
- **用途**：方法可以返回多個值。
- **例子**：`int.TryParse(string s, out int result)` 試圖將字符串轉換為整數，轉換成功則 `result` 返回轉換後的數值。

## 程式碼舉例

```csharp
public class Point
{
    public int X { get; set; }
    public int Y { get; set; }

    // 方法多載例子
    public void Move(int x, int y)
    {
        X = x;
        Y = y;
    }

    public void Move(Point p)
    {
        X = p.X;
        Y = p.Y;
    }
}

public class Calculator
{
    // 使用 params 修飾符
    public int Add(params int[] numbers)
    {
        int sum = 0;
        foreach (int number in numbers)
        {
            sum += number;
        }
        return sum;
    }
}

// 使用 ref 和 out 例子
class UsageExample
{
    public void ModifyValue(ref int value)
    {
        value += 2;
    }

    public bool TryParseNumber(string input, out int result)
    {
        return int.TryParse(input, out result);
    }
}
```

## 小結
- **方法多載** 提供了靈活性，讓我們可以根據不同的需求調用相同名稱但功能不同的方法。
- **`params`** 修飾符讓我們可以傳入不定長度的參數，增加了方法的靈活性。
- **`ref` 和 `out`** 雖然功能強大，但使用時需謹慎以避免不必要的複雜性或錯誤。

---

## `ref` 和 `out` 參數

`ref` 和 `out` 是 C# 中的兩個關鍵字，它們用於方法參數，允許方法內部修改外部傳入的變數值。

### `ref` 關鍵字
`ref` 關鍵字用於按引用傳遞參數。這意味著當你將一個變數以 `ref` 形式傳遞給一個方法時，你傳遞的是變數的引用，而不是其複本。因此，方法內對該參數的任何修改都會反映到原始變數上。

#### `ref` 例子
```csharp
public class ExampleClass
{
    public void ModifyValue(ref int value)
    {
        value += 10; // 增加 value 的值
    }
}

var example = new ExampleClass();
int originalValue = 5;
example.ModifyValue(ref originalValue);
Console.WriteLine(originalValue); // 輸出將會是 15
```

在這個例子中，`originalValue` 的值在傳遞給 `ModifyValue` 方法後被修改，因為它是以 `ref` 形式傳遞的。

### `out` 關鍵字
`out` 關鍵字用於方法參數，當你希望方法返回多個值時。使用 `out` 可以使方法具有多個輸出參數。與 `ref` 類似，`out` 也是按引用傳遞參數，但使用 `out` 時，方法內必須對參數賦值。

#### `out` 例子
```csharp
public class ExampleClass
{
    public bool TryDivide(int dividend, int divisor, out int result)
    {
        if (divisor == 0)
        {
            result = 0;
            return false;
        }
        else
        {
            result = dividend / divisor;
            return true;
        }
    }
}

var example = new ExampleClass();
int divisionResult;
if (example.TryDivide(10, 2, out divisionResult))
{
    Console.WriteLine(divisionResult); // 輸出將會是 5
}
```

在這個例子中，`TryDivide` 方法嘗試執行除法運算，並通過 `out` 參數返回結果。`divisionResult` 在方法內部被賦值，並在方法外部可以訪問。