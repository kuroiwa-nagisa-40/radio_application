import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="programs"
export default class extends Controller {
  static targets = ["title", "value"];

  connect() {
    this.initializeTooltip();
    this.truncateTitle();
  }

  initializeTooltip() {
    // カードの高さが100px以下の場合、Tooltip を有効にする
    if (this.element.clientHeight <= 100) {
      this.tooltip = new bootstrap.Tooltip(this.titleTarget, {
        placement: "top",
        title: this.titleTarget.textContent
      });
    }
  }

  disposeTooltip() {
    // コントローラーが削除されたときに Tooltip を破棄
    if (this.tooltip) {
      this.tooltip.dispose();
    }
  }

  truncateTitle() {
    const originalTitle = this.titleTarget.textContent.trim();
    const maxHeight = 70; // 最大の高さ（ピクセル単位）を設定
    
    // 高さが100px以下の場合、最初の5文字を表示し、残りは"..."で省略
    if (this.element.clientHeight < maxHeight) {
      // 高さが最大値を超えた場合、省略表示を行う
      const truncatedTitle = originalTitle.substring(0, 7) + '...';
      this.titleTarget.textContent = truncatedTitle;
    } else {
      this.titleTarget.textContent = originalTitle;
    }
  }
}