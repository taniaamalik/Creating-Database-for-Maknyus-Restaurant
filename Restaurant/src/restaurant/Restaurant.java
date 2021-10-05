package restaurant;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class Restaurant {

    static String url = "jdbc:sqlserver://ASUS;databaseName=RestaurantMaknyus;integratedSecurity=true";

    public static void main(String[] args) {
        Connection conn = null;
        Restaurant resto = new Restaurant();
        Scanner in = new Scanner(System.in);
        try {
            conn = DriverManager.getConnection(url);
            int pil;
            do {
                System.out.println("");
                System.out.println("========== Restoran Maknyus ==========");
                System.out.println("1. Tambah Pemesan Antar");
                System.out.println("2. Tambah Pembeli Ditempat");
                System.out.println("3. Cek Penjualan");
                System.out.println("4. Tambah Pegawai");
                System.out.println("5. Keluar");
                System.out.print("Masukkan Pilihan : ");
                pil = in.nextInt();
                switch (pil) {
                    case 1:
                        System.out.print("Masukkan ID Pegawai : ");
                        String IDPegawai = in.next();
                        System.out.print("Masukkan ID Pemesan : ");
                        String IDPemesan = in.next();
                        System.out.print("Masukkan Nama Pemesan :");
                        String namaPemesan = in.next();
                        System.out.print("Masukkan Alamat : ");
                        String alamat = in.next();
                        System.out.print("Masukkan Kelurahan : ");
                        String kelurahan = in.next();
                        System.out.print("Masukkan Nomor Hp : ");
                        String nomorHp = in.next();
                        System.out.print("Masukkan Struk Jual : ");
                        String StrukJual = in.next();
                        System.out.print("Masukkan Tanggal Pesan : ");
                        String tanggalPesan = in.next();
                        resto.insertPemesanAntar(conn, IDPemesan, namaPemesan, alamat, kelurahan, nomorHp, StrukJual, tanggalPesan, IDPegawai);
                        System.out.println("");
                        System.out.println("Pesan Apa?\n 1. Makanan\n 2. Minuman\n 3. Keduanya ");
                        System.out.print("Masukkan pilihan : ");
                        int pesan = in.nextInt();

                        switch (pesan) {
                            case 1:
                                resto.pesanMakanan(conn, StrukJual);
                                break;
                            case 2:
                                resto.pesanMinuman(conn, StrukJual);
                                break;
                            case 3:
                                resto.pesanMakanan(conn, StrukJual);
                                resto.pesanMinuman(conn, StrukJual);
                        }

                        break;

                    case 2:
                        System.out.print("Masukkan ID Pegawai : ");
                        String IDPegawai2 = in.next();
                        System.out.print("Masukkan Struk Jual : ");
                        String StrukJual2 = in.next();
                        System.out.print("Masukkan Tanggal Beli : ");
                        String tanggalbeli = in.next();
                        resto.insertPenjualan(conn, StrukJual2, tanggalbeli, IDPegawai2);

                        System.out.println("Pesan Apa?\n 1. Makanan\n 2. Minuman\n 3. Keduanya ");
                        System.out.print("Masukkan pilihan : ");
                        int pesan2 = in.nextInt();
                        switch (pesan2) {
                            case 1:
                                resto.pesanMakanan(conn, StrukJual2);
                                break;
                            case 2:
                                resto.pesanMinuman(conn, StrukJual2);
                                break;
                            case 3:
                                resto.pesanMakanan(conn, StrukJual2);
                                resto.pesanMinuman(conn, StrukJual2);
                                break;
                        }
                        break;

                    case 3:
                        resto.SelectPenjualan(conn);
                        break;
                    case 4:
                        System.out.print("Masukkan ID Pegawai : ");
                        String IDPegawai3 = in.next();
                        System.out.print("Masukkan Nama Pegawai :");
                        String namaPegawai = in.next();
                        System.out.print("Masukkan Jalan : ");
                        String jalan = in.next();
                        System.out.print("Masukkan Kelurahan : ");
                        String kelurahan2 = in.next();
                        System.out.print("Masukkan Jobdesk : ");
                        String jobdesk = in.next();
                        System.out.print("Masukkan Gaji : ");
                        int gaji = in.nextInt();
                        resto.insertPegawai(conn, IDPegawai3, namaPegawai, jalan, kelurahan2, jobdesk, gaji);
                        break;
                    
                }
            } while (pil < 5);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void pesanMakanan(Connection conn, String StrukJual) throws SQLException {
        String pesan;
        Scanner in = new Scanner(System.in);
        System.out.println("");
        SelectMakanan(conn);
        do {
            System.out.println("");
            System.out.print("Masukkan ID Makanan : ");
            String idMakanan = in.next();
            System.out.print("Jumlah : ");
            int jumlahMakanan = in.nextInt();
            TambahMakanan(conn, StrukJual, jumlahMakanan, idMakanan);
            System.out.print("Pesan Lagi (y/t)? : ");
            pesan = in.next();
        } while (pesan.equals("y"));
        System.out.println("");
        SelectPenjualan(conn);
        System.out.println("");
    }

    public void pesanMinuman(Connection conn, String StrukJual) throws SQLException {
        String pesan;
        Scanner in = new Scanner(System.in);
        System.out.println("");
        SelectMinuman(conn);
        do {
            System.out.println("");
            System.out.print("Masukkan ID Minuman : ");
            String idMinuman = in.next();
            System.out.print("Jumlah : ");
            int jumlahMinuman = in.nextInt();
            TambahMinuman(conn, StrukJual, jumlahMinuman, idMinuman);
            System.out.print("Pesan Lagi (y/t)? : ");
            pesan = in.next();

        } while (pesan.equals("y"));
        System.out.println("");
        SelectPenjualan(conn);
        System.out.println("");
    }
    
    public void insertPegawai(Connection conn, String IDPegawai, String nama, String Jalan, String Kelurahan, String Jobdesk, int Gaji) throws SQLException {
        Statement st = conn.createStatement();
        st.executeUpdate("insert into Pegawai values ( " + "'" + IDPegawai + "'," + "'" + nama + "'," + "'" + Jalan + "'," + "'" + Kelurahan + "'," + "'" + Jobdesk + "'," +Gaji + ")");
    }
    
    
    //exec TambahPemesanAntar '801021', 'Alya', 'Jl.Veteran', 'Kel. Lowokwaru', '08223134562','180021', '20181205', '40303'
    public void insertPemesanAntar(Connection conn, String IDPemesan, String nama, String Jalan, String Kelurahan, String nomorHP, String StrukJual, String Tanggal, String IDPeg) throws SQLException {
        Statement st = conn.createStatement();
        st.executeUpdate("exec TambahPemesanAntar " + "'" + IDPemesan + "'," + "'" + nama + "'," + "'" + Jalan + "'," + "'" + Kelurahan + "'," + "'" + nomorHP + "'," + "'" + StrukJual + "'," + "'" + Tanggal + "'," + "'" + IDPeg + "'");
    }

//    exec TambahPenjualan4 '180022', '20181205', '50702'
    public void insertPenjualan(Connection conn, String StrukJual, String Tanggal, String IDPeg) throws SQLException {
        Statement st = conn.createStatement();
        st.executeUpdate("exec TambahPenjualan4 " + "'" + StrukJual + "'," + "'" + Tanggal + "'," + "'" + IDPeg + "'");
    }

    public void TambahMakanan(Connection conn, String StrukJual, int jumlahMakanan, String IDMakanan) throws SQLException {
        Statement st2 = conn.createStatement();
        st2.executeUpdate("exec TambahMakanan " + "'" + StrukJual + "'," + "'" + jumlahMakanan + "'," + "'" + IDMakanan + "'");
    }

    public void TambahMinuman(Connection conn, String StrukJual, int jumlahMinuman, String IDMinuman) throws SQLException {
        Statement st = conn.createStatement();
        st.executeUpdate("exec TambahMinuman " + "'" + StrukJual + "'," + "'" + jumlahMinuman + "'," + "'" + IDMinuman + "'");
    }

    public void SelectPenjualan(Connection conn) throws SQLException {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("select*from Penjualan");
        System.out.println("======================== Tabel Penjualan ========================");
        System.out.println("| Struk Jual |    Tanggal       | Harga Total   |  ID Pegawai");
        System.out.println("=================================================================");
        while (rs.next()) {
            String StrukJual = rs.getString(1);
            String tanggal = rs.getString(2);
            Integer hargaTotal = rs.getInt(3);
            String IDPeg = rs.getString(4);
            System.out.println("|  " + StrukJual + "    |    " + tanggal + "    |  " + hargaTotal + "\t|  " + IDPeg);
        }
    }

    public void SelectMakanan(Connection conn) throws SQLException {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("select*from Makanan");
        System.out.println("=========================== Tabel Makanan =======================");
        System.out.println("|ID Makanan|   Nama Makanan\t\t\t| Harga Makanan");
        System.out.println("=================================================================");
        while (rs.next()) {
            String IDMak = rs.getString(1);
            String NamaMak = rs.getString(2);
            Integer hargaMak = rs.getInt(3);
            System.out.printf("|  " + IDMak + "    |    " + "%-30s\t|  " + hargaMak, NamaMak);
            System.out.println("");
        }
    }

    public void SelectMinuman(Connection conn) throws SQLException {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("select*from Minuman");
        System.out.println("=========================== Tabel Minuman =======================");
        System.out.println("|ID Makanan|   Nama Minuman\t\t | Harga Minuman");
        System.out.println("===========================================================");
        while (rs.next()) {
            String IDMin = rs.getString(1);
            String NamaMin = rs.getString(2);
            Integer hargaMin = rs.getInt(3);
            System.out.printf("|  " + IDMin + "    |    " + "%-25s|  " + hargaMin, NamaMin);
            System.out.println("");
        }
    }
}
