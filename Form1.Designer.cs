namespace BecerraEstevan_MockLabExam
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblName = new System.Windows.Forms.Label();
            this.lblPrice = new System.Windows.Forms.Label();
            this.txtName = new System.Windows.Forms.TextBox();
            this.txtPrice = new System.Windows.Forms.TextBox();
            this.btnEnter = new System.Windows.Forms.Button();
            this.lstShow = new System.Windows.Forms.ListBox();
            this.btnDisplay = new System.Windows.Forms.Button();
            this.btnAverage = new System.Windows.Forms.Button();
            this.btnPrice = new System.Windows.Forms.Button();
            this.btnSortAlpha = new System.Windows.Forms.Button();
            this.btnClear = new System.Windows.Forms.Button();
            this.btnExit = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // lblName
            // 
            this.lblName.AutoSize = true;
            this.lblName.Location = new System.Drawing.Point(17, 15);
            this.lblName.Name = "lblName";
            this.lblName.Size = new System.Drawing.Size(68, 13);
            this.lblName.TabIndex = 0;
            this.lblName.Text = "Item\'s Name:";
            // 
            // lblPrice
            // 
            this.lblPrice.AutoSize = true;
            this.lblPrice.Location = new System.Drawing.Point(29, 41);
            this.lblPrice.Name = "lblPrice";
            this.lblPrice.Size = new System.Drawing.Size(56, 13);
            this.lblPrice.TabIndex = 1;
            this.lblPrice.Text = "Unit Price:";
            // 
            // txtName
            // 
            this.txtName.Location = new System.Drawing.Point(91, 12);
            this.txtName.Name = "txtName";
            this.txtName.Size = new System.Drawing.Size(100, 20);
            this.txtName.TabIndex = 1;
            // 
            // txtPrice
            // 
            this.txtPrice.Location = new System.Drawing.Point(91, 38);
            this.txtPrice.Name = "txtPrice";
            this.txtPrice.Size = new System.Drawing.Size(100, 20);
            this.txtPrice.TabIndex = 2;
            // 
            // btnEnter
            // 
            this.btnEnter.Location = new System.Drawing.Point(102, 64);
            this.btnEnter.Name = "btnEnter";
            this.btnEnter.Size = new System.Drawing.Size(75, 23);
            this.btnEnter.TabIndex = 3;
            this.btnEnter.Text = "&Enter";
            this.btnEnter.UseVisualStyleBackColor = true;
            this.btnEnter.Click += new System.EventHandler(this.BtnEnter_Click);
            // 
            // lstShow
            // 
            this.lstShow.FormattingEnabled = true;
            this.lstShow.Location = new System.Drawing.Point(21, 93);
            this.lstShow.Name = "lstShow";
            this.lstShow.Size = new System.Drawing.Size(237, 82);
            this.lstShow.TabIndex = 5;
            // 
            // btnDisplay
            // 
            this.btnDisplay.Location = new System.Drawing.Point(21, 181);
            this.btnDisplay.Name = "btnDisplay";
            this.btnDisplay.Size = new System.Drawing.Size(75, 23);
            this.btnDisplay.TabIndex = 4;
            this.btnDisplay.Text = "&Display";
            this.btnDisplay.UseVisualStyleBackColor = true;
            this.btnDisplay.Click += new System.EventHandler(this.BtnDisplay_Click);
            // 
            // btnAverage
            // 
            this.btnAverage.Location = new System.Drawing.Point(102, 181);
            this.btnAverage.Name = "btnAverage";
            this.btnAverage.Size = new System.Drawing.Size(75, 23);
            this.btnAverage.TabIndex = 5;
            this.btnAverage.Text = "&Average";
            this.btnAverage.UseVisualStyleBackColor = true;
            this.btnAverage.Click += new System.EventHandler(this.BtnAverage_Click);
            // 
            // btnPrice
            // 
            this.btnPrice.Location = new System.Drawing.Point(183, 181);
            this.btnPrice.Name = "btnPrice";
            this.btnPrice.Size = new System.Drawing.Size(75, 23);
            this.btnPrice.TabIndex = 6;
            this.btnPrice.Text = "&Price<=5.00";
            this.btnPrice.UseVisualStyleBackColor = true;
            this.btnPrice.Click += new System.EventHandler(this.BtnPrice_Click);
            // 
            // btnSortAlpha
            // 
            this.btnSortAlpha.Location = new System.Drawing.Point(21, 210);
            this.btnSortAlpha.Name = "btnSortAlpha";
            this.btnSortAlpha.Size = new System.Drawing.Size(75, 23);
            this.btnSortAlpha.TabIndex = 7;
            this.btnSortAlpha.Text = "&Sort Alpha";
            this.btnSortAlpha.UseVisualStyleBackColor = true;
            this.btnSortAlpha.Click += new System.EventHandler(this.BtnSortAlpha_Click);
            // 
            // btnClear
            // 
            this.btnClear.Location = new System.Drawing.Point(102, 210);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(75, 23);
            this.btnClear.TabIndex = 8;
            this.btnClear.Text = "&Clear";
            this.btnClear.UseVisualStyleBackColor = true;
            this.btnClear.Click += new System.EventHandler(this.BtnClear_Click);
            // 
            // btnExit
            // 
            this.btnExit.Location = new System.Drawing.Point(183, 210);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(75, 23);
            this.btnExit.TabIndex = 9;
            this.btnExit.Text = "E&xit";
            this.btnExit.UseVisualStyleBackColor = true;
            this.btnExit.Click += new System.EventHandler(this.BtnExit_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(276, 244);
            this.Controls.Add(this.btnExit);
            this.Controls.Add(this.btnClear);
            this.Controls.Add(this.btnSortAlpha);
            this.Controls.Add(this.btnPrice);
            this.Controls.Add(this.btnAverage);
            this.Controls.Add(this.btnDisplay);
            this.Controls.Add(this.lstShow);
            this.Controls.Add(this.btnEnter);
            this.Controls.Add(this.txtPrice);
            this.Controls.Add(this.txtName);
            this.Controls.Add(this.lblPrice);
            this.Controls.Add(this.lblName);
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblName;
        private System.Windows.Forms.Label lblPrice;
        private System.Windows.Forms.TextBox txtName;
        private System.Windows.Forms.TextBox txtPrice;
        private System.Windows.Forms.Button btnEnter;
        private System.Windows.Forms.ListBox lstShow;
        private System.Windows.Forms.Button btnDisplay;
        private System.Windows.Forms.Button btnAverage;
        private System.Windows.Forms.Button btnPrice;
        private System.Windows.Forms.Button btnSortAlpha;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Button btnExit;
    }
}

