Add-Type -AssemblyName System.Windows.Forms

# Erstelle das Hauptfenster
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Dialog Beispiel"
$Form.Size = New-Object System.Drawing.Size(400,300)

# Erstelle das erste Eingabefeld
$TextBox1 = New-Object System.Windows.Forms.TextBox
$TextBox1.Location = New-Object System.Drawing.Point(50,50)
$TextBox1.Size = New-Object System.Drawing.Size(200,20)
$Form.Controls.Add($TextBox1)

# Erstelle das zweite Eingabefeld
$TextBox2 = New-Object System.Windows.Forms.TextBox
$TextBox2.Location = New-Object System.Drawing.Point(50,80)
$TextBox2.Size = New-Object System.Drawing.Size(200,20)
$Form.Controls.Add($TextBox2)

# Erstelle den Button
$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Point(50,110)
$Button.Size = New-Object System.Drawing.Size(75,23)
$Button.Text = "Hinzufügen"
$Button.Add_Click({
    # Füge den Text der Eingabefelder zur Listbox hinzu
    $ListBox.Items.Add("$($TextBox1.Text), $($TextBox2.Text)")
})
$Form.Controls.Add($Button)

# Erstelle die Listbox
$ListBox = New-Object System.Windows.Forms.ListBox
$ListBox.Location = New-Object System.Drawing.Point(50,140)
$ListBox.Size = New-Object System.Drawing.Size(200,100)
$Form.Controls.Add($ListBox)

# Zeige das Fenster an
$Form.ShowDialog()