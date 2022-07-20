Source code -> branch master

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
- Autolayout
- Test JSON parsing using mockJSON
- Độ chính xác vòng quay tới lúc hiện tại: 100%
- Chuyển vòng quay thành UIView

**Chưa làm**
- đưa background của vòng quay may mắn vào UI
- Nối dữ liệu với database
- call APIs

**Đang làm**

Lists of UI:
- introTitle
- titleView
- titleBackground
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

![Simulator Screen Shot - iPod touch (7th generation) - 2022-07-15 at 17 06 35](https://user-images.githubusercontent.com/91571142/179202883-27d6f3c3-5ccd-45b3-a795-2148ed3ca4a5.png)
![Simulator Screen Shot - iPod touch (7th generation) - 2022-07-15 at 17 06 20](https://user-images.githubusercontent.com/91571142/179202898-6aba9b8a-d6a6-4579-9b60-56934f4f8f35.png)
![Simulator Screen Shot - iPod touch (7th generation) - 2022-07-15 at 17 06 22](https://user-images.githubusercontent.com/91571142/179202901-d090b404-a4f7-4013-a3bf-99a505796496.png)
![Simulator Screen Shot - iPod touch (7th generation) - 2022-07-15 at 17 06 11](https://user-images.githubusercontent.com/91571142/179202909-03a05efa-c0d8-41d5-be42-4cd5f842321a.png)
![Simulator Screen Shot - iPod touch (7th generation) - 2022-07-20 at 12 17 24](https://user-images.githubusercontent.com/91571142/179904378-d80a17da-5a2f-4f7f-81fe-2290876bf280.png)
![Simulator Screen Shot - iPod touch (7th generation) - 2022-07-20 at 12 17 14](https://user-images.githubusercontent.com/91571142/179904391-15377016-26da-4762-953d-d47540dd7fc4.png)
![Simulator Screen Shot - iPod touch (7th generation) - 2022-07-20 at 12 16 58](https://user-images.githubusercontent.com/91571142/179904392-3ce70dca-c0a2-44eb-8d2a-1188fc328273.png)

