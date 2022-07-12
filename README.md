**Đã làm**
    - Build UI cơ bản (các label, nút bấm)
    - Tạo models (người chơi, phần thưởng, người chơi chiến thắng)
    - Build nền của hình tròn và các phần của hình tròn (được chia bằng biến numberOfSectors)
    - Viết thuật toán tính toán góc đo giữa các phần
    - Lấy số radian cách biệt từ vị trí ban đầu làm định vị cho phần thưởng rơi trúng (tại điểm 1.0, 0.5) tức bên trái đường tròn
    - Vòng quay sau khi quay sẽ tự trở về hay nhảy đến vị trí giữa của phần vòng tròn gần nhất
    - Khi kết thúc vòng quay thì present Alert để thông báo giải thưởng trúng được
    - Build alert view để nhập voucher để tăng lượt quay (không quay khi lượt quay = 0, mỗi lần quay giảm 1)
    - Hầu hết số liệu là biến
    - Build tableview và pop-up view cho button cơ cấu, trúng giải, thưởng

**Chưa làm**
    - Fix một số bug nhỏ (như các số đo góc chưa chính xác và có độ lệch khi quay nhiều lần)
    - đưa background của vòng quay may mắn vào UI
    - Nối dữ liệu với database
    - call APIs

**Đang làm**
    - Partition code (đưa vòng tròn thành object)
    - Auto layout

Lists of UI:
- buttonsContainer
- coCaubtn
- thuongBtn
- trungGiaiBtn
- coCauLabel
- thuongLabel
- trungGiaiLabel
- lanQuayContainer
- lanQuayLbl (lan quay)
- lanQuayLabel (0)
- lanQuayBtn

