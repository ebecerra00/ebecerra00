using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BecerraEstevan_MockLabExam
{
    public partial class Form1 : Form
    {
        private const int cSize = 20;
        private string[] mName = new string [cSize];
        private double[] mPrice = new double[cSize];
        private int mIndex = 0;

        public Form1()
        {
            InitializeComponent();
        }

        private void DisplayMessageboxOK(string message)
        {
            MessageBox.Show(message, Text, MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private bool ValidateInput()
        {
            double Price;

            if(txtName.Text == "")
            {
                DisplayMessageboxOK("Must enter name");
                txtName.Focus();
                return false;
            }

            if(double.TryParse(txtPrice.Text, out Price)==false)
            {
                DisplayMessageboxOK("Price must be a number");
                txtPrice.Focus();
                return false;
            }

            if(Price<=0)
            {
                DisplayMessageboxOK("Price must be greater than 0");
                txtPrice.Focus();
                return false;
            }

            return true;
        }

        private void BtnEnter_Click(object sender, EventArgs e)
        {
            string Name;
            double Price;

            if(ValidateInput() == false)
            {
                return;
            }

            Name = txtName.Text;
            Price = double.Parse(txtPrice.Text);

            mName[mIndex] = Name;
            mPrice[mIndex] = Price;
            mIndex++;

            if(mIndex == cSize)
            {
                DisplayMessageboxOK("Array is full");
                btnEnter.Enabled = false;
            }

            txtName.Clear();
            txtPrice.Clear();
            txtName.Focus();
        }

        private void BtnDisplay_Click(object sender, EventArgs e)
        {
            lstShow.Items.Clear();

            if(mIndex == 0)
            {
                DisplayMessageboxOK("Array is empty");
                return;
            }

            lstShow.Items.Add("Name" + "\t" + "Price");
            lstShow.Items.Add("==============");

            for (int k = 0; k < mIndex; k++)
            {
                lstShow.Items.Add(mName[k] + "\t" + mPrice[k]);
            }
        }

        private void BtnAverage_Click(object sender, EventArgs e)
        {
            lstShow.Items.Clear();
            if(mIndex == 0)
            {
                DisplayMessageboxOK("Array is empty");
                return;
            }

            double Avg;
            double Sum = 0;

            for(int k = 0; k<mIndex; k++)
            {
                Sum = Sum + +mPrice[k];
            }

            Avg = Sum / mIndex;

            lstShow.Items.Add("Average: " + Avg.ToString("N2"));
        }

        private void BtnPrice_Click(object sender, EventArgs e)
        {
            lstShow.Items.Clear();

            if(mIndex == 0)
            {
                DisplayMessageboxOK("Array is empty");
                return;
            }

            bool flag = false;

            lstShow.Items.Add("Name" + "\t" + "Price");
            lstShow.Items.Add("==============");

            for (int k = 0; k < mIndex; k++)
            {
                if(mPrice[k] <= 5.00)
                {
                    flag = true;
                    lstShow.Items.Add(mName[k] + "\t" + mPrice[k]);
                   
                }

                //This needs to be out of the for loop
                if(flag == false)
                {
                    DisplayMessageboxOK("There are no items under $5");
                    lstShow.Items.Clear();
                }

            }

        }

        private void BtnSortAlpha_Click(object sender, EventArgs e)
        {
            lstShow.Items.Clear();
            if(mIndex == 0)
            {
                DisplayMessageboxOK("Array is empty");
                return;
            }

            lstShow.Items.Add("Name" + "\t" + "Price");
            lstShow.Items.Add("==============");

            Array.Sort(mName, mPrice, 0, mIndex);

            for(int k =0; k < mIndex; k++)
            {
                lstShow.Items.Add(mName[k] + "\t" + mPrice[k]);
            }
        }

        private void BtnClear_Click(object sender, EventArgs e)
        {
            txtName.Clear();
            txtPrice.Clear();
            lstShow.Items.Clear();
        }

        private void BtnExit_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
