Attribute VB_Name = "Module1"
Sub Allsheets()
    Dim xSh As Worksheet
    Application.ScreenUpdating = False
    For Each xSh In Worksheets
        xSh.Select
        Call Stock_Analysis
    Next
    Application.ScreenUpdating = True
End Sub
Sub Stock_Analysis()
    
        'set variables for Ticker, etc
        Dim ws As Worksheet
        Set ws = ActiveSheet
        Dim ColorFormat
        Dim Ticker As String
        Dim Yearly_Change As Double
        Dim Open_Price As Double
        Dim Close_Price As Double
        Dim Percent_Change As Double
        Dim Total_Volume As Double
        Dim LastRow As Double
        Dim Summary_Table_Row As Integer
        Dim i As Integer
        Dim j As Integer
        Dim GreatInc As Integer
        Dim GreatDec As Integer
        Dim GreatVol As Double
        Dim max As Long
        Dim tag As Long
        Dim min As Long
        Dim GreatestIncreaseTicker As String
        Dim GreatestIncreaseValue As Double
        Dim GreatestDecreaseTicker As String
        Dim GreatestDecreaseValue As Double
        Dim GreatestTotalVolumeTicker As String
        Dim GreatestTotalVolumeValue As Double
                  
'Loop through all sheets
    For Each xSh In Worksheets
    
        'write headers in summary table
        ws.Cells(1, 9).Value = "Ticker"
        ws.Cells(1, 10).Value = "Yearly Change"
        ws.Cells(1, 11).Value = "Percent Change"
        ws.Cells(1, 12).Value = "Total Stock Volume"
        ws.Cells(1, 16).Value = "Ticker"
        ws.Cells(1, 17).Value = "Value"
        ws.Cells(2, 15).Value = "Greatest%Increase"
        ws.Cells(3, 15).Value = "Greatest%Decrease"
        ws.Cells(4, 15).Value = "Greatest TotalVolume"

        Summary_Table_Row = 2
               
        'determines last row
        LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row

    ' Initialize these variables with appropriate values
        GreatestIncreaseValue = 0
        GreatestDecreaseValue = 0
        GreatestTotalVolumeValue = 0 ' Set to a small value
        
        For i = 2 To LastRow
        
            'compare if next is same Stock
            If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
        
            'set for first row Stock type (ticker)
            Ticker = Cells(i, 1).Value
            
            'add to Open_Price
            Open_Price = Open_Price + Cells(i, 3).Value
            
            'add to Close_Price
            Close_Price = Close_Price + Cells(i, 6).Value
            
            Yearly_Change = Close_Price - Open_Price
            
            Percent_Change = (Yearly_Change / Open_Price) * 100
        
            'Add to the Total_Volume
            Total_Volume = Total_Volume + Cells(i, 7).Value
            
            'Print Ticker in the summary table
            Range("I" & Summary_Table_Row).Value = Ticker
            
            'Print Yearly Change in the summary table
            Range("J" & Summary_Table_Row).Value = Yearly_Change
            
            'Print percent change in the summary table
            Range("K" & Summary_Table_Row).Value = Percent_Change
        
            'Print Total_Volume to Summary Table
            Range("L" & Summary_Table_Row).Value = Total_Volume
        
            'Add one to the summary table row
            Summary_Table_Row = Summary_Table_Row + 1
        
            'reset the volume, open and close prices
            Total_Volume = 0
            Close_Price = 0
            Open_Price = 0
            Yearly_Change = 0
            
        
            'If cell below is equal to current
            Else
                'add to total volume
                Total_Volume = Total_Volume + Cells(i, 7).Value
            
                'add to Open_Price
                Open_Price = Open_Price + Cells(i, 3).Value
            
                'add to Close_Price
                Close_Price = Close_Price + Cells(i, 6).Value
            
                Yearly_Change = Close_Price - Open_Price
                  
            End If

        ' Update code to track greatest decrease and volume
            If Percent_Change > GreatestIncreaseValue Then
                GreatestIncreaseValue = Percent_Change
                GreatestIncreaseTicker = Ticker
            End If

        ' Update code to track greatest decrease and volume
            If Percent_Change < GreatestDecreaseValue Then
                GreatestDecreaseValue = Percent_Change
                GreatestDecreaseTicker = Ticker
            End If

            If Total_Volume > GreatestTotalVolumeValue Then
                GreatestTotalVolumeValue = Total_Volume
                GreatestTotalVolumeTicker = Ticker
            End If
                                
        Next i
         '--------------------------------------
        'format column K for %
       
        For i = 2 To LastRow
            
            If (Cells(i, 11).Value > 0) Then
                Cells(i, 11).NumberFormat = "0.00%"
                
                Else
                 Cells(i, 11).NumberFormat = "0.00%"
                
            End If
                                        
                               
        Next i
        '-----------------------------------------------
         'format col J for color based on results
        
        For i = 2 To LastRow
            
            'For j = 10 To 10
            
                If (Cells(i, 10).Value > 0) Then
                Cells(i, 10).Interior.ColorIndex = 4
                
                Else
                Cells(i, 10).Interior.ColorIndex = 3
                
                End If
                                        
             'Next j
                                 
        Next i
        '-----------------------------------------------
        ' Print Greatest Increase Ticker and Value in P2 and Q2
        ws.Cells(2, 16).Value = GreatestIncreaseTicker
        ws.Cells(2, 17).Value = GreatestIncreaseValue
        If GreatestIncreaseTicker <> "" Then
            ws.Cells(2, 17).NumberFormat = "0.00%"
        End If

    ' Print the Greatest %Decrease Ticker and Value in P3 and Q3
        ws.Cells(3, 16).Value = GreatestDecreaseTicker
        ws.Cells(3, 17).Value = GreatestDecreaseValue
    ' Assuming GreatestDecreaseValue is the percentage value
        'ws.Cells(3, 17).Value = GreatestDecreaseValue * 100
        If GreatestDecreaseTicker <> "" Then
            ws.Cells(3, 17).NumberFormat = "0.00%"
        End If

        ' Print the Greatest TotalVolume Ticker and Value in P4 and Q4
        ws.Cells(4, 16).Value = GreatestTotalVolumeTicker
        ws.Cells(4, 17).Value = GreatestTotalVolumeValue
            
               
    Next xSh
        
End Sub





